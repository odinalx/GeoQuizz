<script setup>
import { RouterLink, RouterView } from 'vue-router'
import { ref } from 'vue'

// À remplacer plus tard par le vrai state de l'authentification
const isLoggedIn = ref(false)

const menuItems = [
  { name: 'Parties publiques', path: '/home', requiresAuth: false },
  { name: 'Jouer', path: '/game', requiresAuth: false },
  { name: 'Profile', path: '/profile', requiresAuth: true }
]
</script>

<template>
  <div class="min-h-screen bg-slate-50">
    <!-- Header avec navigation -->
    <header class="bg-white shadow-sm w-full">
      <div class="w-full mx-auto">
        <nav class="flex items-center justify-center h-20">
          <!-- Logo et titre -->
          <RouterLink to="/" class="flex items-center mr-16">
            <div class="w-10 h-10 rounded-lg flex items-center justify-center">
              <span class="text-2xl">🌍</span>
            </div>
            <h1 class="ml-3 text-2xl font-bold text-slate-800">GeoQuizz</h1>
          </RouterLink>

          <!-- Navigation -->
          <div class="flex items-center space-x-8">
            <RouterLink
              v-for="item in menuItems"
              :key="item.path"
              :to="item.path"
              v-show="!item.requiresAuth || (item.requiresAuth && isLoggedIn)"
              class="px-4 py-2 rounded-md text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-colors font-medium"
              :class="{ 'bg-slate-100 text-slate-900': $route.path === item.path }">
              {{ item.name }}
            </RouterLink>

            <!-- Bouton Connexion/Déconnexion -->
            <RouterLink
              v-if="!isLoggedIn"
              to="/login"
              class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition-colors font-medium"
            >
              Connexion
            </RouterLink>
            <button
              v-else
              @click="isLoggedIn = false"
              class="px-4 py-2 rounded-md bg-slate-600 text-white hover:bg-slate-700 transition-colors font-medium"
            >
              Déconnexion
            </button>
          </div>
        </nav>
      </div>
    </header>

    <!-- Contenu principal -->
    <main class="w-full mx-auto py-16">
      <RouterView />
    </main>
  </div>
</template>
