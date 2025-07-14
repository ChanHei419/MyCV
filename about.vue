<template>
  <div :class="['text-white', 'portfolio-page', { 'dark-mode': isDarkMode }]">
    <!-- Animated Background Elements -->
    <div class="floating-elements">
      <div class="floating-circle circle-1"></div>
      <div class="floating-circle circle-2"></div>
      <div class="floating-circle circle-3"></div>
      <div class="floating-triangle triangle-1"></div>
      <div class="floating-triangle triangle-2"></div>
    </div>

    <!-- Top Navigation Banner -->
    <nav
      class="navbar navbar-expand-lg navbar-dark bg-transparent position-sticky top-0"
      style="z-index: 1000"
    >
      <div class="container-fluid px-4">
        <span class="navbar-brand fw-bold fs-4 mb-0">
          <i class="fas fa-user-circle me-2"></i>About Me
        </span>
        <div class="d-flex gap-2">
          <button
            @click="toggleTheme"
            class="btn btn-outline-light btn-sm rounded-pill px-3 background-opacity-75"
          >
            <i :class="isDarkMode ? 'fas fa-sun' : 'fas fa-moon'"></i>
            {{ isDarkMode ? " Light" : " Dark" }}
          </button>
          <NuxtLink to="/" class="btn btn-primary btn-sm rounded-pill px-3 background-color:black">
           <i class="bi bi-arrow-bar-left"></i>Back to Home
          </NuxtLink>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
      <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
          <!-- Hero Introduction Card -->
          <div class="card mb-4 border-0 shadow-lg hero-card">
            <div class="card-body p-5 text-center position-relative">
              <div class="hero-icon mb-4">
                <i class="fas fa-code fa-3x text-primary"></i>
              </div>
              <h2 class="card-title display-6 fw-bold mb-3">Who I Am</h2>
              <div class="typing-container mb-4">
                <h3 class="h4 mb-0">
                  <span class="typing-text">{{ typedText }}</span>
                  <span class="typing-cursor">|</span>
                </h3>
              </div>
              <transition name="fade">
                <div v-if="showQuote" class="quote-container">
                  <blockquote class="blockquote fst-italic">
                    <p class="mb-0">
                      "Code is my canvas, and I'm painting my future one line at
                      a time."
                    </p>
                  </blockquote>
                </div>
              </transition>
            </div>
          </div>

          <!-- Purpose Card -->
          <div class="card mb-4 border-0 shadow-lg purpose-card">
            <div class="card-body p-4">
              <div class="d-flex align-items-center mb-3">
                <div class="icon-circle me-3">
                  <i class="fas fa-rocket"></i>
                </div>
                <h2 class="card-title h3 mb-0 fw-bold">My Mission</h2>
              </div>
              <p class="card-text lead mb-4">
                I created this portfolio to showcase my skills, experiences, and
                passion for web development. It's a space where I can share my
                journey, from learning to code to building real-world projects,
                and connect with others who share my enthusiasm for technology.
              </p>
              <!-- <button
                @click="celebratePurpose"
                class="btn btn-primary btn-lg rounded-pill px-4"
              >
                <i class="fas fa-celebration me-2"></i>Celebrate My Journey!
              </button> -->
            </div>
          </div>

          <!-- Timeline Section -->
          <div class="card border-0 shadow-lg timeline-card">
            <div class="card-header bg-transparent border-0 py-4">
              <div class="d-flex align-items-center">
                <div class="icon-circle me-3">
                  <i class="fas fa-timeline"></i>
                </div>
                <h2 class="h3 mb-0 fw-bold">My Journey</h2>
              </div>
            </div>
            <div class="card-body p-4">
              <div class="timeline">
                <div
                  v-for="(milestone, index) in milestones"
                  :key="index"
                  class="timeline-item"
                >
                  <div class="timeline-marker">
                    <div class="timeline-dot"></div>
                  </div>
                  <div class="timeline-content">
                    <div class="card border-0 shadow-sm mb-3">
                      <div class="card-body p-4">
                        <div
                          class="d-flex justify-content-between align-items-start mb-2"
                        >
                          <h4 class="card-title h5 mb-0">
                            {{ milestone.title }}
                          </h4>
                          <span class="badge bg-primary rounded-pill">{{
                            milestone.year
                          }}</span>
                        </div>
                        <p class="card-text mb-0">
                          {{ milestone.description }}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Confetti Canvas -->
    <canvas
      id="confetti-canvas"
      class="position-fixed top-0 start-0 w-100 h-100"
      style="pointer-events: none; z-index: 9999"
    ></canvas>
  </div>
  
</template>

<script setup>
import { ref, onMounted } from "vue";
import confetti from "canvas-confetti";

// Theme Toggle
const isDarkMode = ref(false);
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
  document.documentElement.classList.toggle("dark", isDarkMode.value);
};

// Typing Animation
const fullText = "Hi, I am Helen Chan, a passionate web developer!";
const typedText = ref("");
const typingSpeed = 100;
const showQuote = ref(false);
let index = 0;

const type = () => {
  if (index < fullText.length) {
    typedText.value += fullText.charAt(index);
    index++;
    setTimeout(type, typingSpeed);
  } else {
    showQuote.value = true;
  }
};

onMounted(() => {
  type();
});




// Milestones data
const milestones = ref([
  {
    title: "Started Coding Journey",
    year: "2015",
    description:
      "Began learning HTML and CSS, sparking a love for web development and design principles.",
  },
  {
    title: "First Web Project",
    year: "2017",
    description:
      "Built my first personal website, experimenting with JavaScript and responsive design.",
  },
  {
    title: "Joined Tech Community",
    year: "2020",
    description:
      "Became an active member of local tech meetups and online forums, expanding my network.",
  },
  {
    title: "Advanced Framework Learning",
    year: "2022",
    description:
      "Mastered Vue.js and Nuxt.js, building dynamic and modern web applications.",
  },
]);
</script>

<style lang="scss" scoped>
body {
  transition: background-color 0.3s, color 0.3s;
}

body.light {
  background-color: #ffffff;
  color: #ffffff; // Changed to white for light mode
}

body.dark {
  background-color: #333333;
  color: #ffffff; // Already white, no change needed
}

:root {
  --transition: all 0.3s ease;
  --text-dark: #ffffff; // Changed to white
  --text-light: #ffffff; // Already white, no change needed
  --card-bg-light: rgba(255, 255, 255, 0.95);
  --card-bg-dark: rgba(45, 55, 72, 0.95);
}

.portfolio-page {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  transition: var(--transition);
  overflow-x: hidden;
  position: relative;
  font-family: "Inter", system-ui, -apple-system, sans-serif;
  color: #ffffff; // Ensure all text in portfolio-page is white

  &.dark-mode {
    background: linear-gradient(135deg, #232526 0%, #414345 100%);

    .card-title,
    .card-text,
    .blockquote p,
    .lead,
    .navbar-brand,
    .badge {
      color: #ffffff !important; // Force white for specific elements in dark mode
    }

    .timeline-content .card {
      background: rgba(74, 85, 104, 0.9) !important;
    }
  }
}

// Floating Background Elements
.floating-elements {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 0;
}

.floating-circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  animation: float 6s ease-in-out infinite;
}

.circle-1 {
  width: 80px;
  height: 80px;
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.circle-2 {
  width: 120px;
  height: 120px;
  top: 70%;
  right: 10%;
  animation-delay: 2s;
}

.circle-3 {
  width: 60px;
  height: 60px;
  top: 40%;
  left: 80%;
  animation-delay: 4s;
}

.floating-triangle {
  position: absolute;
  width: 0;
  height: 0;
  border-left: 30px solid transparent;
  border-right: 30px solid transparent;
  border-bottom: 52px solid rgba(255, 255, 255, 0.1);
  animation: float 8s ease-in-out infinite;
}

.triangle-1 {
  top: 20%;
  right: 20%;
  animation-delay: 1s;
}

.triangle-2 {
  top: 60%;
  left: 5%;
  animation-delay: 3s;
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0px) rotate(0deg);
  }
  33% {
    transform: translateY(-20px) rotate(120deg);
  }
  66% {
    transform: translateY(10px) rotate(240deg);
  }
}

// Cards
.card {
  background: var(--card-bg-light);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: var(--transition);
  position: relative;
  z-index: 1;
  color: #ffffff; // Ensure all text in cards is white

  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1) !important;
  }
}

.hero-card {
  .hero-icon {
    animation: pulse 2s ease-in-out infinite;
  }
}

.icon-circle {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ffffff; // Ensure icon color is white
  font-size: 1.2rem;
}

// Typing Animation
.typing-text {
  display: inline-block;
  color: #ffffff; // Ensure typing text is white
}

.typing-cursor {
  display: inline-block;
  animation: blink 1s infinite;
  color: #ffffff; // Changed to white from #667eea
  font-weight: bold;
}

@keyframes blink {
  0%,
  50% {
    opacity: 1;
  }
  51%,
  100% {
    opacity: 0;
  }
}

@keyframes pulse {
  0%,
  100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}

// Quote Animation
.fade-enter-active,
.fade-leave-active {
  transition: all 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(20px);
}

// Timeline
.timeline {
  position: relative;
  padding-left: 2rem;

  &::before {
    content: "";
    position: absolute;
    left: 1rem;
    top: 0;
    bottom: 0;
    width: 3px;
    background: linear-gradient(to bottom, #667eea, #764ba2);
    border-radius: 1.5px;
  }
}

.timeline-item {
  position: relative;
  margin-bottom: 2rem;

  &:last-child {
    margin-bottom: 0;
  }
}

.timeline-marker {
  position: absolute;
  left: -2rem;
  top: 1rem;
  z-index: 2;
}

.timeline-dot {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: 3px solid #ffffff; // Ensure border is white
  animation: pulse 2s ease-in-out infinite;
  box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.2);
}

.timeline-content {
  margin-left: 1rem;
}

// Button Enhancements
.btn {
  transition: var(--transition);
  color: #ffffff !important; // Ensure button text is white

  &:hover {
    transform: translateY(-2px);
  }
}

.btn-outline-light {
  border-color: #ffffff;
  color: #ffffff !important; // Ensure outline button text is white

  &:hover {
    background-color: rgba(255, 255, 255, 0.2);
    color: #ffffff !important;
  }
}

.btn-light {
  background-color: #ffffff;
  color: #000000; // Keep contrast for readability, as this is a light button
}

// Navbar
.navbar-brand {
  color: #ffffff !important; // Ensure navbar brand text is white
}

// Responsive Design
@media (max-width: 768px) {
  .container {
    padding: 0 15px;
  }

  .card-body {
    padding: 1.5rem !important;
  }

  .display-6 {
    font-size: 1.75rem;
  }

  .timeline {
    padding-left: 1.5rem;

    &::before {
      left: 0.75rem;
    }
  }

  .word_beautiful {
    color: #ffffff; // Changed to white
    font-weight: bold;
  }

  .timeline-marker {
    left: -1.75rem;
  }
}
</style>
