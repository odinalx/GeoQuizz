<script setup>
import MapComponent from '@/components/Game/MapComponent.vue'
import PhotoDisplay from '@/components/Game/PhotoDisplay.vue'
import ScoreBoard from '@/components/Game/ScoreBoard.vue'
import GameTimer from '@/components/Game/GameTimer.vue'
</script>

<template>
  <div class="px-4">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 h-[calc(100vh-8rem)]">
      <div class="flex flex-col h-full">
        <div class="flex-grow">
          <PhotoDisplay class="rounded-xl shadow-lg h-full" />
        </div>
        <div class="grid grid-cols-2 gap-6 pt-4">
          <ScoreBoard class="rounded-xl shadow-lg" />
          <GameTimer class="rounded-xl shadow-lg" />
        </div>
      </div>
      <MapComponent class="rounded-xl shadow-lg h-full" />
    </div>
  </div>
</template>
