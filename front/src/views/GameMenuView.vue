<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'
import BaseButton from '@/components/UI/BaseButton.vue'

const router = useRouter()
const authStore = useAuthStore()

// Liste simple de lieux
const locations = [
  { id: 1, name: 'Paris' },
  { id: 2, name: 'New York' },
  { id: 3, name: 'Tokyo' },
  { id: 4, name: 'Londres' },
  { id: 5, name: 'Berlin' },
  { id: 6, name: 'Rome' },
  { id: 7, name: 'France' },
  { id: 8, name: 'Japon' },
  { id: 9, name: 'États-Unis' },
  { id: 10, name: 'Italie' },
  { id: 11, name: 'Espagne' },
  { id: 12, name: 'Allemagne' }
]

const selectedLocation = ref(null)
const selectedDifficulty = ref('Facile')

const startGame = async () => {
  try {
    if (!selectedLocation.value) return
    
    if (!authStore.isLoggedIn) {
      router.push('/login')
      return
    }
    
    await router.push({
      name: 'game',
      params: {
        locationId: selectedLocation.value.id,
        difficulty: selectedDifficulty.value
      }
    })
  } catch (error) {
    console.error('Erreur lors du démarrage de la partie:', error)
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

      <!-- Sélection de la difficulté centrée -->
      <div class="pt-8 flex justify-center">
        <div class="w-64">
          <label class="block text-sm font-medium text-slate-700 mb-2 text-center">Difficulté</label>
          <select 
            v-model="selectedDifficulty"
            class="w-full px-4 py-2 rounded-md border border-slate-300 focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 text-slate-800"
          >
            <option>Facile</option>
            <option>Moyen</option>
            <option>Difficile</option>
          </select>
        </div>
      </div>

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
              :disabled="selectedLocation?.id !== location.id"
              class="w-full bg-indigo-600 hover:bg-indigo-700 disabled:bg-indigo-400 cursor-pointer"
            >
              Jouer
            </BaseButton>
          </div>
        </div>
      </div>
    </div>
  </div>
</template> 