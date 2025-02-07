<script setup>
import { ref } from 'vue'

const timeLeft = ref(60)
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-4">
    <h2 class="text-lg font-semibold text-slate-800 mb-2">Temps restant</h2>
    <div class="text-3xl font-bold text-indigo-600">
      {{ timeLeft }}s
    </div>
  </div>
</template> 