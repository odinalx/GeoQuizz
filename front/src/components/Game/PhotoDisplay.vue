<script setup>
import { ref } from 'vue'

const props = defineProps({
  photo: {
    type: Object,
    default: null
  }
})

const imageError = ref(false)

const handleImageError = () => {
  imageError.value = true
}

const getImageUrl = (photo) => {
  if (!photo || !photo.file) return ''
  return `/uploads/${photo.file}.jpg`
}
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-4">
    <div 
      v-if="photo"
      class="aspect-video bg-slate-100 rounded-lg overflow-hidden relative"
    >
      <img 
        :src="getImageUrl(photo)" 
        :alt="photo.name"
        @error="handleImageError"
        class="w-full h-full object-cover"
        :class="{ 'hidden': imageError }"
      />
      <div 
        v-if="imageError" 
        class="absolute inset-0 flex items-center justify-center text-slate-500 bg-slate-100"
      >
        <span>Image non disponible</span>
      </div>
    </div>
    <div 
      v-else 
      class="aspect-video bg-slate-100 rounded-lg flex items-center justify-center"
    >
      <span class="text-slate-400">Chargement de la photo...</span>
    </div>
  </div>
</template>

<style scoped>
.aspect-video {
  aspect-ratio: 16/9;
}
</style>
