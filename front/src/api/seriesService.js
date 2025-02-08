const API_URL = 'http://localhost:33556'

export const seriesService = {
  async getSeries(token) {
    const response = await fetch(`${API_URL}/items/series`, {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors de la récupération des séries')
    }

    return await response.json()
  }
} 