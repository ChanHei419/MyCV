<template>
  


  <div
  
    data-bs-theme="light"
    :class="[
      'container-fluid',
      { 'bg-dark darkmode': isDarkMode, 'bg-light': !isDarkMode },
    ]"
  >
  <button  @click="toggleTheme" class=" theme-toggle theme-togglebtn btn-light btn-sm mt-50">
            {{ isDarkMode ? "☀️ Light Mode" : "🌙 Dark Mode" }}
          </button>
    <!-- Navigation Bar -->
   
    <!-- Hero Section -->
    <section id="home" class="py-5 d-flex align-items-center min-vh-100">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6 animate__animated animate__fadeInLeft">
            <h1 class="display-3 fw-bold text-white">
              {{ typedText }}<span class="typing-cursor">|</span>
            </h1>
            <p
              class="lead"
              :class="{
                'text-white': isDarkMode,
                'text-white-75': !isDarkMode,
              }"
            >
              {{ currentSubtitle }}
            </p>
            <div class="d-flex flex-wrap gap-3 mb-4">
              <button class="btn btn-primary" @click="showFunFact">
                💡 Fun Fact
              </button>
              <button class="btn btn-primary" @click="changeSubtitle">
                🔄 New Tagline
              </button>
            </div>
            <div class="d-flex flex-wrap gap-3">
              <button
                class="btn btn-outline-light btn-lg"
                @click="scrollToSection('projects')"
              >
                📁 View My Work
              </button>
              <button
                class="btn btn-outline-light btn-lg"
                @click="scrollToSection('contact')"
              >
                ✉️ Get In Touch
              </button>
              <a
                href="/path/to/resume.pdf"
                download
                class="btn btn-outline-light btn-lg"
                >📄 Download Resume</a
              >
            </div>
          </div>
          <div
            class="col-lg-6 text-center animate__animated animate__fadeInRight"
          >
            <img
              src="/static/helen.jpg"
              alt="Helen Chan"
              class="rounded-circle img-fluid shadow"
              style="max-width: 300px"
            />
          </div>
        </div>
      </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-5">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
            <div
              :class="[
                'card shadow',
                isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
              ]"
            >
              <div class="card-body p-5">
                <h2 class="text-center mb-4 fw-bold text-danger"><i class="fa-solid fa-house"></i>👤 About Me</h2>
                <p class="lead text-center mb-4">
                  Passionate web developer with a love for creating beautiful,
                  functional, and user-friendly digital experiences.
                </p>
                <div class="row">
                  <div class="col-md-6">
                    <h5 class="fw-bold">❤️ What I Love</h5>
                    <ul class="list-unstyled">
                      <li>💻 Clean, efficient code</li>
                      <li>🎨 Modern UI/UX design</li>
                      <li>📱 Responsive development</li>
                      <li>🚀 Performance optimization</li>
                    </ul>
                  </div>
                  <div class="col-md-6">
                    <h5 class="fw-bold">🏆 Achievements</h5>
                    <ul class="list-unstyled">
                      <li>🥇 50+ Projects completed</li>
                      <li>👥 100+ Happy clients</li>
                      <li>⏰ 3+ Years experience</li>
                      <li>☕ 1000+ Cups of coffee</li>
                    </ul>
                  </div>
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
        <h2 class="text-center text-white mb-5 fw-bold">
          🛠️ Skills & Expertise
        </h2>
        <div class="row">
          <div
            v-for="(skill, index) in skills"
            :key="index"
            class="col-12 col-md-6 col-lg-4  mb-4"
          >
            <div
              :class="[
                'card h-100 shadow',
                isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
              ]"
              @click="showSkillDetails(index)"
            >
              <div class="card-body text-center">
                <span class="fs-2 mb-3 d-block">{{ skill.icon }}</span>
                <h5 class="card-title fw-bold">{{ skill.name }}</h5>
                <p class="card-text">Click to learn more</p>
              </div>
            </div>
          </div>
        </div>
        <Transition name="fade">
          <div v-if="selectedSkill" class="row mt-5">
            <div class="col-lg-8 mx-auto">
              <div
                :class="[
                  'card shadow',
                  isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
                ]"
              >
                <div class="card-body p-4">
                  <h4 class="card-title fw-bold">{{ selectedSkill.name }}</h4>
                  <p class="card-text">{{ selectedSkill.description }}</p>
                  <div class="progress mb-3">
                    <div
                      class="progress-bar bg-primary"
                      :style="{ width: skillProgress + '%' }"
                    ></div>
                  </div>
                  <div class="d-flex justify-content-between">
                    <small>Experience: {{ selectedSkill.experience }}</small>
                    <small>Level: {{ selectedSkill.level }}</small>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </Transition>
      </div>
    </section>

    <!-- Projects Section -->
    <section id="projects" class="py-5">
      <div class="container">
        <h2 class="text-center text-white mb-5 fw-bold">
          📊 Featured Projects
        </h2>
        <div class="text-center mb-4">
          <button
            v-for="filter in projectFilters"
            :key="filter.value"
            :class="[
              'btn btn-outline-light me-2',
              { 'btn-primary': activeFilter === filter.value },
            ]"
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
            <div
              :class="[
                'card h-100 shadow',
                isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
              ]"
            >
              <img
                :src="project.image"
                :alt="project.title"
                class="card-img-top"
                style="height: 250px; object-fit: cover"
              />
              <div class="card-body position-relative">
                <div class="project-overlay">
                  <h5 class="card-title fw-bold">{{ project.title }}</h5>
                  <p class="card-text">{{ project.description }}</p>
                  <div class="mb-3">
                    <span
                      v-for="tech in project.technologies"
                      :key="tech"
                      class="badge bg-light text-dark me-1"
                      >{{ tech }}</span
                    >
                  </div>
                  <div class="mb-3">
                    <span class="me-3"
                      >⭐ {{ projectStats[index]?.stars || 0 }} Stars</span
                    >
                    <span>👀 {{ projectStats[index]?.views || 0 }} Views</span>
                  </div>
                  <a :href="project.link" class="btn btn-light"
                    >🔗 View Project</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Comments Section -->
    <section id="comments" class="py-5">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
            <div
              :class="[
                'card shadow',
                isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
              ]"
            >
              <div class="card-body p-5">
                <h3 class="text-center mb-4 fw-bold">💬 Leave a Comment</h3>
                <form @submit.prevent="addComment" class="mb-4">
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <input
                        v-model="commentForm.name"
                        type="text"
                        class="form-control"
                        placeholder="Your Name"
                        required
                      />
                    </div>
                    <div class="col-md-6 mb-3">
                      <input
                        v-model="commentForm.email"
                        type="email"
                        class="form-control"
                        placeholder="Your Email"
                        required
                      />
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
                    <button type="submit" class="btn btn-primary">
                      📤 Post Comment
                    </button>
                  </div>
                </form>
                <h5 class="mb-3">Recent Comments ({{ comments.length }})</h5>
                <div
                  v-if="comments.length === 0"
                  class="text-muted text-center"
                >
                  No comments yet. Be the first to leave a comment!
                </div>
                <div v-else>
                  <div
                    v-for="(comment, index) in comments"
                    :key="index"
                    :class="[
                      'p-3 mb-2 rounded',
                      isDarkMode ? 'bg-dark-subtle' : 'bg-light',
                    ]"
                  >
                    <div
                      class="d-flex justify-content-between align-items-start mb-2"
                    >
                      <h6 class="mb-0 fw-bold">{{ comment.name }}</h6>
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
            <div
              :class="[
                'card shadow',
                isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
              ]"
            >
              <div class="card-body p-5">
                <h2 class="text-center mb-4 fw-bold">📧 Get In Touch</h2>
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
                        />
                      </div>
                      <div class="mb-3">
                        <input
                          v-model="contactForm.email"
                          type="email"
                          class="form-control"
                          placeholder="Your Email"
                          required
                        />
                      </div>
                      <div class="mb-3">
                        <input
                          v-model="contactForm.subject"
                          type="text"
                          class="form-control"
                          placeholder="Subject"
                          required
                        />
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
                      <button
                        type="submit"
                        class="btn btn-primary w-100"
                        :disabled="isSubmitting"
                      >
                        <span v-if="!isSubmitting">Send Message</span>
                        <span v-else
                          ><span
                            class="spinner-border spinner-border-sm me-2"
                          ></span
                          >Sending...</span
                        >
                      </button>
                    </form>
                  </div>
                  <div class="col-md-6">
                    <div class="mt-4 mt-md-0">
                      <div class="mb-4">
                        <h5 class="fw-bold">📍 Location</h5>
                        <p>San Francisco, CA</p>
                      </div>
                      <div class="mb-4">
                        <h5 class="fw-bold">✉️ Email</h5>
                        <p>helen.chan@email.com</p>
                      </div>
                      <div class="mb-4">
                        <h5 class="fw-bold">📞 Phone</h5>
                        <p>+1 (555) 123-4567</p>
                      </div>
                      <div>
                        <h5 class="fw-bold">🔗 Follow Me</h5>
                        <div class="d-flex gap-2 flex-wrap">
                          <a href="#" class="btn btn-outline-primary"
                            >LinkedIn</a
                          >
                          <a href="#" class="btn btn-outline-primary">GitHub</a>
                          <a href="#" class="btn btn-outline-primary"
                            >Twitter</a
                          >
                          <a href="#" class="btn btn-outline-primary"
                            >Instagram</a
                          >
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
    </section>

    <!-- Fun Fact Modal -->
    <Transition name="modal">
      <div
        v-if="showPopup"
        class="modal fade show d-block"
        tabindex="-1"
        @click="hideFunFact"
      >
        <div class="modal-dialog modal-dialog-centered" @click.stop>
          <div
            :class="[
              'modal-content',
              isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
            ]"
          >
            <div class="modal-body text-center">
              <h4 class="fw-bold">🎉 Fun Fact!</h4>
              <p>{{ currentFunFact }}</p>
              <button class="btn btn-light" @click="hideFunFact">
                Got it!
              </button>
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Toast Notification -->
    <Transition name="toast">
      <div
        v-if="showToast"
        class="toast show position-fixed top-0 end-0 m-3"
        role="alert"
      >
        <div class="toast-body bg-success text-white">
          ✅ {{ toastMessage }}
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from "vue";

/*
definePageMeta({
  layout: 'default',
})*/
// Theme management

const isDarkMode = ref(false);
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
  if (process.client) {
    localStorage.setItem("darkMode", isDarkMode.value.toString());
  }
};
const checkDarkMode = () => {
  if (process.client) {
    const savedMode = localStorage.getItem("darkMode");
    if (savedMode) {
      isDarkMode.value = savedMode === "true";
    }
  }
};

// Typing animation
const typedText = ref("");
const texts = [
  "Hi, I'm Helen Chan",
  "Web Developer",
  "UI/UX Designer",
  "Problem Solver",
];
let currentTextIndex = 0;
let typingIndex = 0;
const startTypingAnimation = () => {
  const typeText = () => {
    const currentText = texts[currentTextIndex];
    if (typingIndex < currentText.length) {
      typedText.value += currentText.charAt(typingIndex);
      typingIndex++;
      setTimeout(typeText, 100);
    } else {
      setTimeout(eraseText, 2000);
    }
  };
  const eraseText = () => {
    if (typedText.value.length > 0) {
      typedText.value = typedText.value.slice(0, -1);
      setTimeout(eraseText, 50);
    } else {
      currentTextIndex = (currentTextIndex + 1) % texts.length;
      typingIndex = 0;
      setTimeout(typeText, 500);
    }
  };
  typeText();
};

// Subtitles
const subtitles = [
  "Building the web, one line at a time.",
  "Turning ideas into interactive experiences.",
  "Passionate about code and creativity.",
  "Welcome to my digital playground!",
];
const currentSubtitle = ref(subtitles[0]);
let currentSubtitleIndex = 0;
let subtitleInterval = null;
const changeSubtitle = () => {
  currentSubtitleIndex = (currentSubtitleIndex + 1) % subtitles.length;
  currentSubtitle.value = subtitles[currentSubtitleIndex];
};

// Fun facts
const funFacts = [
  "I once coded for 24 hours straight and only stopped for coffee! ☕",
  "I've built over 50 websites and each one taught me something new! 🚀",
  "I started coding at age 16 with a simple 'Hello World' program! 👨‍💻",
  "I can solve a Rubik's cube while debugging code! 🧩",
  "I've consumed over 1,000 cups of coffee while coding! ☕",
  "I learned my first programming language from a library book! 📚",
];
const currentFunFact = ref("");
const showPopup = ref(false);
const showFunFact = () => {
  const randomIndex = Math.floor(Math.random() * funFacts.length);
  currentFunFact.value = funFacts[randomIndex];
  showPopup.value = true;
};
const hideFunFact = () => {
  showPopup.value = false;
};

// Skills
const skills = ref([
  {
    name: "JavaScript",
    icon: "⚡",
    description:
      "Modern ES6+ JavaScript development with focus on clean, efficient code.",
    proficiency: 90,
    experience: "3+ years",
    level: "Expert",
  },
  {
    name: "React",
    icon: "⚛️",
    description: "Building dynamic user interfaces with React and Redux.",
    proficiency: 85,
    experience: "2+ years",
    level: "Advanced",
  },
  {
    name: "Vue.js",
    icon: "💚",
    description: "Creating reactive applications with Vue.js and Nuxt.js.",
    proficiency: 80,
    experience: "2+ years",
    level: "Advanced",
  },
  {
    name: "Node.js",
    icon: "🟢",
    description: "Backend development with Node.js and Express.",
    proficiency: 75,
    experience: "2+ years",
    level: "Intermediate",
  },
  {
    name: "Python",
    icon: "🐍",
    description: "Data analysis and web development with Python.",
    proficiency: 70,
    experience: "1+ years",
    level: "Intermediate",
  },
  {
    name: "CSS",
    icon: "🎨",
    description: "Responsive design with CSS3, SASS, and modern frameworks.",
    proficiency: 95,
    experience: "3+ years",
    level: "Expert",
  },
]);
const selectedSkill = ref(null);
const skillProgress = ref(0);
const showSkillDetails = (index) => {
  selectedSkill.value = skills.value[index];
  skillProgress.value = 0;
  setTimeout(() => {
    skillProgress.value = selectedSkill.value.proficiency;
  }, 300);
  if (process.client) {
    setTimeout(() => {
      const element = document.querySelector("#skills .card:last-child");
      if (element) {
        element.scrollIntoView({ behavior: "smooth", block: "center" });
      }
    }, 100);
  }
};

// Projects
const projects = ref([
  {
    title: "E-Commerce Platform",
    description: "Full-stack e-commerce solution with React and Node.js",
    image: "https://picsum.photos/400/250?random=2",
    category: "web",
    technologies: ["React", "Node.js", "MongoDB"],
    link: "#",
  },
  {
    title: "Mobile Banking App",
    description: "React Native app for mobile banking",
    image: "https://picsum.photos/400/250?random=3",
    category: "mobile",
    technologies: ["React Native", "Firebase"],
    link: "#",
  },
  {
    title: "Portfolio Website",
    description: "Responsive portfolio website with modern design",
    image: "https://picsum.photos/400/250?random=4",
    category: "design",
    technologies: ["HTML", "CSS", "JavaScript"],
    link: "#",
  },
  {
    title: "Task Management App",
    description: "Vue.js application for project management",
    image: "https://picsum.photos/400/250?random=5",
    category: "web",
    technologies: ["Vue.js", "Vuex", "Firebase"],
    link: "#",
  },
  {
    title: "Weather Dashboard",
    description: "Real-time weather application with data visualization",
    image: "https://picsum.photos/400/250?random=6",
    category: "web",
    technologies: ["JavaScript", "Chart.js", "API"],
    link: "#",
  },
  {
    title: "Brand Identity Design",
    description: "Complete brand identity and logo design",
    image: "https://picsum.photos/400/250?random=7",
    category: "design",
    technologies: ["Photoshop", "Illustrator"],
    link: "#",
  },
]);
const projectFilters = ref([
  { label: "All", value: "all" },
  { label: "Web Apps", value: "web" },
  { label: "Mobile", value: "mobile" },
  { label: "Design", value: "design" },
]);
const activeFilter = ref("all");
const filteredProjects = computed(() => {
  if (activeFilter.value === "all") return projects.value;
  return projects.value.filter(
    (project) => project.category === activeFilter.value
  );
});
const projectStats = ref({});
const fetchProjectStats = () => {
  const mockStats = projects.value.reduce((acc, _, index) => {
    acc[index] = {
      stars: Math.floor(Math.random() * 1000),
      views: Math.floor(Math.random() * 5000),
    };
    return acc;
  }, {});
  projectStats.value = mockStats;
};
const setActiveFilter = (filter) => {
  activeFilter.value = filter;
};

// Comments
const comments = ref([]);
const commentForm = ref({ name: "", email: "", message: "" });
const addComment = () => {
  if (
    commentForm.value.name &&
    commentForm.value.email &&
    commentForm.value.message
  ) {
    comments.value.unshift({
      name: commentForm.value.name,
      email: commentForm.value.email,
      message: commentForm.value.message,
      timestamp: new Date().toLocaleString(),
    });
    commentForm.value = { name: "", email: "", message: "" };
    showSuccessMessage("Comment added successfully!");
  }
};

// Contact form
const contactForm = ref({ name: "", email: "", subject: "", message: "" });
const isSubmitting = ref(false);
const handleContactForm = () => {
  isSubmitting.value = true;
  setTimeout(() => {
    isSubmitting.value = false;
    contactForm.value = { name: "", email: "", subject: "", message: "" };
    showSuccessMessage("Message sent successfully!");
  }, 2000);
};

// Toast notification
const showToast = ref(false);
const toastMessage = ref("");
const showSuccessMessage = (message) => {
  toastMessage.value = message;
  showToast.value = true;
  setTimeout(() => {
    showToast.value = false;
  }, 3000);
};

// Scroll to section
const scrollToSection = (sectionId) => {
  if (process.client) {
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
  }
};

// Lifecycle hooks
onMounted(() => {
  checkDarkMode();
  startTypingAnimation();
  fetchProjectStats();
  subtitleInterval = setInterval(() => {
    changeSubtitle();
  }, 5000);
});
onUnmounted(() => {
  if (subtitleInterval) {
    clearInterval(subtitleInterval);
  }
});
</script>

<style lang="scss" scoped>
/* Minimal SCSS for essential customizations */
.container-fluid {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  &.bg-dark {
    background: linear-gradient(135deg, #232526 0%, #414345 100%);
  }
}

/* Navbar */
.navbar {
  background: linear-gradient(
    45deg,
    rgba(93, 92, 222, 0.95),
    rgba(0, 221, 235, 0.95)
  ) !important;
}
.bg-dark .navbar {
  background: linear-gradient(
    45deg,
    rgba(35, 37, 38, 0.95),
    rgba(65, 67, 69, 0.95)
  ) !important;
}
.nav-link:hover::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 100%;
  height: 2px;
  background: #e22a2a;
  transform: translateX(-50%);
}

/* Typing cursor */
.typing-cursor {
  animation: blink 1s infinite;
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

/* Card hover effect */
.card {
  transition: all 0.2s ease;
}
.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2) !important;
}

/* Project overlay */
.project-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    135deg,
    rgba(93, 92, 222, 0.9),
    rgba(0, 221, 235, 0.9)
  );
  color: white;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}
.card:hover .project-overlay {
  opacity: 1;
}

/* Progress bar */
.progress {
  height: 10px;
  border-radius: 10px;
}
.progress-bar {
  transition: width 2s ease-in-out;
}

/* Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}
.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}
.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}
.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

/* White text for headers */
h1,
h2,
h3,
h4,
h5,
h6 {
  //color: #ffffff !important;
  font-weight: bold;
}
.navbar-brand {
  // color: #ffffff !important;
  font-weight: bold;
}
</style>

<style>
/* global css */
.darkmode {
  background-color: #121212;
  color: #ffffff;
}

.theme-toggle {
  position: fixed;
  bottom: 20px;
  right: 20px;
  padding: 10px 20px;
  border-radius: 8px;
  border: none;
  background-color: var(--toggle-bg, #4a90e2);
  color: var(--toggle-color, #fff);
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease, transform 0.2s ease;
  z-index: 1000; /* Ensure it stays above other content */
}

.theme-toggle:hover {
  background-color: var(--toggle-hover-bg, #357abd);
  transform: scale(1.05);
}

.theme-toggle:focus {
  outline: 2px solid var(--toggle-focus, #2a5a94);
  outline-offset: 2px;
}

/* Optional: Adjust for dark mode */
[data-theme="dark"] .theme-toggle {
  --toggle-bg: #6b7280;
  --toggle-hover-bg: #4b5563;
  --toggle-focus: #9ca3af;
}

.theme-toggle {
  position: fixed;
  bottom: 20px;
  right: 20px;
  padding: 10px 20px;
  border-radius: 8px;
  border: none;
  background-color: var(--toggle-bg, #4a90e2);
  color: var(--toggle-color, #fff);
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease, transform 0.2s ease;
  z-index: 1000; /* Ensure it stays above other content */
}

.theme-toggle:hover {
  background-color: var(--toggle-hover-bg, #357abd);
  transform: scale(1.05);
}

.theme-toggle:focus {
  outline: 2px solid var(--toggle-focus, #2a5a94);
  outline-offset: 2px;
}

/* Optional: Adjust for dark mode */
[data-theme="dark"] .theme-toggle {
  --toggle-bg: #6b7280;
  --toggle-hover-bg: #4b5563;
  --toggle-focus: #9ca3af;
}

</style>
