<script setup>
import { ref, onMounted, watch, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useGameStore } from '@/stores/gameStore'
import MapComponent from '@/components/Game/MapComponent.vue'
import PhotoDisplay from '@/components/Game/PhotoDisplay.vue'
import ScoreBoard from '@/components/Game/ScoreBoard.vue'
import GameTimer from '@/components/Game/GameTimer.vue'

const route = useRoute()
const router = useRouter()
const gameStore = useGameStore()

const selectedLocation = ref(null)
const timeLeft = ref(60)
const error = ref(null)
const showFinalScore = ref(false)
const finalScore = ref(0)
const showMap = ref(true)

const startTimer = () => {
  const timer = setInterval(() => {
    timeLeft.value--
    if (timeLeft.value <= 0) {
      clearInterval(timer)
      handleTimeUp()
    }
  }, 1000)
}

const handleTimeUp = async () => {
  try {
    await gameStore.finishGame(route.query.id)
    await showGameResults()
  } catch (err) {
    error.value = err.message
  }
}

const showGameResults = async () => {
  try {
    const gameDetails = await gameStore.fetchGameDetails(route.query.id)
    finalScore.value = gameDetails.score || gameDetails.data.score
    showMap.value = false
    showFinalScore.value = true
    
    setTimeout(() => {
      router.push('/home')
    }, 3000)
  } catch (err) {
    console.error('Erreur lors de la récupération des résultats:', err)
    error.value = err.message
    router.push('/home')
  }
}

const handleLocationSelect = async (location) => {
  try {
    selectedLocation.value = location
    
    if (gameStore.currentPhoto) {
      const moveData = {
        photoid: gameStore.currentPhoto.id,
        lat: location.lat,
        long: location.lng,
        time: 60 - timeLeft.value
      }
      
      const response = await gameStore.playMove(route.query.id, moveData)
      
      if (gameStore.currentPhotoIndex >= 9) {
        await gameStore.finishGame(route.query.id)
        await showGameResults()
      } else {
        timeLeft.value = 60
      }
    }
  } catch (err) {
    console.error('Error in handleLocationSelect:', err)
    error.value = err.message
  }
}

onMounted(async () => {
  try {
    if (!route.query.id) {
      router.push('/game')
      return
    }
    
    await gameStore.fetchGameDetails(route.query.id)
    if (gameStore.status !== 'STARTED') {
      router.push('/game')
      return
    }
    
    startTimer()
  } catch (err) {
    error.value = err.message
    router.push('/game')
  }
})

onUnmounted(() => {
  gameStore.resetGame()
})

watch(() => gameStore.error, (newError) => {
  if (newError) {
    error.value = newError
  }
})
</script>

<template>
  <div class="px-4">
    <div 
      v-if="error"
      class="fixed top-4 right-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
      role="alert"
    >
      <span class="block sm:inline">{{ error }}</span>
    </div>

    <div 
      v-if="showFinalScore"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white p-8 rounded-xl shadow-lg text-center animate-fade-in">
        <h2 class="text-2xl font-bold text-slate-800 mb-4">Partie terminée !</h2>
        <p class="text-3xl text-indigo-600 font-bold mb-4">{{ finalScore }} points</p>
        <p class="text-slate-600">Redirection vers l'accueil...</p>
      </div>
    </div>

    <div class="grid grid-cols-1" :class="{ 'lg:grid-cols-2': !showFinalScore }">
      <div class="flex flex-col h-full">
        <div class="flex-grow">
          <PhotoDisplay 
            :photo="gameStore.currentPhoto"
            class="h-full" 
          />
        </div>
        <div class="grid grid-cols-2 gap-6 pt-4">
          <ScoreBoard :score="gameStore.score" />
          <GameTimer :time-left="timeLeft" />
        </div>
      </div>
      <MapComponent 
        v-if="showMap"
        class="h-full"
        height="600px"
        @location-selected="handleLocationSelect"
      />
    </div>
  </div>
</template>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
</style>
