<script setup>
defineProps({
  to: {
    type: String,
    default: undefined
  }
})
</script>

<template>
  <RouterLink
    v-if="to"
    :to="to"
    class="inline-flex items-center justify-center rounded-lg text-white font-medium shadow-lg hover:shadow-xl transition-all duration-300"
  >
    <slot />
  </RouterLink>
  <button
    v-else
    class="inline-flex items-center justify-center rounded-lg text-white font-medium shadow-lg hover:shadow-xl transition-all duration-300"
  >
    <slot />
  </button>
</template> 