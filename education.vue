<template>
  <div :class="['container-fluid', { 'bg-dark': isDarkMode, 'bg-light': !isDarkMode }]">
    <!-- Header -->
    <header class="bg-primary bg-gradient text-white py-3 mb-4 shadow-sm sticky-top">
      <div class="container d-flex justify-content-between align-items-center flex-wrap gap-3">
        <h1 class="h4 mb-0 fw-bold"><i class="fas fa-graduation-cap me-2"></i>Education</h1>
        <div class="d-flex gap-2">
          <button @click="toggleTheme" class="btn btn-light btn-sm">
            <span>{{ isDarkMode ? '☀️' : '🌙' }}</span> {{ isDarkMode ? 'Light Mode' : 'Dark Mode' }}
          </button>
          <NuxtLink to="/" class="btn btn-light btn-sm"><i class="fas fa-home me-1"></i>Back to Home</NuxtLink>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
          <!-- Timeline -->
          <section class="position-relative ps-4">
            <!-- Education Entry 1 -->
            <div class="mb-4 position-relative">
              <div class="position-absolute bg-primary rounded-circle" style="width: 16px; height: 16px; left: -8px; top: 20px;"></div>
              <div :class="['card', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
                <div class="card-header bg-primary bg-gradient text-white d-flex align-items-center" @click="toggleDetails(0)">
                  <i :class="['fas fa-chevron-down me-3', { 'rotate-180': expandedCards[0] }]"></i>
                  <div>
                    <h4 class="card-title h5 mb-0 fw-bold">Bachelor of Science in Computer Science</h4>
                    <p class="card-text text-white-75 mb-0"><i class="fas fa-university me-2"></i>Example University • 2016 - 2020</p>
                  </div>
                </div>
                <div class="collapse" :class="{ show: expandedCards[0] }">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Latest GPA:</span>
                          <span class="text-primary fw-bold">3.8/4.0</span>
                        </div>
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Major:</span>
                          <span>Computer Science</span>
                        </div>
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Minor:</span>
                          <span>Mathematics</span>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="d-flex flex-column mb-2">
                          <span class="fw-bold">CGPA: 3.75/4.0</span>
                          <div class="progress mt-1">
                            <div class="progress-bar bg-primary" :style="{ width: progressAnimated ? '93.75%' : '0%' }"></div>
                          </div>
                        </div>
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Level:</span>
                          <span>Undergraduate</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Education Entry 2 -->
            <div class="mb-4 position-relative">
              <div class="position-absolute bg-primary rounded-circle" style="width: 16px; height: 16px; left: -8px; top: 20px;"></div>
              <div :class="['card', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
                <div class="card-header bg-primary bg-gradient text-white d-flex align-items-center" @click="toggleDetails(1)">
                  <i :class="['fas fa-chevron-down me-3', { 'rotate-180': expandedCards[1] }]"></i>
                  <div>
                    <h4 class="card-title h5 mb-0 fw-bold">Master of Business Administration</h4>
                    <p class="card-text text-white-75 mb-0"><i class="fas fa-university me-2"></i>Another University • 2021 - 2023</p>
                  </div>
                </div>
                <div class="collapse" :class="{ show: expandedCards[1] }">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Latest GPA:</span>
                          <span class="text-primary fw-bold">3.9/4.0</span>
                        </div>
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Major:</span>
                          <span>Business Administration</span>
                        </div>
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Minor:</span>
                          <span>None</span>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="d-flex flex-column mb-2">
                          <span class="fw-bold">CGPA: 3.85/4.0</span>
                          <div class="progress mt-1">
                            <div class="progress-bar bg-primary" :style="{ width: progressAnimated ? '96.25%' : '0%' }"></div>
                          </div>
                        </div>
                        <div class="d-flex mb-2">
                          <span class="fw-bold me-2">Level:</span>
                          <span>Graduate</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';

// Theme management
const isDarkMode = ref(false);
const themeIcon = computed(() => (isDarkMode.value ? '☀️' : '🌙'));
const themeText = computed(() => (isDarkMode.value ? 'Light Mode' : 'Dark Mode'));

// State
const expandedCards = ref([false, false]);
const progressAnimated = ref(false);

// Methods
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
};

const toggleDetails = (index) => {
  expandedCards.value[index] = !expandedCards.value[index];
};

// Theme detection and progress bar animation
onMounted(() => {
  if (process.client && window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    isDarkMode.value = true;
  }
  setTimeout(() => {
    progressAnimated.value = true;
  }, 500);
});
</script>

<style lang="scss" scoped>
/* Minimal SCSS for essential customizations */
.container-fluid {
  min-height: 100vh;
}

/* Timeline line */
section.position-relative::before {
  content: '';
  position: absolute;
  left: 15px;
  top: 0;
  bottom: 0;
  width: 4px;
  background: linear-gradient(to bottom, #0d6efd, #6610f2);
  border-radius: 2px;
}

/* Rotate expand icon */
.rotate-180 {
  transform: rotate(180deg);
  transition: transform 0.3s ease;
}

/* Collapse transition */
.collapse {
  transition: all 0.4s ease;
}

/* White text for headers */
.card-header .card-title,
.card-header .card-text {
  color: #ffffff !important;
  font-weight: bold;
}

/* Progress bar transition */
.progress-bar {
  transition: width 0.8s ease;
}
</style>