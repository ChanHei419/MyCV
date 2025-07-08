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
      <div class="banner-left">My Portfolio</div>
      <div class="banner-right">
        <NuxtLink to="/about"><button class="nav-btn">About</button></NuxtLink>
        <NuxtLink to="/experience"><button class="nav-btn">Experience</button></NuxtLink>
        <NuxtLink to="/education"><button class="nav-btn">Education</button></NuxtLink>
        <NuxtLink to="/skills"><button class="nav-btn">Skills</button></NuxtLink>
        <button @click="toggleTheme" class="theme-btn">
          {{ isDarkMode ? '☀️ Light Mode' : '🌙 Dark Mode' }}
        </button>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <!-- Left Description Card -->
      <div class="card description">
        <h1>
          <span class="typing">{{ typedText }}</span>
          <span class="cursor">|</span>
        </h1>
        <p class="caption">{{ currentCaption }}</p>
        <div class="button-group">
          <button @click="showFunFact" class="fun-btn">Discover a Fun Fact!</button>
          <button @click="changeCaption" class="caption-btn">New Tagline</button>
        </div>
        <transition name="fade">
          <p v-if="currentFact" class="fun-fact">{{ currentFact }}</p>
        </transition>
        <!-- Skill Carousel -->
        <div class="skill-carousel" @mouseenter="pauseCarousel" @mouseleave="resumeCarousel">
          <transition name="slide">
            <div v-if="currentSkill" class="skill-card">
              <h3 class="skill-title">{{ currentSkill.name }}</h3>
              <p class="skill-description">{{ currentSkill.description }}</p>
              <div class="progress-bar">
                <span class="text-sm text-gray-600">Proficiency: {{ currentSkill.proficiency }}%</span>
                <div class="progress-container">
                  <div :style="{ width: `${currentSkill.proficiency}%` }" class="progress"></div>
                </div>
              </div>
            </div>
          </transition>
          <div class="carousel-controls">
            <button @click="prevSkill" class="carousel-btn">← Prev</button>
            <button @click="nextSkill" class="carousel-btn">Next →</button>
          </div>
        </div>
      </div>

      <!-- Right Profile Card -->
      <div class="card icon">
        <img src="https://via.placeholder.com/200" alt="Profile Icon" class="profile-img">
      </div>
    </div>

    <!-- Project Preview Section -->
    <div class="projects max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Featured Projects</h2>
      <div class="timeline">
        <div v-for="(project, index) in projects" :key="index" class="card bg-white shadow-lg rounded-lg overflow-hidden relative">
          <div class="timeline-dot"></div>
          <button
            @click="toggleProjectDetails(index)"
            class="w-full flex items-center p-6 bg-gradient-to-r from-blue-500 to-blue-600 text-white hover:from-blue-600 hover:to-blue-700 transition-all duration-300"
          >
            <svg
              :class="{ 'rotate-180': openProjectIndex === index }"
              class="w-4 h-4 mr-4 transition-transform duration-300"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
            </svg>
            <div class="text-left flex-1">
              <h3 class="text-xl font-semibold">{{ project.title }}</h3>
              <p class="text-sm opacity-80">{{ project.date }}</p>
            </div>
          </button>
          <transition name="slide">
            <div v-if="openProjectIndex === index" class="p-6 border-t border-gray-200 bg-gray-50">
              <p class="text-gray-800">{{ project.description }}</p>
              <a :href="project.link" target="_blank" class="project-link mt-4 inline-block">View Project</a>
            </div>
          </transition>
        </div>
      </div>
    </div>

    <!-- Recent Activity Timeline -->
    <div class="timeline max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Recent Activity</h2>
      <div v-for="(activity, index) in recentActivities" :key="index" class="card bg-white shadow-lg rounded-lg overflow-hidden relative">
        <div class="timeline-dot"></div>
        <div class="p-6">
          <h3 class="text-xl font-semibold text-gray-800">{{ activity.title }}</h3>
          <p class="text-sm text-gray-600">{{ activity.date }}</p>
          <p class="text-gray-800 mt-2">{{ activity.description }}</p>
        </div>
      </div>
    </div>

    <!-- Contact Section -->
    <div class="card contact max-w-3xl mx-auto px-6 py-4">
      <div class="contact-content">
        <p>Email: <a href="mailto:helenchan@email.com" class="contact-link">helenchan@email.com</a></p>
        <p>Phone: <a href="tel:+1234567890" class="contact-link">(123) 456-7890</a></p>
        <p>Location: City, Country</p>
        <div class="social-links">
          <a href="https://linkedin.com" target="_blank" class="social-icon" title="LinkedIn">
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.761 0 5-2.239 5-5v-14c0-2.761-2.239-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.784-1.75-1.75s.784-1.75 1.75-1.75 1.75.784 1.75 1.75-.784 1.75-1.75 1.75zm13.5 12.268h-3v-5.604c0-1.337-.026-3.058-1.867-3.058-1.867 0-2.152 1.458-2.152 2.965v5.697h-3v-11h2.879v1.508h.04c.401-.757 1.379-1.557 2.834-1.557 3.033 0 3.592 1.996 3.592 4.592v6.457z"/>
            </svg>
          </a>
          <a href="https://github.com" target="_blank" class="social-icon" title="GitHub">
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.387.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61-.546-1.385-1.333-1.754-1.333-1.754-1.087-.744.083-.729.083-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.834 2.809 1.304 3.495.997.108-.776.418-1.305.762-1.605-2.665-.305-5.466-1.332-5.466-5.931 0-1.31.465-2.38 1.236-3.221-.123-.303-.535-1.523.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.241 2.873.118 3.176.771.841 1.234 1.911 1.234 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.218.694.824.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
            </svg>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

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
let index = 0

const type = () => {
  if (index < fullText.length) {
    typedText.value += fullText.charAt(index)
    index++
    setTimeout(type, typingSpeed)
  } else {
    setTimeout(() => {
      typedText.value = ''
      index = 0
      type()
    }, 3000)
  }
}

// Dynamic Tagline Rotator
const captions = [
  'Building the web, one line at a time.',
  'Turning ideas into interactive experiences.',
  'Passionate about code and creativity.',
  'Welcome to my digital playground!'
]
const currentCaption = ref(captions[0])
let captionIndex = 0
let captionInterval = null

const changeCaption = () => {
  captionIndex = (captionIndex + 1) % captions.length
  currentCaption.value = captions[captionIndex]
}

const startCaptionRotator = () => {
  captionInterval = setInterval(() => {
    changeCaption()
  }, 5000)
}

// Fun Facts with Glow
const funFacts = [
  'Helen once coded for 24 hours straight!',
  'Helen loves solving complex algorithms.',
  'Helen is passionate about web development.',
  'Helen built her first website at 16!'
]
const currentFact = ref('')

const showFunFact = () => {
  const randomIndex = Math.floor(Math.random() * funFacts.length)
  currentFact.value = funFacts[randomIndex]
}

// Skill Carousel
const skills = ref([
  { name: 'JavaScript', description: 'Proficient in dynamic web applications.', proficiency: 80 },
  { name: 'Vue.js', description: 'Experienced in reactive UIs.', proficiency: 75 },
  { name: 'CSS', description: 'Skilled in responsive designs.', proficiency: 85 }
])
const currentSkill = ref(skills.value[0])
let skillIndex = 0
let carouselInterval = null

const nextSkill = () => {
  skillIndex = (skillIndex + 1) % skills.value.length
  currentSkill.value = skills.value[skillIndex]
}

const prevSkill = () => {
  skillIndex = (skillIndex - 1 + skills.value.length) % skills.value.length
  currentSkill.value = skills.value[skillIndex]
}

const startSkillCarousel = () => {
  carouselInterval = setInterval(() => {
    nextSkill()
  }, 5000)
}

const pauseCarousel = () => {
  clearInterval(carouselInterval)
}

const resumeCarousel = () => {
  startSkillCarousel()
}

// Project Preview
const projects = ref([
  {
    title: 'Personal Portfolio',
    date: 'July 2025',
    description: 'A dynamic portfolio showcasing my skills, experiences, and projects with a modern UI.',
    link: 'https://example.com/portfolio'
  },
  {
    title: 'E-Commerce Web App',
    date: 'June 2025',
    description: 'Built a responsive e-commerce platform using Vue.js and Nuxt.js.',
    link: 'https://example.com/ecommerce'
  }
])
const openProjectIndex = ref(null)
const toggleProjectDetails = (index) => {
  openProjectIndex.value = openProjectIndex.value === index ? null : index
}

// Recent Activity
const recentActivities = ref([
  {
    title: 'Launched Portfolio Website',
    date: 'July 2025',
    description: 'Published my personal portfolio to showcase my skills and projects.'
  },
  {
    title: 'Completed Vue.js Project',
    date: 'June 2025',
    description: 'Built a dynamic web app using Vue.js and Nuxt.js.'
  },
  {
    title: 'Joined Tech Meetup',
    date: 'May 2025',
    description: 'Connected with local developers to share knowledge.'
  }
])

onMounted(() => {
  type()
  startSkillCarousel()
  startCaptionRotator()
})

onUnmounted(() => {
  clearInterval(carouselInterval)
  clearInterval(captionInterval)
})
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

      .description h1,
      .description .caption,
      .fun-fact,
      .skill-title,
      .skill-description,
      .contact p,
      .contact-link,
      .text-gray-800,
      .text-gray-600 {
        color: #fff;
      }

      .progress {
        background-color: #4a90e2;
      }

      .fun-fact {
        text-shadow: 0 0 10px #ffd700;
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
  background: linear-gradient(90deg, #007bff, #00ddeb); // Static gradient
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  position: sticky;
  top: 0;
  z-index: 10;

  .banner-left {
    font-weight: bold;
    font-size: 1.2rem;
    color: #fff;
  }

  .banner-right {
    display: flex;
    gap: 10px;
  }
}

// Navigation and Theme Buttons
.nav-btn {
  background-color: rgba(255, 255, 255, 0.2);
  color: #fff;
  border: none;
  padding: 8px 16px;
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
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;

  &:hover {
    background-color: #f0f0f0;
    transform: scale(1.05);
  }
}

// Main Content
.main-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 40px 20px;
  position: relative;
  z-index: 1;

  .description {
    flex: 1;
    padding: 20px;
    border-radius: 8px;

    h1 {
      font-size: 2rem;
      margin-bottom: 0.5rem;
      display: flex;
      align-items: center;
    }

    .typing {
      display: inline-block;
    }

    .cursor {
      display: inline-block;
      animation: blink 0.7s infinite;
    }

    .caption {
      font-size: 1rem;
      color: #333;
      margin-bottom: 1rem;
      transition: opacity 0.5s ease;
    }

    .button-group {
      display: flex;
      gap: 10px;
    }

    .fun-btn,
    .caption-btn,
    .carousel-btn {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;

      &:hover {
        background-color: #0056b3;
        transform: scale(1.05);
      }
    }

    .fun-fact {
      margin-top: 10px;
      font-style: italic;
      color: #555;
      text-shadow: 0 0 5px #007bff;
      transition: text-shadow 0.3s ease;
    }

    .skill-carousel {
      margin-top: 20px;
    }

    .skill-card {
      background: #f9fafb;
      padding: 15px;
      border-radius: 8px;
      transition: all 0.3s ease;

      .skill-title {
        font-size: 1.2rem;
        font-weight: bold;
        color: #333;
      }

      .skill-description {
        font-size: 0.9rem;
        color: #555;
        margin-top: 5px;
      }

      .progress-bar {
        margin-top: 10px;
      }

      .progress-container {
        width: 100%;
        height: 8px;
        background: #e0e0e0;
        border-radius: 4px;
        overflow: hidden;
      }

      .progress {
        height: 100%;
        background: #007bff;
        transition: width 0.5s ease;
      }
    }

    .carousel-controls {
      display: flex;
      gap: 10px;
      margin-top: 10px;
      justify-content: center;
    }
  }

  .icon {
    flex: 0;
    padding: 20px;
    border-radius: 8px;
    transition: transform 0.3s ease;

    &:hover {
      transform: rotate(5deg);
    }

    .profile-img {
      border-radius: 50%;
      width: 200px;
      height: 200px;
      object-fit: cover;
      border: 4px solid #007bff;
      transition: transform 0.3s ease, box-shadow 0.3s ease;

      &:hover {
        transform: scale(1.15);
        box-shadow: 0 0 20px rgba(0, 123, 255, 0.5);
      }
    }
  }
}

// Projects and Timeline
.projects,
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
}

@keyframes pulse {
  0% { transform: scale(1); opacity: 1; }
  50% { transform: scale(1.2); opacity: 0.7; }
  100% { transform: scale(1); opacity: 1; }
}

// Contact Section
.contact {
  padding: 20px;
  border-radius: 8px;
  font-size: 0.9rem;
  color: #fff;
  background: rgba(0, 0, 0, 0.3);
  z-index: 1;

  &:hover {
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
  }

  .contact-content {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: center;
  }

  .contact-link {
    color: #fff;
    text-decoration: none;
    transition: color 0.3s ease;

    &:hover {
      color: #007bff;
      text-decoration: underline;
    }
  }

  .social-links {
    display: flex;
    gap: 15px;

    .social-icon {
      color: #fff;
      transition: transform 0.3s ease, color 0.3s ease;

      &:hover {
        color: #007bff;
        transform: rotate(360deg) scale(1.2);
      }
    }
  }
}

// Cards
.card {
  transition: box-shadow 0.3s ease;
  margin-left: 20px;

  &:hover {
    box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
  }

  .project-link {
    padding: 8px 16px;
    background-color: #007bff;
    color: white;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color 0.3s ease;

    &:hover {
      background-color: #0056b3;
    }
  }
}

// Animations
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

.slide-enter-active,
.slide-leave-active {
  transition: transform 0.5s ease, opacity 0.5s ease;
}
.slide-enter-from {
  transform: translateX(-20px);
  opacity: 0;
}
.slide-leave-to {
  transform: translateX(20px);
  opacity: 0;
}
</style>