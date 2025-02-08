<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'
import { useGameStore } from '@/stores/gameStore'
import BaseButton from '@/components/UI/BaseButton.vue'

const router = useRouter()
const authStore = useAuthStore()
const gameStore = useGameStore()

const selectedLocation = ref(null)
const isLoading = ref(false)
const error = ref(null)

// Une seule location : Nancy avec son UUID correct
const locations = ref([
  { 
    id: '85678cf6-5977-45aa-b727-8d5c677f7e41', 
    name: 'Nancy' 
  }
])

// Initialiser selectedLocation avec Nancy dès le début
selectedLocation.value = locations.value[0]

const startGame = async () => {
  try {
    if (!selectedLocation.value) return
    
    if (!authStore.isLoggedIn || !authStore.user) {
      router.push('/login')
      return
    }

    // Réinitialiser le state du jeu avant d'en créer un nouveau
    gameStore.resetGame()
    
    isLoading.value = true
    error.value = null
    
    // 1. Créer la partie
    const gameData = {
      creatorId: authStore.user.id,
      serieId: selectedLocation.value.id
    }
    
    console.log('Creating new game with:', gameData)
    const createResponse = await gameStore.createGame(gameData)
    console.log('Create response:', createResponse)
    
    if (!createResponse.success) {
      throw new Error('Échec de la création de la partie')
    }
    
    const gameId = createResponse.data.game_id
    if (!gameId) {
      throw new Error('ID de partie manquant dans la réponse')
    }

    // 2. Démarrer la partie
    const startResponse = await gameStore.startGame(gameId)
    console.log('Start response:', startResponse)

    // 3. Rediriger vers la page de jeu
    await router.push({
      name: 'game',
      query: { id: gameId }
    })
  } catch (err) {
    error.value = err.message
    console.error('Erreur lors du démarrage de la partie:', err)
  } finally {
    isLoading.value = false
  }
}
</script>

<template>
  <div class="flex justify-center px-4">
    <div class="w-full max-w-7xl relative">
      <!-- Overlay global si non connecté -->
      <div 
        v-if="!authStore.isLoggedIn"
        class="fixed inset-0 bg-slate-800/60 flex items-center justify-center z-50"
      >
        <div class="text-center bg-white p-8 rounded-xl shadow-lg max-w-md mx-4">
          <h3 class="text-xl font-bold text-slate-800 mb-4">Connexion requise</h3>
          <p class="text-slate-600 mb-6">Connectez-vous pour accéder à toutes les parties disponibles</p>
          <RouterLink 
            to="/login"
            class="inline-block px-6 py-3 bg-indigo-600 text-white font-medium rounded-md hover:bg-indigo-700 transition-colors"
          >
            Se connecter
          </RouterLink>
        </div>
      </div>

      <h1 class="text-4xl font-bold text-slate-800 text-center">Nouvelle Partie</h1>

      <!-- Liste des lieux -->
      <div class="pt-8">
        <h2 class="text-2xl font-bold pb-4 text-slate-800 text-center">Lieux</h2>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div 
            v-for="location in locations" 
            :key="location.id"
            class="bg-white rounded-xl shadow-sm p-6 transition-all duration-200 hover:shadow-md"
            :class="{ 'ring-2 ring-indigo-600': selectedLocation?.id === location.id }"
            @mouseenter="selectedLocation = location"
          >
            <h3 class="text-xl font-bold text-slate-800 text-center mb-6">{{ location.name }}</h3>

            <BaseButton 
              @click="startGame"
              :disabled="selectedLocation?.id !== location.id || isLoading"
              class="w-full bg-indigo-600 hover:bg-indigo-700 disabled:bg-indigo-400 cursor-pointer"
            >
              <template v-if="isLoading">
                <span class="inline-block animate-spin mr-2">⌛</span>
                Chargement...
              </template>
              <template v-else>
                Jouer
              </template>
            </BaseButton>
          </div>
        </div>
      </div>

      <!-- Message d'erreur -->
      <div 
        v-if="error"
        class="fixed top-4 right-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
        role="alert"
      >
        <span class="block sm:inline">{{ error }}</span>
      </div>
    </div>
  </div>
</template> 