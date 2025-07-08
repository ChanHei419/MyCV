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
      <div class="banner-left">About Me</div>
      <div class="banner-right">
        <button @click="toggleTheme" class="theme-btn">
          {{ isDarkMode ? '☀️ Light Mode' : '🌙 Dark Mode' }}
        </button>
        <NuxtLink to="/" class="nav-btn">Back to Home</NuxtLink>
      </div>
    </div>

    <!-- About Content -->
    <div class="max-w-3xl mx-auto space-y-6 px-6 py-12">
      <!-- Introduction Card -->
      <div class="card bg-white shadow-lg rounded-lg overflow-hidden relative">
        <div class="timeline-dot"></div>
        <div class="p-6">
          <h2 class="text-2xl font-bold text-gray-800">Who I Am</h2>
          <h1 class="text-xl mt-2">
            <span class="typing">{{ typedText }}</span>
            <span class="cursor">|</span>
          </h1>
          <transition name="fade">
            <p v-if="showQuote" class="quote mt-4 text-gray-600 italic">
              "Code is my canvas, and I'm painting my future one line at a time."
            </p>
          </transition>
        </div>
      </div>

      <!-- Purpose Card -->
      <div class="card bg-white shadow-lg rounded-lg overflow-hidden relative">
        <div class="timeline-dot"></div>
        <div class="p-6">
          <h2 class="text-2xl font-bold text-gray-800">Why This Portfolio</h2>
          <p class="text-gray-800 mt-2">
            I created this portfolio to showcase my skills, experiences, and passion for web development. It's a space where I can share my journey, from learning to code to building real-world projects, and connect with others who share my enthusiasm for technology. This website is a reflection of my growth and a platform to inspire and collaborate with the tech community.
          </p>
          <button @click="celebratePurpose" class="highlight-btn mt-4">Celebrate My Journey!</button>
        </div>
      </div>

      <!-- Timeline for Milestones -->
      <div class="timeline">
        <div v-for="(milestone, index) in milestones" :key="index" class="card bg-white shadow-lg rounded-lg overflow-hidden relative">
          <div class="timeline-dot"></div>
          <div class="p-6">
            <h3 class="text-xl font-semibold text-gray-800">{{ milestone.title }}</h3>
            <p class="text-sm text-gray-600">{{ milestone.year }}</p>
            <p class="text-gray-800 mt-2">{{ milestone.description }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Confetti Canvas -->
    <canvas id="confetti-canvas"></canvas>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import confetti from 'canvas-confetti'

// Theme Toggle
const isDarkMode = ref(false)
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value
  document.documentElement.classList.toggle('dark', isDarkMode.value)
}

// Typing Animation
const fullText = 'Hi, I am Helen Chan, a passionate web developer!'
const typedText = ref('')
const typingSpeed = 100
const showQuote = ref(false)
let index = 0

const type = () => {
  if (index < fullText.length) {
    typedText.value += fullText.charAt(index)
    index++
    setTimeout(type, typingSpeed)
  } else {
    showQuote.value = true
  }
}

onMounted(() => {
  type()
})

// Celebrate Purpose
const celebratePurpose = () => {
  confetti({
    particleCount: 100,
    spread: 70,
    origin: { y: 0.6 },
    colors: ['#007bff', '#00ddeb', '#ffd700']
  })
}

// Milestones data
const milestones = ref([
  {
    title: 'Started Coding Journey',
    year: '2015',
    description: 'Began learning HTML and CSS, sparking a love for web development.'
  },
  {
    title: 'First Web Project',
    year: '2017',
    description: 'Built my first personal website, experimenting with JavaScript.'
  },
  {
    title: 'Joined Tech Community',
    year: '2020',
    description: 'Became an active member of local tech meetups and online forums.'
  }
])
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
      background: linear-gradient(90deg, #1a252f, #2d3748);
      color: #fff;
    }

    .card {
      background-color: #34495e;

      .text-gray-600 {
        color: #ccc;
      }

      .text-gray-800 {
        color: #fff;
      }

      .quote {
        color: #ccc;
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
  pointer-events: none;
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
    transform: translateX(-100%);
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
  position: sticky;
  top: 0;
  z-index: 10;
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

// Cards
.card {
  transition: box-shadow 0.3s ease;
  margin-left: 20px;

  &:hover {
    box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
  }

  .typing {
    display: inline-block;
  }

  .cursor {
    display: inline-block;
    animation: blink 0.7s infinite;
  }

  .quote {
    transition: opacity 0.5s ease;
  }
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
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
</style>