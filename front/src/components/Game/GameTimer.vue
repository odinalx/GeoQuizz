<script setup>
defineProps({
  timeLeft: {
    type: Number,
    required: true
  }
})
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-4">
    <h2 class="text-lg font-semibold text-slate-800 mb-2">Temps restant</h2>
    <div 
      class="text-3xl font-bold"
      :class="{
        'text-red-600': timeLeft < 10,
        'text-indigo-600': timeLeft >= 10
      }"
    >
      {{ timeLeft }}s
    </div>
  </div>
</template> 