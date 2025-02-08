import { defineStore } from 'pinia'
import { authService } from '@/api/authService'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    isLoggedIn: false,
    user: null,
    token: null,
    refreshToken: null,
    error: null
  }),

  actions: {
    async login(credentials) {
      try {
        this.error = null
        const response = await authService.login(credentials)
        
        if (response.success && response.data) {
          const decodedToken = this.decodeJWT(response.data.accessToken)
          
          this.token = response.data.accessToken
          this.refreshToken = response.data.refreshToken
          this.user = {
            id: decodedToken.sub,
            email: decodedToken.email,
            role: decodedToken.role
          }
          this.isLoggedIn = true

          localStorage.setItem('token', this.token)
          localStorage.setItem('refreshToken', this.refreshToken)
          localStorage.setItem('user', JSON.stringify(this.user))
        }
      } catch (error) {
        this.error = error.message
        throw error
      }
    },

    decodeJWT(token) {
      try {
        if (!token) return null
        const base64Url = token.split('.')[1]
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/')
        const jsonPayload = decodeURIComponent(atob(base64).split('').map(c => {
          return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)
        }).join(''))
        return JSON.parse(jsonPayload)
      } catch (error) {
        console.error('Erreur lors du décodage du token:', error)
        return null
      }
    },

    async register(userData) {
      try {
        this.error = null
        await authService.register(userData)
        await this.login({
          email: userData.email,
          password: userData.password
        })
      } catch (error) {
        this.error = error.message
        throw error
      }
    },

    async refreshTokenAction() {
      try {
        const response = await authService.refreshToken(this.refreshToken)
        if (response.success && response.data) {
          this.token = response.data.accessToken
          this.refreshToken = response.data.refreshToken
          
          const decodedToken = this.decodeJWT(response.data.accessToken)
          if (decodedToken) {
            this.user = {
              id: decodedToken.sub,
              email: decodedToken.email,
              role: decodedToken.role
            }
          }
          
          localStorage.setItem('token', this.token)
          localStorage.setItem('refreshToken', this.refreshToken)
          localStorage.setItem('user', JSON.stringify(this.user))
        }
      } catch (error) {
        this.logout()
        throw error
      }
    },

    async validateToken() {
      if (!this.token) return false
      return await authService.validateToken(this.token)
    },

    logout(router) {
      this.isLoggedIn = false
      this.user = null
      this.token = null
      this.refreshToken = null
      this.error = null
      
      localStorage.removeItem('token')
      localStorage.removeItem('refreshToken')
      localStorage.removeItem('user')
      
      if (router) {
        router.push('/')
      }
    },

    initializeFromStorage() {
      const token = localStorage.getItem('token')
      const refreshToken = localStorage.getItem('refreshToken')
      const user = localStorage.getItem('user')
      
      if (token && refreshToken && user) {
        this.token = token
        this.refreshToken = refreshToken
        this.user = JSON.parse(user)
        this.isLoggedIn = true
        
        this.refreshTokenAction().catch(() => this.logout())
      }
    }
  }
}) 