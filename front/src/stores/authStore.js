import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    isLoggedIn: false,
    user: null,
    error: null
  }),
  actions: {
    async login(credentials) {
      try {
        this.error = null
        // Appel API à implémenter
        this.isLoggedIn = true
        this.user = { /* données utilisateur */ }
      } catch (error) {
        this.error = error.message || "Erreur lors de la connexion"
        throw error
      }
    },
    logout() {
      try {
        this.isLoggedIn = false
        this.user = null
        this.error = null
      } catch (error) {
        console.error('Erreur lors de la déconnexion:', error)
      }
    }
  }
}) 