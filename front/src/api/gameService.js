const API_URL = 'http://gateway.geoquizz:33554'

export const gameService = {
  async createGame(token, data) {
    console.log('Creating game with data:', data)
    const response = await fetch(`${API_URL}/games`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({
        creatorId: data.creatorId,
        serieId: data.serieId
      }),
      mode: 'cors'
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors de la création de la partie')
    }

    const result = await response.json()
    console.log('Create game response:', result)
    return result
  },

  async getGame(token, gameToken, id) {
    if (!id) {
      throw new Error('ID de partie manquant')
    }
    console.log('Getting game:', id, 'with token:', gameToken)
    const response = await fetch(`${API_URL}/games/${id}`, {
      headers: {
        'X-Game-Token': gameToken,
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      mode: 'cors'
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors de la récupération de la partie')
    }

    const result = await response.json()
    console.log('Get game response:', result)
    return result
  },

  async startGame(token, gameToken, id) {
    if (!id) {
      throw new Error('ID de partie manquant')
    }
    if (!gameToken) {
      throw new Error('Game token manquant')
    }
    console.log('Starting game:', id)
    console.log('With auth token:', token)
    console.log('With game token:', gameToken)
    
    const headers = {
      'X-Game-Token': gameToken,
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
    console.log('Headers envoyés:', {
      'X-Game-Token': headers['X-Game-Token'],
      'Authorization': headers['Authorization'],
      'Content-Type': headers['Content-Type']
    })

    const response = await fetch(`${API_URL}/games/${id}/start`, {
      method: 'PATCH',
      headers: headers,
      mode: 'cors'
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors du démarrage de la partie')
    }

    const result = await response.json()
    console.log('Start game response:', result)
    return result
  },

  async finishGame(token, gameToken, id) {
    const response = await fetch(`${API_URL}/games/${id}/finish`, {
      method: 'PATCH',
      headers: {
        'X-Game-Token': gameToken,
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      mode: 'cors'
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors de la fin de la partie')
    }

    return await response.json()
  },

  async playMove(token, gameToken, id, moveData) {
    console.log('Playing move:', moveData)
    
    // Créer l'objet de données explicitement
    const bodyData = {
      photoid: moveData.photoid,
      lat: moveData.lat,
      long: moveData.long,
      time: moveData.time
    }
    
    console.log('Sending body:', JSON.stringify(bodyData)) // Log pour vérifier ce qui est envoyé

    const response = await fetch(`${API_URL}/games/${id}/play`, {
      method: 'POST',
      headers: {
        'X-Game-Token': gameToken,
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(bodyData),
      mode: 'cors'
    })

    if (!response.ok) {
      const error = await response.json()
      console.error('Error response:', error) // Log l'erreur complète
      throw new Error(error.message || 'Erreur lors du coup joué')
    }

    const result = await response.json()
    console.log('Play move response:', result)
    return result
  }
}
