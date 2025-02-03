/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'vt-c-white': '#ffffff',
        'vt-c-white-soft': '#f8f8f8',
        'vt-c-white-mute': '#f2f2f2',
        'vt-c-black': '#181818',
        'vt-c-black-soft': '#222222',
        'vt-c-black-mute': '#282828',
        'vt-c-indigo': '#2c3e50',
      },
    },
  },
  plugins: [],
} 