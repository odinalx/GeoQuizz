<script setup>
import Button from '@/components/UI/Button.vue'
</script>

<template>
  <div class="flex flex-col items-center gap-6">
    <h1 class="text-5xl font-bold mb-6 text-slate-800">
      Bienvenue sur <span class="text-indigo-600">GeoQuizz</span>
    </h1>
    
    <p class="text-xl text-slate-600 mb-12 max-w-2xl text-center leading-relaxed">
      Testez vos connaissances géographiques en localisant des lieux à partir de photos. 
      Plus vous êtes précis, plus vous gagnez de points !
    </p>
    
    <div class="flex gap-6">
      <Button 
        to="/game" 
        class="bg-indigo-600 hover:bg-indigo-700 px-8 py-4 text-lg"
      >
        Commencer une partie
      </Button>
      <Button 
        to="/home"
        class="bg-slate-700 hover:bg-slate-800 px-8 py-4 text-lg"
      >
        Voir les parties publiques
      </Button>
    </div>
  </div>
</template> 