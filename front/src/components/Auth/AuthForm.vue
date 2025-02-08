<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'
import BaseButton from '@/components/UI/BaseButton.vue'

const router = useRouter()
const authStore = useAuthStore()

const props = defineProps({
  isLogin: {
    type: Boolean,
    default: true
  }
})

const isLogin = ref(props.isLogin)
const isLoading = ref(false)
const error = ref('')
const hasAttemptedSubmit = ref(false)

const formData = ref({
  username: '',
  email: '',
  password: '',
  confirmPassword: ''
})

const validationErrors = computed(() => {
  if (!hasAttemptedSubmit.value) return {}
  
  const errors = {}
  
  if (!formData.value.email) {
    errors.email = 'Email requis'
  } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.value.email)) {
    errors.email = 'Email invalide'
  }

  if (!formData.value.password) {
    errors.password = 'Mot de passe requis'
  } else if (formData.value.password.length < 6) {
    errors.password = 'Le mot de passe doit contenir au moins 6 caractères'
  }

  if (!isLogin.value) {
    if (!formData.value.username) {
      errors.username = "Nom d'utilisateur requis"
    }
    
    if (!formData.value.confirmPassword) {
      errors.confirmPassword = 'Confirmation du mot de passe requise'
    } else if (formData.value.password !== formData.value.confirmPassword) {
      errors.confirmPassword = 'Les mots de passe ne correspondent pas'
    }
  }

  return errors
})

const isFormValid = computed(() => Object.keys(validationErrors.value).length === 0)

const handleSubmit = async () => {
  try {
    hasAttemptedSubmit.value = true
    if (!isFormValid.value) return
    
    isLoading.value = true
    error.value = ''

    if (isLogin.value) {
      await authStore.login({
        email: formData.value.email,
        password: formData.value.password
      })
    } else {
      await authStore.register({
        email: formData.value.email,
        password: formData.value.password
      })
    }

    router.push('/home')
  } catch (err) {
    error.value = err.message || "Une erreur s'est produite"
  } finally {
    isLoading.value = false
  }
}

const toggleForm = () => {
  if (isLogin.value) {
    router.push('/register')
  } else {
    router.push('/login')
  }
}
</script>

<template>
  <div class="bg-white p-8 rounded-lg shadow-sm w-full max-w-md">
    <h2 class="text-2xl font-bold text-slate-800 mb-6 text-center">
      {{ isLogin ? 'Connexion' : 'Inscription' }}
    </h2>

    <div v-if="error" class="mb-4 p-3 bg-red-100 text-red-700 rounded-md text-sm">
      {{ error }}
    </div>

    <form @submit.prevent="handleSubmit" class="space-y-4">
      <div v-if="!isLogin" class="space-y-1">
        <label class="block text-sm font-medium text-slate-700">
          Nom d'utilisateur
          <span class="text-red-500 ml-1">*</span>
        </label>
        <input 
          type="text" 
          v-model="formData.username"
          class="w-full px-4 py-2 rounded-md border-2 text-slate-900 outline-none transition-colors"
          :class="{
            'border-red-500': validationErrors.username,
            'border-slate-300 focus:border-indigo-500': !validationErrors.username
          }"
        />
        <p v-if="validationErrors.username" class="text-red-600 text-xs mt-1">
          {{ validationErrors.username }}
        </p>
      </div>

      <div class="space-y-1">
        <label class="block text-sm font-medium text-slate-700">
          Email
          <span v-if="!isLogin" class="text-red-500 ml-1">*</span>
        </label>
        <input 
          type="email" 
          v-model="formData.email"
          class="w-full px-4 py-2 rounded-md border-2 text-slate-900 outline-none transition-colors"
          :class="{
            'border-red-500': validationErrors.email,
            'border-slate-300 focus:border-indigo-500': !validationErrors.email
          }"
        />
        <p v-if="validationErrors.email" class="text-red-600 text-xs mt-1">
          {{ validationErrors.email }}
        </p>
      </div>

      <div class="space-y-1">
        <label class="block text-sm font-medium text-slate-700">
          Mot de passe
          <span v-if="!isLogin" class="text-red-500 ml-1">*</span>
        </label>
        <input 
          type="password" 
          v-model="formData.password"
          class="w-full px-4 py-2 rounded-md border-2 text-slate-900 outline-none transition-colors"
          :class="{
            'border-red-500': validationErrors.password,
            'border-slate-300 focus:border-indigo-500': !validationErrors.password
          }"
        />
        <p v-if="validationErrors.password" class="text-red-600 text-xs mt-1">
          {{ validationErrors.password }}
        </p>
      </div>

      <div v-if="!isLogin" class="space-y-1">
        <label class="block text-sm font-medium text-slate-700">
          Confirmer le mot de passe
          <span class="text-red-500 ml-1">*</span>
        </label>
        <input 
          type="password" 
          v-model="formData.confirmPassword"
          class="w-full px-4 py-2 rounded-md border-2 text-slate-900 outline-none transition-colors"
          :class="{
            'border-red-500': validationErrors.confirmPassword,
            'border-slate-300 focus:border-indigo-500': !validationErrors.confirmPassword
          }"
        />
        <p v-if="validationErrors.confirmPassword" class="text-red-600 text-xs mt-1">
          {{ validationErrors.confirmPassword }}
        </p>
      </div>

      <p v-if="!isLogin" class="text-sm text-slate-500 mt-4">
        <span class="text-red-500">*</span> Champs obligatoires
      </p>

      <div class="h-4"></div>

      <BaseButton 
        type="submit"
        :disabled="hasAttemptedSubmit && !isFormValid || isLoading"
        class="w-full bg-indigo-600 hover:bg-indigo-700 disabled:bg-indigo-400 px-12 py-3"
      >
        <template v-if="isLoading">
          <span class="inline-block animate-spin mr-2">⌛</span>
          Chargement...
        </template>
        <template v-else>
          {{ isLogin ? 'Se connecter' : "S'inscrire" }}
        </template>
      </BaseButton>
    </form>

    <div class="mt-6 text-center">
      <button 
        @click="toggleForm"
        class="text-indigo-600 hover:text-indigo-800 text-sm font-medium px-8 py-2"
      >
        {{ isLogin ? "Pas encore de compte ? S'inscrire" : 'Déjà un compte ? Se connecter' }}
      </button>
    </div>
  </div>
</template>
