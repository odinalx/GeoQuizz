<script setup>
import { useRouter } from 'vue-router'
import Button from '@/components/UI/Button.vue'

const router = useRouter()

// À remplacer par les vraies données de l'API
const publicGames = [
  { 
    id: 1, 
    title: 'Découverte de Paris', 
    difficulty: 'Facile', 
    plays: 42,
    topScores: [
      { score: 4800, player: 'JohnDoe', isAnonymous: false },
      { score: 4600, player: 'Anonymous', isAnonymous: true },
      { score: 4400, player: 'AliceGamer', isAnonymous: false },
      { score: 4200, player: 'Anonymous', isAnonymous: true },
      { score: 4000, player: 'BobPlayer', isAnonymous: false },
    ]
  },
  { 
    id: 2, 
    title: 'Tokyo by Night', 
    difficulty: 'Moyen', 
    plays: 28,
    topScores: [
      { score: 4700, player: 'TokyoFan', isAnonymous: false },
      { score: 4500, player: 'Anonymous', isAnonymous: true },
      { score: 4300, player: 'NightRider', isAnonymous: false },
      { score: 4100, player: 'Anonymous', isAnonymous: true },
      { score: 3900, player: 'CityExplorer', isAnonymous: false },
    ]
  },
  { 
    id: 3, 
    title: 'New York City', 
    difficulty: 'Difficile', 
    plays: 35,
    topScores: [
      { score: 4500, player: 'NYCFan', isAnonymous: false },
      { score: 4300, player: 'Anonymous', isAnonymous: true },
      { score: 4100, player: 'BigApple', isAnonymous: false },
      { score: 3900, player: 'Anonymous', isAnonymous: true },
      { score: 3700, player: 'CityWalker', isAnonymous: false },
    ]
  }
]
</script>

<template>
  <div class="flex justify-center px-4">
    <div class="w-full max-w-7xl">
      <h1 class="text-4xl font-bold text-slate-800 text-center">Parties Publiques</h1>
      
      <div class="mt-12 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div 
          v-for="game in publicGames" 
          :key="game.id" 
          class="bg-white rounded-xl shadow-sm overflow-hidden"
        >
          <!-- En-tête de la carte -->
          <div class="p-6">
            <h3 class="text-xl font-bold text-slate-800 mb-2 text-center">{{ game.title }}</h3>
            
            <div class="space-y-2 mb-4">
              <div class="flex justify-between text-sm">
                <span class="text-slate-600">Difficulté</span>
                <span class="font-medium" :class="{
                  'text-green-600': game.difficulty === 'Facile',
                  'text-yellow-600': game.difficulty === 'Moyen',
                  'text-red-600': game.difficulty === 'Difficile'
                }">{{ game.difficulty }}</span>
              </div>
              
              <div class="flex justify-between text-sm">
                <span class="text-slate-600">Parties jouées</span>
                <span class="font-medium text-slate-800">{{ game.plays }}</span>
              </div>
            </div>

            <Button 
              class="w-full bg-indigo-600 hover:bg-indigo-700"
              @click="router.push({ name: 'game', params: { gameId: game.id }})"
            >
              Jouer
            </Button>
          </div>

          <!-- Classement (toujours affiché) -->
          <div class="border-t border-slate-200 bg-slate-50 p-4">
            <h4 class="font-semibold text-slate-800 mb-3 text-center">Top 5</h4>
            <div class="space-y-2">
              <div 
                v-for="(score, index) in game.topScores" 
                :key="index"
                class="flex items-center justify-between text-sm py-1"
              >
                <div class="flex items-center gap-2">
                  <span class="w-5 font-medium text-slate-600">{{ index + 1 }}.</span>
                  <span :class="{ 'text-slate-500': score.isAnonymous }">
                    {{ score.player }}
                  </span>
                </div>
                <span class="font-medium text-indigo-600">{{ score.score }} pts</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
