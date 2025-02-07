<script>
import L from "leaflet";
import { LMap, LTileLayer, LMarker } from "@vue-leaflet/vue-leaflet"; 
import "leaflet/dist/leaflet.css";

delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: new URL("leaflet/dist/images/marker-icon-2x.png", import.meta.url).href,
  iconUrl: new URL("leaflet/dist/images/marker-icon.png", import.meta.url).href,
  shadowUrl: new URL("leaflet/dist/images/marker-shadow.png", import.meta.url).href,
});

export default {
  name: "MapComponent",
  components: {
    LMap,
    LTileLayer,
    LMarker,
  },
  data() {
    return {
      zoom: 13,
      center: [48.68439, 6.18496],
      url: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      markerLatLng: null, 
      selectedCoordinates: null, 
    };
  },
  methods: {
    onMapClick(event) {
      this.markerLatLng = event.latlng; 
      this.selectedCoordinates = {
        lat: event.latlng.lat.toFixed(6),
        lng: event.latlng.lng.toFixed(6),
      };
      console.log(this.selectedCoordinates);
    },
  },
};
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-4">
    <div class="h-full bg-slate-100 rounded-lg flex items-center justify-center">
      <l-map style="height: 300px" :zoom="zoom" :center="center" @click="onMapClick">
        <l-tile-layer :url="url" :attribution="attribution"></l-tile-layer>
        <l-marker v-if="markerLatLng" :lat-lng="markerLatLng"></l-marker>
      </l-map>
    </div>
    <div v-if="selectedCoordinates" class="mt-4 text-center">
      <p class="text-gray-700 font-semibold">
        Coordonnées sélectionnées: {{ selectedCoordinates.lat }}, {{ selectedCoordinates.lng }}
      </p>
    </div>
  </div>
</template>
