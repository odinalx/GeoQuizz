const API_URL = 'http://gateway.geoquizz:33554'

export const authService = {
  async register(userData) {
    const response = await fetch(`${API_URL}/auth/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email: userData.email,
        password: userData.password,
        role: "15" // Role fixe pour les utilisateurs normaux
      })
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors de l\'inscription')
    }

    return await response.json()
  },

  async login(credentials) {
    const response = await fetch(`${API_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email: credentials.email,
        password: credentials.password
      })
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Email ou mot de passe incorrect')
    }

    const data = await response.json()
    console.log('Login response:', data)
    return data
  },

  async refreshToken(refreshToken) {
    const response = await fetch(`${API_URL}/auth/refresh`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ refreshToken })
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Erreur lors du rafraîchissement du token')
    }

    const data = await response.json()
    console.log('Refresh response:', data)
    return data
  },

  async validateToken(token) {
    const response = await fetch(`${API_URL}/tokens/validate`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })

    const data = await response.json()
    console.log('Validate response:', data)
    return response.ok
  }
}
