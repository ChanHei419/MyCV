<template>
  <div :class="['page', { 'dark-mode': isDarkMode }]">
    <!-- Background Clouds -->
    <div class="clouds">
      <div class="cloud cloud1"></div>
      <div class="cloud cloud2"></div>
      <div class="cloud cloud3"></div>
    </div>

    <!-- Top Banner -->
    <div class="banner">
      <div class="banner-left">Experience</div>
      <div class="banner-right">
        <button @click="toggleTheme" class="theme-btn">
          {{ isDarkMode ? '☀️ Light Mode' : '🌙 Dark Mode' }}
        </button>
        <NuxtLink to="/" class="nav-btn">Back to Home</NuxtLink>
      </div>
    </div>

    <!-- Experience Content -->
    <div class="max-w-3xl mx-auto space-y-6 px-6 py-12">
      <div class="timeline">
        <div v-for="(exp, index) in experiences" :key="index" class="card bg-white shadow-lg rounded-lg overflow-hidden relative">
          <!-- Timeline Dot -->
          <div class="timeline-dot"></div>
          <button
            @click="toggleDetails(index)"
            class="w-full flex items-center p-6 bg-gradient-to-r from-blue-500 to-blue-600 text-white hover:from-blue-600 hover:to-blue-700 transition-all duration-300"
          >
            <svg
              :class="{ 'rotate-180': openIndex === index }"
              class="w-4 h-4 mr-4 transition-transform duration-300"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
            </svg>
            <div class="text-left flex-1">
              <h3 class="text-xl font-semibold">{{ exp.title }} - {{ exp.company }}</h3>
              <p class="text-sm opacity-80">{{ exp.years }}</p>
            </div>
          </button>
          <transition name="slide">
            <div v-if="openIndex === index" class="p-6 border-t border-gray-200 bg-gray-50">
              <ul class="space-y-2">
                <li v-for="(ach, achIndex) in exp.achievements" :key="achIndex" :class="{ 'highlight': highlightedAchievement === ach }">
                  {{ ach }}
                </li>
              </ul>
              <button @click="highlightAchievement(index)" class="highlight-btn mt-4">Highlight Achievement!</button>
            </div>
          </transition>
        </div>
      </div>
    </div>

    <!-- Confetti Canvas -->
    <canvas id="confetti-canvas"></canvas>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import confetti from 'canvas-confetti'

// Theme Toggle
const isDarkMode = ref(false)
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value
}

// Experience data
const experiences = ref([
  {
    title: 'Intern',
    company: 'Company Name',
    years: 'Jan 2020 - Present',
    achievements: [
      'Responsibility or achievement 1',
      'Responsibility or achievement 2'
    ]
  },
  {
    title: 'Junior Developer',
    company: 'Tech Corp',
    years: 'Jun 2018 - Dec 2019',
    achievements: [
      'Developed a new feature for the main product',
      'Improved team workflow with automation tools'
    ]
  }
])

// Track which experience entry is open
const openIndex = ref(null)
const toggleDetails = (index) => {
  openIndex.value = openIndex.value === index ? null : index
}

// Highlight achievement
const highlightedAchievement = ref('')
const highlightAchievement = (index) => {
  const achievements = experiences.value[index].achievements
  const randomIndex = Math.floor(Math.random() * achievements.length)
  highlightedAchievement.value = achievements[randomIndex]
  confetti({
    particleCount: 100,
    spread: 70,
    origin: { y: 0.6 }
  })
}
</script>

<style lang="scss" scoped>
.page {
  background-color: #87ceeb; // Sky blue
  font-family: Arial, sans-serif;
  min-height: 100vh;
  position: relative;
  overflow: hidden;
  transition: background-color 0.3s ease;

  &.dark-mode {
    background-color: #2c3e50;

    .banner {
      background-color: #1a252f;
      color: #fff;
    }

    .card {
      background-color: #34495e;
      color: #fff;

      .text-gray-600 {
        color: #ccc;
      }

      .text-gray-800 {
        color: #fff;
      }

      .border-gray-200 {
        border-color: #4a5568;
      }

      .bg-gray-50 {
        background-color: #3b4a5e;
      }

      .highlight {
        color: #ffd700;
      }
    }
  }
}

// Clouds Background
.clouds {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: 0;
}

.cloud {
  position: absolute;
  background: white;
  border-radius: 50%;
  opacity: 0.7;
  animation: drift linear infinite;
}

.cloud1 {
  width: 100px;
  height: 60px;
  top: 10%;
  left: -100px;
  animation-duration: 20s;
}

.cloud2 {
  width: 150px;
  height: 90px;
  top: 30%;
  left: -150px;
  animation-duration: 25s;
}

.cloud3 {
  width: 80px;
  height: 50px;
  top: 50%;
  left: -80px;
  animation-duration: 30s;
}

@keyframes drift {
  from {
    transform: translateX(0);
  }
  to {
    transform: translateX(100vw);
  }
}

// Banner
.banner {
  background: linear-gradient(90deg, #007bff, #00ddeb);
  height: 45px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: relative;
  z-index: 1;
  animation: gradientShift 5s ease infinite;

  .banner-left {
    font-weight: bold;
    font-size: 1rem;
    color: #fff;
  }

  .banner-right {
    display: flex;
    gap: 10px;
  }
}

@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

// Navigation and Theme Buttons
.nav-btn {
  background-color: rgba(255, 255, 255, 0.2);
  color: #fff;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
  text-decoration: none;

  &:hover {
    background-color: rgba(255, 255, 255, 0.3);
    transform: scale(1.05);
  }
}

.theme-btn {
  background-color: #fff;
  color: #007bff;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;

  &:hover {
    background-color: #f0f0f0;
    transform: scale(1.05);
  }
}

// Timeline
.timeline {
  position: relative;
  padding-left: 20px;

  &::before {
    content: '';
    position: absolute;
    left: 10px;
    top: 0;
    bottom: 0;
    width: 4px;
    background: #007bff;
    border-radius: 2px;
  }
}

.timeline-dot {
  position: absolute;
  left: 6px;
  top: 20px;
  width: 12px;
  height: 12px;
  background: #007bff;
  border-radius: 50%;
  animation: pulse 2s ease infinite;
}

@keyframes pulse {
  0% { transform: scale(1); opacity: 1; }
  50% { transform: scale(1.2); opacity: 0.7; }
  100% { transform: scale(1); opacity: 1; }
}

// Experience Cards
.card {
  transition: box-shadow 0.3s ease;
  margin-left: 20px;

  &:hover {
    box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
  }

  button {
    text-align: left;
  }

  .highlight {
    color: #007bff;
    font-weight: bold;
  }
}

.highlight-btn {
  padding: 8px 16px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;

  &:hover {
    background-color: #0056b3;
  }
}

// Slide Transition
.slide-enter-active,
.slide-leave-active {
  transition: opacity 0.3s ease, max-height 0.3s ease;
}
.slide-enter-from,
.slide-leave-to {
  opacity: 0;
  max-height: 0;
  overflow: hidden;
}
.slide-enter-to,
.slide-leave-from {
  opacity: 1;
  max-height: 300px;
}
</style>