<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import BaseButton from '@/components/UI/BaseButton.vue'
import { useAuthStore } from '@/stores/authStore'

const router = useRouter()
const authStore = useAuthStore()

// Données statiques pour les parties publiques
const publicGames = ref([
  {
    id: 1,
    score: 4850,
    creator: {
      username: "Victor"
    },
    serie: {
      name: "Nancy",
      difficulty: "Facile"
    },
    status: "FINISHED",
    createdAt: "2024-02-08"
  },
  {
    id: 2,
    score: 3750,
    creator: {
      username: "Alexandre"
    },
    serie: {
      name: "Nancy",
      difficulty: "Moyen"
    },
    status: "FINISHED",
    createdAt: "2024-02-08"
  },
  {
    id: 3,
    score: 4200,
    creator: {
      username: "Galo"
    },
    serie: {
      name: "Nancy",
      difficulty: "Difficile"
    },
    status: "FINISHED",
    createdAt: "2024-02-08"
  }
])

const isLoading = ref(false)
const error = ref(null)

const startNewGame = () => {
  if (!authStore.isLoggedIn) {
    router.push('/login')
    return
  }
  router.push('/game')
}
</script>

<template>
  <div class="flex justify-center px-4">
    <div class="w-full max-w-7xl">
      <div class="flex justify-between items-center mb-8">
        <h1 class="text-4xl font-bold text-slate-800">Parties Publiques</h1>
        <BaseButton 
          @click="startNewGame"
          class="bg-indigo-600 hover:bg-indigo-700 px-6 py-3"
        >
          Nouvelle Partie
        </BaseButton>
      </div>
      
      <div v-if="isLoading" class="text-center py-8">
        <span class="inline-block animate-spin mr-2">⌛</span>
        Chargement...
      </div>
      
      <div v-else-if="error" class="text-center text-red-600 py-8">
        {{ error }}
      </div>
      
      <div v-else-if="publicGames.length === 0" class="text-center text-slate-600 py-8">
        Aucune partie publique disponible
      </div>
      
      <div class="mt-12 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div 
          v-for="game in publicGames" 
          :key="game.id" 
          class="bg-white rounded-xl shadow-sm overflow-hidden cursor-pointer hover:shadow-md transition-shadow"
          @click="startNewGame"
        >
          <div class="p-6">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-xl font-bold text-slate-800">{{ game.serie.name }}</h3>
              <span class="px-3 py-1 text-sm font-medium rounded-full" 
                :class="{
                  'bg-green-100 text-green-800': game.serie.difficulty === 'Facile',
                  'bg-yellow-100 text-yellow-800': game.serie.difficulty === 'Moyen',
                  'bg-red-100 text-red-800': game.serie.difficulty === 'Difficile'
                }">
                {{ game.serie.difficulty }}
              </span>
            </div>
            
            <div class="space-y-2">
              <div class="flex justify-between text-sm">
                <span class="text-slate-600">Score</span>
                <span class="font-medium text-slate-800">{{ game.score }} pts</span>
              </div>
              
              <div class="flex justify-between text-sm">
                <span class="text-slate-600">Joueur</span>
                <span class="font-medium text-slate-800">{{ game.creator.username }}</span>
              </div>
              
              <div class="flex justify-between text-sm">
                <span class="text-slate-600">Date</span>
                <span class="font-medium text-slate-800">{{ new Date(game.createdAt).toLocaleDateString() }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
