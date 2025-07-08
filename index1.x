<template>
  <div>
    <!-- Add Bootstrap and Font Awesome CDN links -->
    
    <div :class="['portfolio-page', { 'dark-mode': isDarkMode }]">
      <!-- Animated Background -->
      <div class="bg-animation">
        <div class="floating-shapes">
          <div v-for="n in 6" :key="n" class="shape" :class="`shape-${n}`"></div>
        </div>
      </div>

      <!-- Navigation -->
      <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
          <NuxtLink to="/" class="navbar-brand">
            <i class="fas fa-code me-2"></i>Helen Chan
          </NuxtLink>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
              <li class="nav-item">
                <a class="nav-link" href="#home" @click="scrollToSection('home')">Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#about" @click="scrollToSection('about')">About</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#skills" @click="scrollToSection('skills')">Skills</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#projects" @click="scrollToSection('projects')">Projects</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#contact" @click="scrollToSection('contact')">Contact</a>
              </li>
              <li class="nav-item">
                <button class="btn theme-toggle ms-2" @click="toggleTheme">
                  <i :class="isDarkMode ? 'fas fa-sun' : 'fas fa-moon'"></i>
                </button>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <!-- Hero Section -->
      <section id="home" class="hero-section">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-lg-6 slide-in-left">
              <div class="hero-content">
                <h1 class="hero-title">
                  <span>{{ typedText }}</span>
                  <span class="typing-cursor">|</span>
                </h1>
                <p class="hero-subtitle">{{ currentSubtitle }}</p>
                <div class="d-flex flex-wrap gap-3 mb-4">
                  <button class="btn btn-custom" @click="showFunFact">
                    <i class="fas fa-lightbulb me-2"></i>Fun Fact
                  </button>
                  <button class="btn btn-custom" @click="changeSubtitle">
                    <i class="fas fa-refresh me-2"></i>New Tagline
                  </button>
                  <button class="btn btn-custom" @click="createParticles">
                    <i class="fas fa-star me-2"></i>Magic
                  </button>
                </div>
                <div class="mt-4">
                  <button class="btn btn-outline-light btn-lg me-3" @click="scrollToSection('projects')">
                    <i class="fas fa-folder-open me-2"></i>View My Work
                  </button>
                  <button class="btn btn-outline-light btn-lg" @click="scrollToSection('contact')">
                    <i class="fas fa-envelope me-2"></i>Get In Touch
                  </button>
                </div>
              </div>
            </div>
            <div class="col-lg-6 text-center slide-in-right">
              <img src="https://picsum.photos/300/300?random=1" alt="Helen Chan" class="profile-image">
            </div>
          </div>
        </div>
      </section>

      <!-- About Section -->
      <section id="about" class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-lg-8 mx-auto">
              <div class="custom-card p-5 fade-in">
                <h2 class="text-center mb-4">
                  <i class="fas fa-user-circle me-3" style="color: var(--primary-color);"></i>About Me
                </h2>
                <p class="lead text-center mb-4">
                  Passionate web developer with a love for creating beautiful, functional, and user-friendly digital experiences.
                </p>
                <div class="row">
                  <div class="col-md-6">
                    <h5><i class="fas fa-heart me-2" style="color: var(--accent-color);"></i>What I Love</h5>
                    <ul class="list-unstyled">
                      <li><i class="fas fa-code me-2"></i>Clean, efficient code</li>
                      <li><i class="fas fa-palette me-2"></i>Modern UI/UX design</li>
                      <li><i class="fas fa-mobile-alt me-2"></i>Responsive development</li>
                      <li><i class="fas fa-rocket me-2"></i>Performance optimization</li>
                    </ul>
                  </div>
                  <div class="col-md-6">
                    <h5><i class="fas fa-trophy me-2" style="color: var(--primary-color);"></i>Achievements</h5>
                    <ul class="list-unstyled">
                      <li><i class="fas fa-award me-2"></i>50+ Projects completed</li>
                      <li><i class="fas fa-users me-2"></i>100+ Happy clients</li>
                      <li><i class="fas fa-clock me-2"></i>3+ Years experience</li>
                      <li><i class="fas fa-coffee me-2"></i>1000+ Cups of coffee</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Skills Section -->
      <section id="skills" class="py-5">
        <div class="container">
          <h2 class="text-center text-white mb-5">
            <i class="fas fa-tools me-3"></i>Skills & Expertise
          </h2>
          <div class="row">
            <div v-for="(skill, index) in skills" :key="index" class="col-lg-4 col-md-6 mb-4">
              <div class="skill-item" @click="showSkillDetails(index)" :style="{ animationDelay: `${index * 0.1}s` }">
                <i :class="skill.icon + ' skill-icon'"></i>
                <h5>{{ skill.name }}</h5>
                <p class="mb-0">Click to learn more</p>
              </div>
            </div>
          </div>
          
          <!-- Skill Details Card -->
          <div v-if="selectedSkill" class="row mt-5">
            <div class="col-lg-8 mx-auto">
              <transition name="fade">
                <div class="custom-card p-4">
                  <h4>{{ selectedSkill.name }}</h4>
                  <p>{{ selectedSkill.description }}</p>
                  <div class="progress mb-3">
                    <div class="progress-bar" :style="{ width: skillProgress + '%' }"></div>
                  </div>
                  <div class="d-flex justify-content-between">
                    <small>Experience: {{ selectedSkill.experience }}</small>
                    <small>Level: {{ selectedSkill.level }}</small>
                  </div>
                </div>
              </transition>
            </div>
          </div>
        </div>
      </section>

      <!-- Projects Section -->
      <section id="projects" class="py-5">
        <div class="container">
          <h2 class="text-center text-white mb-5">
            <i class="fas fa-project-diagram me-3"></i>Featured Projects
          </h2>
          
          <!-- Project Filter -->
          <div class="text-center mb-4">
            <button 
              v-for="filter in projectFilters" 
              :key="filter.value"
              class="btn btn-outline-light me-2 filter-btn"
              :class="{ active: activeFilter === filter.value }"
              @click="setActiveFilter(filter.value)"
            >
              {{ filter.label }}
            </button>
          </div>
          
          <div class="row">
            <div 
              v-for="(project, index) in filteredProjects" 
              :key="index" 
              class="col-lg-4 col-md-6 mb-4"
            >
              <div class="custom-card project-card" :style="{ animationDelay: `${index * 0.1}s` }">
                <img :src="project.image" :alt="project.title" class="project-image">
                <div class="project-overlay">
                  <h5 class="mb-3">{{ project.title }}</h5>
                  <p class="mb-3">{{ project.description }}</p>
                  <div class="mb-3">
                    <span 
                      v-for="tech in project.technologies" 
                      :key="tech" 
                      class="badge bg-light text-dark me-1"
                    >
                      {{ tech }}
                    </span>
                  </div>
                  <a :href="project.link" class="btn btn-light">
                    <i class="fas fa-external-link-alt me-2"></i>View Project
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Interactive Comments Section -->
      <section id="comments" class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-lg-8 mx-auto">
              <div class="custom-card p-5">
                <h3 class="text-center mb-4">
                  <i class="fas fa-comments me-3" style="color: var(--primary-color);"></i>
                  Leave a Comment
                </h3>
                
                <!-- Comment Form -->
                <form @submit.prevent="addComment" class="mb-4">
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <input 
                        v-model="commentForm.name" 
                        type="text" 
                        class="form-control" 
                        placeholder="Your Name" 
                        required
                      >
                    </div>
                    <div class="col-md-6 mb-3">
                      <input 
                        v-model="commentForm.email" 
                        type="email" 
                        class="form-control" 
                        placeholder="Your Email" 
                        required
                      >
                    </div>
                  </div>
                  <div class="mb-3">
                    <textarea 
                      v-model="commentForm.message" 
                      class="form-control" 
                      rows="4" 
                      placeholder="Your message..." 
                      required
                    ></textarea>
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn btn-custom">
                      <i class="fas fa-paper-plane me-2"></i>Post Comment
                    </button>
                  </div>
                </form>
                
                <!-- Comments Display -->
                <div>
                  <h5 class="mb-3">Recent Comments ({{ comments.length }})</h5>
                  <div v-if="comments.length === 0" class="text-muted text-center">
                    No comments yet. Be the first to leave a comment!
                  </div>
                  <div v-else>
                    <div v-for="(comment, index) in comments" :key="index" class="comment-item">
                      <div class="d-flex justify-content-between align-items-start mb-2">
                        <h6 class="mb-0">{{ comment.name }}</h6>
                        <small class="text-muted">{{ comment.timestamp }}</small>
                      </div>
                      <p class="mb-0">{{ comment.message }}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Contact Section -->
      <section id="contact" class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-lg-8 mx-auto">
              <div class="custom-card p-5">
                <h2 class="text-center mb-4">
                  <i class="fas fa-envelope me-3" style="color: var(--primary-color);"></i>
                  Get In Touch
                </h2>
                <div class="row">
                  <div class="col-md-6">
                    <form @submit.prevent="handleContactForm">
                      <div class="mb-3">
                        <input 
                          v-model="contactForm.name" 
                          type="text" 
                          class="form-control" 
                          placeholder="Your Name" 
                          required
                        >
                      </div>
                      <div class="mb-3">
                        <input 
                          v-model="contactForm.email" 
                          type="email" 
                          class="form-control" 
                          placeholder="Your Email" 
                          required
                        >
                      </div>
                      <div class="mb-3">
                        <input 
                          v-model="contactForm.subject" 
                          type="text" 
                          class="form-control" 
                          placeholder="Subject" 
                          required
                        >
                      </div>
                      <div class="mb-3">
                        <textarea 
                          v-model="contactForm.message" 
                          class="form-control" 
                          rows="5" 
                          placeholder="Your Message" 
                          required
                        ></textarea>
                      </div>
                      <button type="submit" class="btn btn-custom w-100" :disabled="isSubmitting">
                        <span v-if="!isSubmitting">Send Message</span>
                        <span v-else>
                          <span class="loading-spinner"></span>
                          Sending...
                        </span>
                      </button>
                    </form>
                  </div>
                  <div class="col-md-6">
                    <div class="contact-info">
                      <div class="mb-4">
                        <h5><i class="fas fa-map-marker-alt me-2" style="color: var(--accent-color);"></i>Location</h5>
                        <p>San Francisco, CA</p>
                      </div>
                      <div class="mb-4">
                        <h5><i class="fas fa-envelope me-2" style="color: var(--primary-color);"></i>Email</h5>
                        <p>helen.chan@email.com</p>
                      </div>
                      <div class="mb-4">
                        <h5><i class="fas fa-phone me-2" style="color: var(--secondary-color);"></i>Phone</h5>
                        <p>+1 (555) 123-4567</p>
                      </div>
                      <div class="social-links">
                        <h5><i class="fas fa-share-alt me-2" style="color: var(--accent-color);"></i>Follow Me</h5>
                        <a href="#" class="btn btn-outline-primary me-2"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="btn btn-outline-primary me-2"><i class="fab fa-github"></i></a>
                        <a href="#" class="btn btn-outline-primary me-2"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="btn btn-outline-primary"><i class="fab fa-instagram"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Fun Fact Popup -->
      <transition name="modal">
        <div v-if="showPopup" class="modal-overlay" @click="hideFunFact">
          <div class="fun-fact-popup" @click.stop>
            <h4>🎉 Fun Fact!</h4>
            <p>{{ currentFunFact }}</p>
            <button class="btn btn-light" @click="hideFunFact">Got it!</button>
          </div>
        </div>
      </transition>

      <!-- Success Toast -->
      <transition name="toast">
        <div v-if="showToast" class="toast-notification">
          <i class="fas fa-check-circle me-2"></i>
          {{ toastMessage }}
        </div>
      </transition>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

// Theme management
const isDarkMode = ref(false)

// Typing animation
const typedText = ref('')
const texts = ["Hi, I'm Helen Chan", "Web Developer", "UI/UX Designer", "Problem Solver"]
let currentTextIndex = 0
let typingIndex = 0

// Subtitles
const subtitles = [
  "Building the web, one line at a time.",
  "Turning ideas into interactive experiences.",
  "Passionate about code and creativity.",
  "Welcome to my digital playground!"
]
const currentSubtitle = ref(subtitles[0])
let currentSubtitleIndex = 0

// Fun facts
const funFacts = [
  "I once coded for 24 hours straight and only stopped for coffee! ☕",
  "I've built over 50 websites and each one taught me something new! 🚀",
  "I started coding at age 16 with a simple 'Hello World' program! 👨‍💻",
  "I can solve a Rubik's cube while debugging code! 🧩",
  "I've consumed over 1,000 cups of coffee while coding! ☕",
  "I learned my first programming language from a library book! 📚"
]
const currentFunFact = ref('')
const showPopup = ref(false)

// Skills
const skills = ref([
  {
    name: 'JavaScript',
    icon: 'fab fa-js-square',
    description: 'Modern ES6+ JavaScript development with focus on clean, efficient code.',
    proficiency: 90,
    experience: '3+ years',
    level: 'Expert'
  },
  {
    name: 'React',
    icon: 'fab fa-react',
    description: 'Building dynamic user interfaces with React and Redux.',
    proficiency: 85,
    experience: '2+ years',
    level: 'Advanced'
  },
  {
    name: 'Vue.js',
    icon: 'fab fa-vuejs',
    description: 'Creating reactive applications with Vue.js and Nuxt.js.',
    proficiency: 80,
    experience: '2+ years',
    level: 'Advanced'
  },
  {
    name: 'Node.js',
    icon: 'fab fa-node-js',
    description: 'Backend development with Node.js and Express.',
    proficiency: 75,
    experience: '2+ years',
    level: 'Intermediate'
  },
  {
    name: 'Python',
    icon: 'fab fa-python',
    description: 'Data analysis and web development with Python.',
    proficiency: 70,
    experience: '1+ years',
    level: 'Intermediate'
  },
  {
    name: 'CSS',
    icon: 'fab fa-css3-alt',
    description: 'Responsive design with CSS3, SASS, and modern frameworks.',
    proficiency: 95,
    experience: '3+ years',
    level: 'Expert'
  }
])

const selectedSkill = ref(null)
const skillProgress = ref(0)

// Projects
const projects = ref([
  {
    title: 'E-Commerce Platform',
    description: 'Full-stack e-commerce solution with React and Node.js',
    image: 'https://picsum.photos/400/250?random=2',
    category: 'web',
    technologies: ['React', 'Node.js', 'MongoDB'],
    link: '#'
  },
  {
    title: 'Mobile Banking App',
    description: 'React Native app for mobile banking',
    image: 'https://picsum.photos/400/250?random=3',
    category: 'mobile',
    technologies: ['React Native', 'Firebase'],
    link: '#'
  },
  {
    title: 'Portfolio Website',
    description: 'Responsive portfolio website with modern design',
    image: 'https://picsum.photos/400/250?random=4',
    category: 'design',
    technologies: ['HTML', 'CSS', 'JavaScript'],
    link: '#'
  },
  {
    title: 'Task Management App',
    description: 'Vue.js application for project management',
    image: 'https://picsum.photos/400/250?random=5',
    category: 'web',
    technologies: ['Vue.js', 'Vuex', 'Firebase'],
    link: '#'
  },
  {
    title: 'Weather Dashboard',
    description: 'Real-time weather application with data visualization',
    image: 'https://picsum.photos/400/250?random=6',
    category: 'web',
    technologies: ['JavaScript', 'Chart.js', 'API'],
    link: '#'
  },
  {
    title: 'Brand Identity Design',
    description: 'Complete brand identity and logo design',
    image: 'https://picsum.photos/400/250?random=7',
    category: 'design',
    technologies: ['Photoshop', 'Illustrator'],
    link: '#'
  }
])

const projectFilters = ref([
  { label: 'All', value: 'all' },
  { label: 'Web Apps', value: 'web' },
  { label: 'Mobile', value: 'mobile' },
  { label: 'Design', value: 'design' }
])

const activeFilter = ref('all')

const filteredProjects = computed(() => {
  if (activeFilter.value === 'all') {
    return projects.value
  }
  return projects.value.filter(project => project.category === activeFilter.value)
})

// Comments
const comments = ref([])
const commentForm = ref({
  name: '',
  email: '',
  message: ''
})

// Contact form
const contactForm = ref({
  name: '',
  email: '',
  subject: '',
  message: ''
})
const isSubmitting = ref(false)

// Toast notifications
const showToast = ref(false)
const toastMessage = ref('')

// Intervals
let typingInterval = null
let subtitleInterval = null

// Methods
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value
  if (process.client) {
    localStorage.setItem('darkMode', isDarkMode.value.toString())
  }
}

const checkDarkMode = () => {
  if (process.client) {
    const savedMode = localStorage.getItem('darkMode')
    if (savedMode) {
      isDarkMode.value = savedMode === 'true'
    }
  }
}

const startTypingAnimation = () => {
  const typeText = () => {
    const currentText = texts[currentTextIndex]
    
    if (typingIndex < currentText.length) {
      typedText.value += currentText.charAt(typingIndex)
      typingIndex++
      setTimeout(typeText, 100)
    } else {
      setTimeout(eraseText, 2000)
    }
  }

  const eraseText = () => {
    if (typedText.value.length > 0) {
      typedText.value = typedText.value.slice(0, -1)
      setTimeout(eraseText, 50)
    } else {
      currentTextIndex = (currentTextIndex + 1) % texts.length
      typingIndex = 0
      setTimeout(typeText, 500)
    }
  }

  typeText()
}

const changeSubtitle = () => {
  currentSubtitleIndex = (currentSubtitleIndex + 1) % subtitles.length
  currentSubtitle.value = subtitles[currentSubtitleIndex]
}

const showFunFact = () => {
  const randomIndex = Math.floor(Math.random() * funFacts.length)
  currentFunFact.value = funFacts[randomIndex]
  showPopup.value = true
}

const hideFunFact = () => {
  showPopup.value = false
}

const createParticles = () => {
  if (!process.client) return
  
  const colors = ['#5D5CDE', '#00ddeb', '#ff6b6b', '#4ecdc4', '#45b7d1']
  
  for (let i = 0; i < 15; i++) {
    const particle = document.createElement('div')
    particle.style.position = 'fixed'
    particle.style.left = Math.random() * window.innerWidth + 'px'
    particle.style.top = Math.random() * window.innerHeight + 'px'
    particle.style.width = Math.random() * 10 + 5 + 'px'
    particle.style.height = particle.style.width
    particle.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)]
    particle.style.borderRadius = '50%'
    particle.style.pointerEvents = 'none'
    particle.style.zIndex = '9999'
    particle.style.animation = 'particle-float 3s ease-out forwards'
    
    document.body.appendChild(particle)
    
    setTimeout(() => {
      if (particle.parentNode) {
        particle.parentNode.removeChild(particle)
      }
    }, 3000)
  }
}

const showSkillDetails = (index) => {
  selectedSkill.value = skills.value[index]
  skillProgress.value = 0
  
  // Animate progress bar
  setTimeout(() => {
    skillProgress.value = selectedSkill.value.proficiency
  }, 300)
  
  // Scroll to skill details
  if (process.client) {
    setTimeout(() => {
      const element = document.querySelector('#skills .custom-card')
      if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'center' })
      }
    }, 100)
  }
}

const setActiveFilter = (filter) => {
  activeFilter.value = filter
}

const addComment = () => {
  if (commentForm.value.name && commentForm.value.email && commentForm.value.message) {
    const comment = {
      name: commentForm.value.name,
      email: commentForm.value.email,
      message: commentForm.value.message,
      timestamp: new Date().toLocaleString()
    }
    
    comments.value.unshift(comment)
    
    // Reset form
    commentForm.value = {
      name: '',
      email: '',
      message: ''
    }
    
    showSuccessMessage('Comment added successfully!')
  }
}

const handleContactForm = () => {
  isSubmitting.value = true
  
  // Simulate form submission
  setTimeout(() => {
    isSubmitting.value = false
    
    // Reset form
    contactForm.value = {
      name: '',
      email: '',
      subject: '',
      message: ''
    }
    
    showSuccessMessage('Message sent successfully!')
  }, 2000)
}

const showSuccessMessage = (message) => {
  toastMessage.value = message
  showToast.value = true
  
  setTimeout(() => {
    showToast.value = false
  }, 3000)
}

const scrollToSection = (sectionId) => {
  if (process.client) {
    const element = document.getElementById(sectionId)
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' })
    }
  }
}

// Lifecycle hooks
onMounted(() => {
  checkDarkMode()
  startTypingAnimation()
  
  // Auto-rotate subtitles
  subtitleInterval = setInterval(() => {
    changeSubtitle()
  }, 5000)
})

onUnmounted(() => {
  if (subtitleInterval) {
    clearInterval(subtitleInterval)
  }
})
</script>

<style lang="scss" scoped>
:root {
  --primary-color: #5D5CDE;
  --secondary-color: #00ddeb;
  --accent-color: #ff6b6b;
  --text-dark: #2c3e50;
  --text-light: #ecf0f1;
  --bg-light: #f8f9fa;
  --bg-dark: #1a1a1a;
  --card-shadow: 0 10px 30px rgba(93, 92, 222, 0.1);
  --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Poppins', sans-serif;
}

.portfolio-page {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  transition: var(--transition);
  overflow-x: hidden;
  position: relative;

  &.dark-mode {
    background: linear-gradient(135deg, #232526 0%, #414345 100%);
    color: var(--text-light);
  }
}

// Animated Background
.bg-animation {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  overflow: hidden;
}

.floating-shapes {
  position: absolute;
  width: 100%;
  height: 100%;
}

.shape {
  position: absolute;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  animation: float 20s infinite linear;
}

.shape-1 { width: 80px; height: 80px; left: 10%; animation-delay: 0s; }
.shape-2 { width: 120px; height: 120px; left: 20%; animation-delay: 2s; }
.shape-3 { width: 60px; height: 60px; left: 35%; animation-delay: 4s; }
.shape-4 { width: 100px; height: 100px; left: 50%; animation-delay: 6s; }
.shape-5 { width: 90px; height: 90px; left: 70%; animation-delay: 8s; }
.shape-6 { width: 110px; height: 110px; left: 85%; animation-delay: 10s; }

@keyframes float {
  0% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
  10% { opacity: 1; }
  90% { opacity: 1; }
  100% { transform: translateY(-100px) rotate(360deg); opacity: 0; }
}

// Navigation
.navbar {
  background: rgba(255, 255, 255, 0.95) !important;
  backdrop-filter: blur(10px);
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
  transition: var(--transition);
}

.dark-mode .navbar {
  background: rgba(26, 26, 26, 0.95) !important;
}

.navbar-brand {
  font-weight: 700;
  font-size: 1.5rem;
  background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-decoration: none;
}

.nav-link {
  font-weight: 500;
  position: relative;
  transition: var(--transition);
  cursor: pointer;

  &:hover {
    transform: translateY(-2px);
  }

  &::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    width: 0;
    height: 2px;
    background: var(--primary-color);
    transition: var(--transition);
    transform: translateX(-50%);
  }

  &:hover::after {
    width: 100%;
  }
}

// Hero Section
.hero-section {
  min-height: 100vh;
  display: flex;
  align-items: center;
  position: relative;
  overflow: hidden;
  padding-top: 80px;
}

.hero-content {
  z-index: 2;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  background: linear-gradient(45deg, #fff, #f0f0f0);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);

  @media (max-width: 768px) {
    font-size: 2.5rem;
  }

  @media (max-width: 576px) {
    font-size: 2rem;
  }
}

.hero-subtitle {
  font-size: 1.3rem;
  margin-bottom: 2rem;
  color: rgba(255, 255, 255, 0.9);

  @media (max-width: 768px) {
    font-size: 1.1rem;
  }
}

.typing-cursor {
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 50% { opacity: 1; }
  51%, 100% { opacity: 0; }
}

.profile-image {
  width: 300px;
  height: 300px;
  border-radius: 50%;
  object-fit: cover;
  border: 5px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
  transition: var(--transition);
  animation: profileFloat 6s ease-in-out infinite;

  @media (max-width: 768px) {
    width: 250px;
    height: 250px;
  }

  @media (max-width: 576px) {
    width: 200px;
    height: 200px;
  }

  &:hover {
    transform: scale(1.05) rotate(5deg);
    box-shadow: 0 25px 50px rgba(93, 92, 222, 0.4);
  }
}

@keyframes profileFloat {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

// Cards
.custom-card {
  background: rgba(255, 255, 255, 0.95);
  border: none;
  border-radius: 20px;
  box-shadow: var(--card-shadow);
  transition: var(--transition);
  backdrop-filter: blur(10px);
  overflow: hidden;

  &:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 60px rgba(93, 92, 222, 0.2);
  }
}

.dark-mode .custom-card {
  background: rgba(46, 46, 46, 0.95);
  color: var(--text-light);
}

// Skills Section
.skill-item {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  border-radius: 15px;
  padding: 1.5rem;
  color: white;
  text-align: center;
  transition: var(--transition);
  cursor: pointer;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    transform: rotate(45deg);
    transition: var(--transition);
    opacity: 0;
  }

  &:hover::before {
    animation: shimmer 1s ease-in-out;
  }

  &:hover {
    transform: translateY(-5px) scale(1.05);
  }
}

@keyframes shimmer {
  0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); opacity: 0; }
  50% { opacity: 1; }
  100% { transform: translateX(100%) translateY(100%) rotate(45deg); opacity: 0; }
}

.skill-icon {
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

// Progress bars
.progress {
  height: 10px;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.2);
}

.progress-bar {
  border-radius: 10px;
  background: linear-gradient(90deg, var(--accent-color), var(--primary-color));
  transition: width 2s ease-in-out;
}

// Projects
.project-card {
  position: relative;
  overflow: hidden;
  border-radius: 15px;
  transition: var(--transition);
}

.project-image {
  width: 100%;
  height: 250px;
  object-fit: cover;
  transition: var(--transition);
}

.project-card:hover .project-image {
  transform: scale(1.1);
}

.project-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(93, 92, 222, 0.9), rgba(0, 221, 235, 0.9));
  color: white;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transition: var(--transition);
}

.project-card:hover .project-overlay {
  opacity: 1;
}

// Interactive Buttons
.btn-custom {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  border: none;
  border-radius: 50px;
  padding: 12px 30px;
  color: white;
  font-weight: 600;
  transition: var(--transition);
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: var(--transition);
  }

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(93, 92, 222, 0.4);
  }

  &:hover::before {
    left: 100%;
  }
}

.filter-btn {
  &.active {
    background: var(--primary-color);
    border-color: var(--primary-color);
    color: white;
  }
}

// Forms
.form-control {
  border-radius: 15px;
  border: 2px solid rgba(93, 92, 222, 0.2);
  padding: 15px 20px;
  transition: var(--transition);
  background: rgba(255, 255, 255, 0.9);
  font-size: 16px;

  &:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 20px rgba(93, 92, 222, 0.2);
    background: white;
  }
}

.dark-mode .form-control {
  background: rgba(46, 46, 46, 0.9);
  border-color: rgba(255, 255, 255, 0.2);
  color: var(--text-light);
}

// Comments Section
.comment-item {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 15px;
  padding: 1rem;
  margin-bottom: 1rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: var(--transition);

  &:hover {
    transform: translateX(10px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  }
}

// Fun Fact Popup
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1050;
}

.fun-fact-popup {
  background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
  color: white;
  padding: 2rem;
  border-radius: 20px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  max-width: 400px;
  text-align: center;
  margin: 1rem;
}

// Toast Notification
.toast-notification {
  position: fixed;
  top: 100px;
  right: 20px;
  background: linear-gradient(135deg, #28a745, #20c997);
  color: white;
  padding: 1rem 1.5rem;
  border-radius: 10px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  z-index: 1060;
  min-width: 300px;
}

// Theme Toggle
.theme-toggle {
  background: none;
  border: 2px solid var(--primary-color);
  border-radius: 50px;
  padding: 8px 16px;
  color: var(--primary-color);
  transition: var(--transition);

  &:hover {
    background: var(--primary-color);
    color: white;
    transform: scale(1.05);
  }
}

// Loading Animation
.loading-spinner {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

// Animations
.fade-in {
  animation: fadeIn 1s ease-in-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

.slide-in-left {
  animation: slideInLeft 1s ease-out;
}

@keyframes slideInLeft {
  from { opacity: 0; transform: translateX(-100px); }
  to { opacity: 1; transform: translateX(0); }
}

.slide-in-right {
  animation: slideInRight 1s ease-out;
}

@keyframes slideInRight {
  from { opacity: 0; transform: translateX(100px); }
  to { opacity: 1; transform: translateX(0); }
}

// Vue Transitions
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

.modal-enter-active, .modal-leave-active {
  transition: opacity 0.3s ease;
}
.modal-enter-from, .modal-leave-to {
  opacity: 0;
}

.toast-enter-active, .toast-leave-active {
  transition: all 0.3s ease;
}
.toast-enter-from, .toast-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

// Particle Animation
@keyframes particle-float {
  0% {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
  100% {
    opacity: 0;
    transform: scale(0) translateY(-200px);
  }
}
</style>