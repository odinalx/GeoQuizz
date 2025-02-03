<script setup>
import { RouterLink, RouterView } from 'vue-router'
import HelloWorld from './components/HelloWorld.vue'
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="max-w-7xl mx-auto py-6 px-4">
        <img 
          alt="Vue logo" 
          class="h-32 w-auto mx-auto" 
          src="@/assets/logo.svg"
        />

        <div class="mt-6">
          <HelloWorld msg="You did it!" />

          <nav class="mt-4 space-x-4 text-center">
            <RouterLink 
              class="text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
              :class="{ 'bg-gray-100': $route.name === 'home' }"
              to="/"
            >
              Home
            </RouterLink>
            <RouterLink 
              class="text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
              :class="{ 'bg-gray-100': $route.name === 'about' }"
              to="/about"
            >
              About
            </RouterLink>
          </nav>
        </div>
      </div>
    </header>

    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <RouterView />
    </main>
  </div>
</template>

<style>
@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;
    padding: 1rem 0;
    margin-top: 1rem;
  }

  nav a:first-of-type {
    border: 0;
  }
}
</style>
