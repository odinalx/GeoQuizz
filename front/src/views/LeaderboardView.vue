<template>
  <div class="bg-white rounded-lg shadow">
    <div class="px-4 py-5 sm:px-6">
      <h2 class="text-2xl font-bold text-gray-900">Classement</h2>
    </div>
    <div class="border-t border-gray-200">
      <ul class="divide-y divide-gray-200">
        <li v-for="i in 5" :key="i" class="px-4 py-4 sm:px-6 hover:bg-gray-50">
          <div class="flex items-center justify-between">
            <div class="flex items-center">
              <span class="font-bold text-lg w-8">{{ i }}.</span>
              <span class="ml-4">Joueur {{ i }}</span>
            </div>
            <span class="font-bold text-green-600">{{ 1000 * (6-i) }} pts</span>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
