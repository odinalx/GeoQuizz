const API_URL = 'http://localhost:33554'

export const publicGamesService = {
  async getPublicGames(token) {
    const response = await fetch(`${API_URL}/games/public`, {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors de la récupération des parties publiques')
    }

    return await response.json()
  }
} 