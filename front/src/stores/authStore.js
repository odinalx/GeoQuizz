import { defineStore } from 'pinia'
import { authService } from '@/api/authService'
import { useRouter } from 'vue-router'

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
        
        this.token = response.token
        this.refreshToken = response.refreshToken
        this.user = response.user
        this.isLoggedIn = true

        localStorage.setItem('token', this.token)
        localStorage.setItem('refreshToken', this.refreshToken)
      } catch (error) {
        this.error = error.message
        throw error
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

    async refreshToken() {
      try {
        const response = await authService.refreshToken(this.refreshToken)
        this.token = response.token
        this.refreshToken = response.refreshToken
        
        localStorage.setItem('token', this.token)
        localStorage.setItem('refreshToken', this.refreshToken)
      } catch (error) {
        this.logout()
        throw error
      }
    },

    async validateToken() {
      if (!this.token) return false
      return await authService.validateToken(this.token)
    },

    logout() {
      const router = useRouter()
      
      this.isLoggedIn = false
      this.user = null
      this.token = null
      this.refreshToken = null
      this.error = null
      
      localStorage.removeItem('token')
      localStorage.removeItem('refreshToken')
      
      router.push('/')
    },

    initializeFromStorage() {
      const token = localStorage.getItem('token')
      const refreshToken = localStorage.getItem('refreshToken')
      
      if (token && refreshToken) {
        this.token = token
        this.refreshToken = refreshToken
        this.isLoggedIn = true
        this.validateToken().then(isValid => {
          if (!isValid) {
            this.refreshToken().catch(() => this.logout())
          }
        })
      }
    }
  }
}) 