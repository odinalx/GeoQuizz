<script setup>
import { RouterLink } from 'vue-router'

const props = defineProps({
  to: {
    type: String,
    default: null
  }
})
</script>

<template>
  <RouterLink
    v-if="to"
    :to="to"
    class="inline-flex items-center justify-center px-8 py-3 rounded-lg text-white font-medium shadow-lg hover:shadow-xl transition-all duration-300"
  >
    <slot />
  </RouterLink>
  <button
    v-else
    class="inline-flex items-center justify-center px-8 py-3 rounded-lg text-white font-medium shadow-lg hover:shadow-xl transition-all duration-300"
  >
    <slot />
  </button>
</template>
