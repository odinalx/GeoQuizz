import { defineStore } from 'pinia'
import { seriesService } from '@/api/seriesService'
import { useAuthStore } from './authStore'

export const useSeriesStore = defineStore('series', {
  state: () => ({
    series: [],
    error: null,
    isLoading: false
  }),

  actions: {
    async fetchSeries() {
      try {
        this.isLoading = true
        this.error = null
        const authStore = useAuthStore()
        
        const response = await seriesService.getSeries(authStore.token)
        this.series = response.data
        
        return this.series
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.isLoading = false
      }
    }
  }
}) 