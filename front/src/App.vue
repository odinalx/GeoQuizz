<script setup>
import { RouterLink, RouterView, useRouter } from 'vue-router'
import { onMounted } from 'vue'
import { useAuthStore } from '@/stores/authStore'

const router = useRouter()
const authStore = useAuthStore()

onMounted(() => {
  authStore.initializeFromStorage()
})

const handleLogout = () => {
  authStore.logout(router)
}

const menuItems = [
  { name: 'Parties publiques', path: '/home', requiresAuth: false },
  { name: 'Jouer', path: '/game', requiresAuth: false },
  { name: 'Profile', path: '/profile', requiresAuth: true }
]
</script>

<template>
  <div class="min-h-screen bg-slate-50">
    <header class="bg-white shadow-sm w-full">
      <div class="w-full mx-auto">
        <nav class="flex items-center justify-center h-20">
          <RouterLink to="/" class="flex items-center mr-16">
            <div class="w-10 h-10 rounded-lg flex items-center justify-center">
              <span class="text-2xl">🌍</span>
            </div>
            <h1 class="ml-3 text-2xl font-bold text-slate-800">GeoQuizz</h1>
          </RouterLink>

          <div class="flex items-center space-x-8">
            <RouterLink
              v-for="item in menuItems"
              :key="item.path"
              :to="item.path"
              v-show="!item.requiresAuth || (item.requiresAuth && authStore.isLoggedIn)"
              class="px-4 py-2 rounded-md text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-colors font-medium"
              :class="{ 'bg-slate-100 text-slate-900': $route.path === item.path }">
              {{ item.name }}
            </RouterLink>

            <RouterLink
              v-if="!authStore.isLoggedIn"
              to="/login"
              class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition-colors font-medium"
            >
              Connexion
            </RouterLink>
            <button
              v-else
              @click="handleLogout"
              class="px-4 py-2 rounded-md bg-slate-600 text-white hover:bg-slate-700 transition-colors font-medium"
            >
              Déconnexion
            </button>
          </div>
        </nav>
      </div>
    </header>

    <main class="w-full mx-auto py-16">
      <RouterView />
    </main>
  </div>
</template>
