import { defineStore } from 'pinia'
import { gameService } from '@/api/gameService'
import { useAuthStore } from './authStore'

export const useGameStore = defineStore('game', {
  state: () => ({
    currentGame: null,
    gameToken: null,
    currentPhoto: null,
    photos: [],
    currentPhotoIndex: 0,
    score: 0,
    status: null,
    error: null,
    isLoading: false
  }),

  actions: {
    async createGame(data) {
      try {
        // Réinitialiser l'état avant de créer une nouvelle partie
        this.resetGame()
        
        this.isLoading = true
        this.error = null
        const authStore = useAuthStore()
        
        const response = await gameService.createGame(authStore.token, data)
        if (response.success && response.data) {
          this.currentGame = response.data
          this.gameToken = response.data.gameToken
          console.log('Game token saved:', this.gameToken)
        }
        return response
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.isLoading = false
      }
    },

    async startGame(gameId) {
      try {
        this.isLoading = true
        this.error = null
        const authStore = useAuthStore()
        
        if (!this.gameToken) {
          throw new Error('Game token manquant')
        }
        
        console.log('Using game token:', this.gameToken)
        const response = await gameService.startGame(authStore.token, this.gameToken, gameId)
        if (response.success && response.data) {
          this.status = response.data.status
          await this.fetchGameDetails(gameId)
        }
        return response
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.isLoading = false
      }
    },

    async fetchGameDetails(gameId) {
      try {
        this.isLoading = true
        this.error = null
        const authStore = useAuthStore()
        
        const response = await gameService.getGame(authStore.token, this.gameToken, gameId)
        this.currentGame = response.data
        this.photos = response.data.photos
        this.score = response.data.score
        this.status = response.data.status
        
        // Définir la photo courante
        if (this.photos && this.photos.length > 0) {
          this.currentPhoto = this.photos[this.currentPhotoIndex]
        }
        
        return response.data
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.isLoading = false
      }
    },

    async playMove(gameId, moveData) {
      try {
        this.isLoading = true
        this.error = null
        const authStore = useAuthStore()
        
        const response = await gameService.playMove(authStore.token, this.gameToken, gameId, moveData)
        this.score = response.data.newScore
        
        // Passer à la photo suivante
        this.currentPhotoIndex++
        if (this.currentPhotoIndex < this.photos.length) {
          this.currentPhoto = this.photos[this.currentPhotoIndex]
        }
        
        return response.data
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.isLoading = false
      }
    },

    async finishGame(gameId) {
      try {
        this.isLoading = true
        this.error = null
        const authStore = useAuthStore()
        
        const response = await gameService.finishGame(authStore.token, this.gameToken, gameId)
        this.status = response.data.status
        this.score = response.data.score
        
        return response.data
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.isLoading = false
      }
    },

    resetGame() {
      this.currentGame = null
      this.gameToken = null
      this.currentPhoto = null
      this.photos = []
      this.currentPhotoIndex = 0
      this.score = 0
      this.status = null
      this.error = null
      this.isLoading = false
    }
  }
})
