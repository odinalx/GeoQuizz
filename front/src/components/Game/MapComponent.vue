<script setup>
import { onMounted, ref, nextTick } from 'vue'
import 'leaflet/dist/leaflet.css'
import { LMap, LTileLayer, LMarker } from '@vue-leaflet/vue-leaflet'
import L from 'leaflet'

// Correction du problème d'icône Leaflet
delete L.Icon.Default.prototype._getIconUrl
L.Icon.Default.mergeOptions({
  iconRetinaUrl: new URL('leaflet/dist/images/marker-icon-2x.png', import.meta.url).href,
  iconUrl: new URL('leaflet/dist/images/marker-icon.png', import.meta.url).href,
  shadowUrl: new URL('leaflet/dist/images/marker-shadow.png', import.meta.url).href,
})

// Configuration de Leaflet pour utiliser PointerEvent au lieu de MouseEvent
L.Map.mergeOptions({
  tap: false,  // Désactive le tap handler qui utilise les anciens événements
  touchZoom: true,
  dragging: true
})

const props = defineProps({
  height: {
    type: String,
    default: '500px'
  }
})

const zoom = ref(13)
const center = ref([48.6921, 6.1844])
const markerPosition = ref(null)
const mapRef = ref(null)

const handleMapClick = (event) => {
  markerPosition.value = event.latlng
  emit('location-selected', markerPosition.value)
}

const emit = defineEmits(['location-selected'])

onMounted(async () => {
  await nextTick()
  setTimeout(() => {
    if (mapRef.value) {
      const map = mapRef.value
      if (map) {
        map.$el.style.height = props.height
        window.dispatchEvent(new Event('resize'))
      }
    }
  }, 100)
})
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-4 h-full">
    <div :style="{ height: height }" class="w-full rounded-lg overflow-hidden">
      <LMap
        ref="mapRef"
        :zoom="zoom"
        :center="center"
        @click="handleMapClick"
        class="w-full h-full"
        :options="{ 
          tap: false,
          touchZoom: true,
          dragging: true
        }"
      >
        <LTileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
          layer-type="base"
        />
        <LMarker
          v-if="markerPosition"
          :lat-lng="markerPosition"
          draggable
        />
      </LMap>
    </div>
  </div>
</template>

<style scoped>
.leaflet-container {
  height: 100%;
  width: 100%;
  border-radius: 0.5rem;
  touch-action: manipulation;  /* Meilleure gestion des événements tactiles */
}

.leaflet-control-container .leaflet-control {
  z-index: 0;
}

/* Désactiver les styles spécifiques à Firefox pour les événements souris */
.leaflet-grab {
  cursor: default;
}
.leaflet-dragging .leaflet-grab {
  cursor: move;
}
</style>
