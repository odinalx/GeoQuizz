<script setup>
defineProps({
  score: {
    type: Number,
    required: true
  }
})
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-4">
    <h2 class="text-lg font-semibold text-slate-800 mb-2">Score</h2>
    <div class="text-3xl font-bold text-indigo-600">
      {{ score }} pts
    </div>
  </div>
</template>
