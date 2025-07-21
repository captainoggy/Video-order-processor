/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/components/**/*.{rb,erb,html,slim}',
    './app/components/**/*.{rb,erb,html,slim}',
    './app/helpers/components/**/*.{rb,erb,html,slim}',
  ],
  theme: {
    extend: {
      colors: {
        'background': '#0D0D0D', // Near black
        'primary': '#1A1A1A',   // Very dark gray
        'secondary': '#2A2A2A', // Dark gray
        'accent': {
          'blue': '#00BFFF',   // Deep sky blue
          'pink': '#FF00FF',   // Magenta
          'green': '#39FF14',  // Neon green
        },
        'text-primary': '#E0E0E0', // Light gray
        'text-secondary': '#A0A0A0', // Medium gray
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}