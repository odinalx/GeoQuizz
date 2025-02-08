<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import MapComponent from '@/components/Game/MapComponent.vue'
import PhotoDisplay from '@/components/Game/PhotoDisplay.vue'
import ScoreBoard from '@/components/Game/ScoreBoard.vue'
import GameTimer from '@/components/Game/GameTimer.vue'

const route = useRoute()
const selectedLocation = ref(null)
const score = ref(0)

onMounted(() => {
  const locationId = route.query.location
  const difficulty = route.query.difficulty
  
  if (locationId && difficulty) {
    console.log(`Jeu démarré avec: Location ${locationId}, Difficulté ${difficulty}`)
  }
})

const handleLocationSelect = (location) => {
  selectedLocation.value = location
}
</script>

<template>
  <div class="px-4">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
      <div class="flex flex-col h-full">
        <div class="flex-grow">
          <PhotoDisplay class="h-full" />
        </div>
        <div class="grid grid-cols-2 gap-6 pt-4">
          <ScoreBoard :score="score" />
          <GameTimer />
        </div>
      </div>
      <MapComponent 
        class="h-full"
        height="600px"
        @location-selected="handleLocationSelect"
      />
    </div>
  </div>
</template>
