<template>
  <div
    :data-bs-theme="isDarkMode ? 'dark' : 'light'"
    :class="[
      'container-fluid',
      { 'bg-dark darkmode': isDarkMode, 'bg-light': !isDarkMode },
    ]"
  >
    <button
      @click="toggleTheme"
      class="theme-toggle theme-togglebtn btn-light btn-sm mt-50"
    >
      {{ isDarkMode ? "☀️ Light Mode" : "🌙 Dark Mode" }}
    </button>

    <!-- Ambient particles -->
    <div class="particles" aria-hidden="true">
      <span
        v-for="particle in particles"
        :key="particle.id"
        class="particle"
        :style="{
          left: particle.left + '%',
          top: particle.top + '%',
          width: particle.size + 'px',
          height: particle.size + 'px',
          animationDuration: particle.duration + 's',
          animationDelay: particle.delay + 's',
        }"
      ></span>
    </div>

    <!-- Hero Section -->
    <section id="home" class="py-5 d-flex align-items-center min-vh-100">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6 animate__animated animate__fadeInLeft">
            <p class="hero-kicker mb-2">
              Information Engineering @ CUHK · Hong Kong
            </p>
            <h1 class="display-3 fw-bold text-white hero-title">
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
                href="https://www.linkedin.com/in/helon-chan/"
                target="_blank"
                rel="noopener"
                class="btn btn-outline-light btn-lg"
                >💼 LinkedIn</a
              >
            </div>
          </div>
          <div
            class="col-lg-6 text-center animate__animated animate__fadeInRight"
          >
            <div class="hero-avatar-wrap">
              <div class="hero-avatar-glow"></div>
              <img
                src="/profile.jpg"
                alt="HeiChan"
                class="rounded-circle img-fluid shadow hero-avatar"
                style="max-width: 300px"
              />
            </div>
          </div>
        </div>
        <div class="scroll-cue text-center">
          <span class="scroll-cue-dot"></span>
        </div>
      </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-5" data-reveal>
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
                <h2 class="text-center mb-4 fw-bold text-danger">
                  <i class="fa-solid fa-house"></i>👤 About Me
                </h2>
                <p class="lead text-center mb-4">
                  I build across three domains — software engineering, cloud &
                  AI automation, and data — and I like problems that force me
                  to learn something new fast.
                </p>
                <div class="row">
                  <div class="col-md-6">
                    <h5 class="fw-bold">❤️ What I Work With</h5>
                    <ul class="list-unstyled">
                      <li>☁️ Cloud automation, IaC &amp; CI/CD</li>
                      <li>🤖 Applied AI pipelines &amp; REST APIs</li>
                      <li>🧩 Full-stack web &amp; mobile engineering</li>
                      <li>📊 Data tooling and automation</li>
                    </ul>
                  </div>
                  <div class="col-md-6">
                    <h5 class="fw-bold">🏆 Impact Highlights</h5>
                    <ul class="list-unstyled">
                      <li>🎓 BEng Information Engineering @ CUHK</li>
                      <li>☁️ Azure + Terraform + OIDC CI/CD automation</li>
                      <li>🤖 Fine-tuned Wav2Vec2 lyric transcription</li>
                      <li>⚡ 45% runtime cut on a legacy C#/SQL service</li>
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
    <section id="skills" class="py-5" data-reveal>
      <div class="container">
        <h2 class="text-center text-white mb-3 fw-bold">
          🛠️ Skills &amp; Expertise
        </h2>
        <p class="text-center text-white-75 mb-5">
          Software Engineering · Cloud &amp; AI · Data · Security
        </p>
        <div class="row">
          <div
            v-for="(skill, index) in skills"
            :key="index"
            class="col-12 col-md-6 col-lg-4 mb-4"
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
                <p class="card-text small mb-2">{{ skill.tagline }}</p>
                <p class="mb-0 small opacity-75">Click to learn more</p>
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
    <section id="projects" class="py-5" data-reveal>
      <div class="container">
        <h2 class="text-center text-white mb-3 fw-bold">
          📊 Featured Projects
        </h2>
        <p class="text-center text-white-75 mb-4">
          Real work from internships, CUHK Information Engineering coursework,
          and personal builds.
        </p>
        <div class="text-center mb-4">
          <button
            v-for="filter in projectFilters"
            :key="filter.value"
            :class="[
              'btn btn-outline-light me-2 mb-2',
              { 'btn-primary': activeFilter === filter.value },
            ]"
            @click="setActiveFilter(filter.value)"
          >
            {{ filter.label }}
          </button>
        </div>
        <div class="row">
          <div
            v-for="project in filteredProjects"
            :key="project.title"
            class="col-lg-4 col-md-6 mb-4"
          >
            <div
              :class="[
                'card h-100 shadow project-card',
                isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark',
              ]"
            >
              <img
                :src="project.image"
                :alt="project.title"
                class="card-img-top"
                style="height: 210px; object-fit: cover"
              />
              <div class="card-body d-flex flex-column">
                <div
                  class="d-flex justify-content-between align-items-start mb-2"
                >
                  <h5 class="card-title fw-bold mb-0 me-2">
                    {{ project.title }}
                  </h5>
                  <span class="badge bg-primary rounded-pill flex-shrink-0">{{
                    project.period
                  }}</span>
                </div>
                <p class="card-text small">{{ project.description }}</p>
                <ul class="list-unstyled small project-highlights mb-3">
                  <li
                    v-for="highlight in project.highlights"
                    :key="highlight"
                  >
                    ▹ {{ highlight }}
                  </li>
                </ul>
                <div class="mb-3">
                  <span
                    v-for="tech in project.technologies"
                    :key="tech"
                    class="badge bg-secondary me-1 mb-1"
                    >{{ tech }}</span
                  >
                </div>
                <div
                  class="mt-auto d-flex justify-content-between align-items-center"
                >
                  <small
                    :class="isDarkMode ? 'text-white-50' : 'text-muted'"
                  >
                    <span v-if="project.language"
                      >🛠️ {{ project.language }}</span
                    >
                    <span v-if="project.stars" class="ms-2"
                      >⭐ {{ project.stars }}</span
                    >
                    <span v-if="project.updatedAt" class="ms-2"
                      >· Updated {{ project.updatedAt }}</span
                    >
                  </small>
                  <a
                    v-if="project.link"
                    :href="project.link"
                    target="_blank"
                    rel="noopener"
                    class="btn btn-outline-primary btn-sm"
                    >GitHub ↗</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Comments Section -->
    <section id="comments" class="py-5" data-reveal>
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
    <section id="contact" class="py-5" data-reveal>
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
                      <p class="small text-muted text-center mt-2 mb-0">
                        Demo form — email me directly and I'll reply.
                      </p>
                    </form>
                  </div>
                  <div class="col-md-6">
                    <div class="mt-4 mt-md-0">
                      <div class="mb-4">
                        <h5 class="fw-bold">📍 Location</h5>
                        <p>Hong Kong</p>
                      </div>
                      <div class="mb-4">
                        <h5 class="fw-bold">✉️ Email</h5>
                        <p>
                          <a
                            :class="
                              isDarkMode ? 'link-light' : 'link-dark'
                            "
                            href="mailto:cccheilllun419@gmail.com"
                            >cccheilllun419@gmail.com</a
                          >
                        </p>
                      </div>
                      <div class="mb-4">
                        <h5 class="fw-bold">📞 Phone</h5>
                        <p>(+852) 6586 8120</p>
                      </div>
                      <div>
                        <h5 class="fw-bold">🔗 Find Me Online</h5>
                        <div class="d-flex gap-2 flex-wrap">
                          <a
                            href="https://github.com/ChanHei419"
                            target="_blank"
                            rel="noopener"
                            class="btn btn-outline-primary"
                            >GitHub</a
                          >
                          <a
                            href="https://www.linkedin.com/in/helon-chan/"
                            target="_blank"
                            rel="noopener"
                            class="btn btn-outline-primary"
                            >LinkedIn</a
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

const GITHUB_USERNAME = "ChanHei419";
const LINKEDIN_URL = "https://www.linkedin.com/in/helon-chan/";
const EMAIL = "cccheilllun419@gmail.com";

// Theme management — dark-first design, respects a saved preference
const isDarkMode = ref(true);
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
  if (import.meta.client) {
    localStorage.setItem("darkMode", isDarkMode.value.toString());
  }
};
const checkDarkMode = () => {
  if (import.meta.client) {
    const savedMode = localStorage.getItem("darkMode");
    if (savedMode) {
      isDarkMode.value = savedMode === "true";
    }
  }
};

// Typing animation
const typedText = ref("");
const texts = [
  "Hi, I'm HeiChan",
  "Cloud & AI Automation",
  "Full-Stack Engineer",
  "Data-Driven Problem Solver",
];
let currentTextIndex = 0;
let typingIndex = 0;
const startTypingAnimation = () => {
  const typeText = () => {
    const currentText = texts[currentTextIndex];
    if (typingIndex < currentText.length) {
      typedText.value += currentText.charAt(typingIndex);
      typingIndex++;
      setTimeout(typeText, 90);
    } else {
      setTimeout(eraseText, 2000);
    }
  };
  const eraseText = () => {
    if (typedText.value.length > 0) {
      typedText.value = typedText.value.slice(0, -1);
      setTimeout(eraseText, 40);
    } else {
      currentTextIndex = (currentTextIndex + 1) % texts.length;
      typingIndex = 0;
      setTimeout(typeText, 400);
    }
  };
  typeText();
};

// Subtitles
const subtitles = [
  "Building cloud automation and AI pipelines that ship.",
  "From Azure infrastructure to PyTorch audio models.",
  "Turning requirements into reliable, automated systems.",
  "Open to graduate roles in SWE, Cloud & AI, and Data.",
];
const currentSubtitle = ref(subtitles[0]);
let currentSubtitleIndex = 0;
let subtitleInterval = null;
const changeSubtitle = () => {
  currentSubtitleIndex = (currentSubtitleIndex + 1) % subtitles.length;
  currentSubtitle.value = subtitles[currentSubtitleIndex];
};

// Fun facts (all real, from project work)
const funFacts = [
  "I cut a legacy C#/SQL system's runtime from 2m 30s to 1m 20s — a 45% speed-up.",
  "My AI pipeline uses Demucs for vocal separation and a fine-tuned Wav2Vec2 for lyric transcription.",
  "I provision Azure infrastructure through Terraform with OIDC-based CI/CD — no long-lived secrets.",
  "I automated guest-domain whitelisting across SharePoint, Entra ID, and Teams with Copilot Studio.",
  "I shipped a Nuxt.js corporate site during a summer software internship.",
  "I run a home lab with Nmap and Suricata to practise network intrusion detection.",
];
const currentFunFact = ref("");
const showPopup = ref(false);
const showFunFact = () => {
  currentFunFact.value = funFacts[randomIndex(funFacts.length)];
  showPopup.value = true;
};
const hideFunFact = () => {
  showPopup.value = false;
};

// Skills
const skills = ref([
  {
    name: "Nuxt.js / Vue 3",
    icon: "💚",
    tagline: "Full-stack web engineering",
    description:
      "Built and deployed a production corporate website, plus this animated multi-page portfolio with Nuxt 3, Vue 3, and SCSS.",
    proficiency: 85,
    experience: "1+ year",
    level: "Advanced",
  },
  {
    name: "Python",
    icon: "🐍",
    tagline: "Automation & APIs",
    description:
      "Automation scripts, Flask / FastAPI REST APIs, and data tooling used across AI and reporting projects.",
    proficiency: 85,
    experience: "2+ years",
    level: "Advanced",
  },
  {
    name: "Azure & Terraform",
    icon: "☁️",
    tagline: "Infrastructure as Code",
    description:
      "Provisioned Azure resources as code with OIDC-based CI/CD, least-privilege identities, and Azure Automation runbooks.",
    proficiency: 80,
    experience: "Current role",
    level: "Advanced",
  },
  {
    name: "ServiceNow & Power Automate",
    icon: "⚙️",
    tagline: "Enterprise automation",
    description:
      "Custom tables, Business Rules, Script Includes, Virtual Agent routing, and cross-platform workflow automation.",
    proficiency: 82,
    experience: "Current role",
    level: "Advanced",
  },
  {
    name: "PyTorch & Wav2Vec2",
    icon: "🧠",
    tagline: "Applied AI",
    description:
      "Fine-tuned speech recognition models and designed a 3-stage lyric transcription pipeline, tracked with Word Error Rate.",
    proficiency: 72,
    experience: "Academic project",
    level: "Intermediate",
  },
  {
    name: "C# & SQL",
    icon: "🔷",
    tagline: "Legacy modernisation",
    description:
      "Optimized a legacy C#/SQL SMS system by 45% and rewrote queries to improve notification reliability.",
    proficiency: 72,
    experience: "Internship",
    level: "Intermediate",
  },
  {
    name: "REST API Design",
    icon: "🔌",
    tagline: "Backend services",
    description:
      "Designed Flask / FastAPI endpoints with asynchronous processing and real-time progress reporting.",
    proficiency: 82,
    experience: "2+ years",
    level: "Advanced",
  },
  {
    name: "SQL & MongoDB",
    icon: "🗄️",
    tagline: "Data modelling",
    description:
      "Schema design, complex queries, and document modelling for authentication, profiles, and chat history.",
    proficiency: 80,
    experience: "2+ years",
    level: "Advanced",
  },
  {
    name: "Data Structures & Algorithms",
    icon: "📊",
    tagline: "CS fundamentals",
    description:
      "CUHK Information Engineering coursework: complexity analysis, trees, graphs, and systems programming in C.",
    proficiency: 85,
    experience: "3 years",
    level: "Advanced",
  },
]);

const randomIndex = (length) => Math.floor(Math.random() * length);

const selectedSkill = ref(null);
const skillProgress = ref(0);
const showSkillDetails = (index) => {
  selectedSkill.value = skills.value[index];
  skillProgress.value = 0;
  setTimeout(() => {
    skillProgress.value = selectedSkill.value.proficiency;
  }, 300);
  if (import.meta.client) {
    setTimeout(() => {
      const element = document.querySelector("#skills .card:last-child");
      if (element) {
        element.scrollIntoView({ behavior: "smooth", block: "center" });
      }
    }, 100);
  }
};

// SVG cover generator (keeps the project grid visual without stock photos)
const svgCover = (label, sub, from, to) =>
  `data:image/svg+xml;charset=utf-8,${encodeURIComponent(
    `<svg xmlns="http://www.w3.org/2000/svg" width="800" height="480" viewBox="0 0 800 480">
      <defs>
        <linearGradient id="g" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stop-color="${from}"/>
          <stop offset="100%" stop-color="${to}"/>
        </linearGradient>
      </defs>
      <rect width="800" height="480" fill="url(#g)"/>
      <circle cx="690" cy="60" r="170" fill="rgba(255,255,255,0.10)"/>
      <circle cx="90" cy="440" r="130" fill="rgba(255,255,255,0.08)"/>
      <text x="60" y="250" font-family="Segoe UI, Arial, sans-serif" font-size="58" font-weight="700" fill="#ffffff">${label}</text>
      <text x="62" y="305" font-family="Segoe UI, Arial, sans-serif" font-size="26" fill="rgba(255,255,255,0.85)">${sub}</text>
    </svg>`
  )}`;

// Projects
const projects = ref([
  {
    title: "AI Lyric Detection System",
    period: "Oct – Dec 2025",
    category: "ai",
    description:
      "End-to-end AI pipeline that extracts lyrics from songs — vocal separation, speech recognition, and a REST API with a live web interface.",
    highlights: [
      "Designed a 3-stage pipeline (Demucs → Wav2Vec2 → text) combining two pretrained audio models",
      "Fine-tuned Wav2Vec2 on 57 song clips and tracked quality with Word Error Rate (WER)",
      "Built Flask REST endpoints for upload, async processing, real-time progress, and results",
    ],
    technologies: ["Python", "PyTorch", "Wav2Vec2", "Demucs", "Flask", "Gradio"],
    image: svgCover("AI Lyrics", "Demucs → Wav2Vec2 → Text", "#6d28d9", "#2563eb"),
    link: "",
  },
  {
    title: "Campus Navigator (Android)",
    period: "Oct – Dec 2025",
    category: "swe",
    description:
      "Android app for campus navigation with real-time map services, custom path planning, and a Retrofit-backed API over MongoDB.",
    highlights: [
      "Built RESTful backend integration with Retrofit covering auth, profiles, and chat history",
      "Integrated Google Maps API for real-time location services and custom path planning",
      "Modelled users, sessions, and messages in MongoDB",
    ],
    technologies: ["Kotlin", "MongoDB", "Google Maps API", "Retrofit"],
    image: svgCover("Campus Navigator", "Kotlin · Maps · MongoDB", "#0f766e", "#0ea5e9"),
    link: "",
  },
  {
    title: "Student Management System",
    period: "Laravel 12",
    category: "swe",
    description:
      "A Laravel 12 MVC application for managing students, teachers, and country records with a clean Blade interface.",
    highlights: [
      "Full CRUD with server-side validation, search, and pagination",
      "Migrations, seeders, factories, and soft deletes across Eloquent models",
      "Blade + Tailwind CSS 4 front end served through Vite",
    ],
    technologies: ["Laravel 12", "PHP 8.2", "MySQL", "Blade", "Tailwind CSS"],
    image: svgCover("Student Mgmt", "Laravel 12 · Blade · SQL", "#b91c1c", "#f97316"),
    link: "https://github.com/ChanHei419/studentManagement",
  },
  {
    title: "HeiChan CV Platform",
    period: "Nuxt 3",
    category: "swe",
    description:
      "This portfolio: a multi-page Nuxt 3 site with dark mode, an animated hero, live GitHub stats, and interactive dashboards.",
    highlights: [
      "Nuxt 3 file-based routing, layouts, and component auto-imports",
      "Live GitHub REST API stats with graceful offline fallbacks",
      "Custom SCSS animations, project filters, and export / share utilities",
    ],
    technologies: ["Nuxt 3", "Vue 3", "Bootstrap 5", "SCSS"],
    image: svgCover("CV Platform", "Nuxt 3 · Vue 3", "#4338ca", "#7c3aed"),
    link: "https://github.com/ChanHei419/MyCV",
  },
  {
    title: "Network Intrusion Detection Lab",
    period: "Mar – Apr 2026",
    category: "security",
    description:
      "Hands-on security lab: network reconnaissance and signature-based intrusion detection on Linux-based networks.",
    highlights: [
      "Scanned lab networks with Nmap to map hosts and exposed services",
      "Configured Suricata IDS rules to detect and log threat indicators",
    ],
    technologies: ["Linux", "Nmap", "Suricata"],
    image: svgCover("Network IDS", "Nmap · Suricata", "#1f2937", "#475569"),
    link: "",
  },
]);

const projectFilters = ref([
  { label: "All", value: "all" },
  { label: "AI & Cloud", value: "ai" },
  { label: "Full-Stack", value: "swe" },
  { label: "Security", value: "security" },
]);
const activeFilter = ref("all");
const filteredProjects = computed(() => {
  if (activeFilter.value === "all") return projects.value;
  return projects.value.filter(
    (project) => project.category === activeFilter.value
  );
});
const setActiveFilter = (filter) => {
  activeFilter.value = filter;
};

// Live GitHub stats with graceful fallback
const fetchProjectStats = async () => {
  try {
    const response = await fetch(
      `https://api.github.com/users/${GITHUB_USERNAME}/repos?per_page=100`
    );
    if (!response.ok) return;
    const repos = await response.json();
    repos.forEach((repo) => {
      const project = projects.value.find(
        (item) => item.link === repo.html_url
      );
      if (project) {
        project.stars = repo.stargazers_count;
        project.language = repo.language;
        project.updatedAt = new Date(repo.pushed_at).toLocaleDateString(
          "en-US",
          { month: "short", year: "numeric" }
        );
      }
    });
  } catch (error) {
    // Offline or rate-limited — cards simply fall back to static info.
  }
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
  const sender = contactForm.value.name;
  if (import.meta.client) {
    const subject = encodeURIComponent(contactForm.value.subject);
    const body = encodeURIComponent(
      `${contactForm.value.message}\n\n— ${sender} (${contactForm.value.email})`
    );
    window.location.href = `mailto:${EMAIL}?subject=${subject}&body=${body}`;
  }
  isSubmitting.value = true;
  setTimeout(() => {
    isSubmitting.value = false;
    contactForm.value = { name: "", email: "", subject: "", message: "" };
    showSuccessMessage("Ready to send from your mail app!");
  }, 800);
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
  if (import.meta.client) {
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
  }
};

// Ambient particles
const particles = ref([]);
const buildParticles = () => {
  particles.value = Array.from({ length: 26 }, (_, id) => ({
    id,
    left: Math.random() * 100,
    top: Math.random() * 100,
    size: 2 + Math.random() * 4,
    duration: 10 + Math.random() * 14,
    delay: -Math.random() * 24,
  }));
};

// Scroll-reveal animations
const observeReveals = () => {
  if (!import.meta.client || !("IntersectionObserver" in window)) return;
  document.documentElement.classList.add("reveal-init");
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.12 }
  );
  document
    .querySelectorAll("[data-reveal]")
    .forEach((element) => observer.observe(element));
};

// Lifecycle hooks
onMounted(() => {
  checkDarkMode();
  buildParticles();
  startTypingAnimation();
  fetchProjectStats();
  observeReveals();
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
  position: relative;
  overflow-x: hidden;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

  &.bg-dark {
    background:
      radial-gradient(1100px 600px at 12% 8%, rgba(124, 58, 237, 0.32), transparent 60%),
      radial-gradient(900px 520px at 88% 18%, rgba(37, 99, 235, 0.28), transparent 62%),
      radial-gradient(800px 600px at 50% 100%, rgba(14, 165, 233, 0.18), transparent 65%),
      linear-gradient(160deg, #070b18 0%, #0d1226 55%, #140f2b 100%);
  }
}

/* Keep content above ambient particles */
.container,
section {
  position: relative;
  z-index: 1;
}

/* Ambient floating particles */
.particles {
  position: fixed;
  inset: 0;
  pointer-events: none;
  overflow: hidden;
  z-index: 0;
}

.particle {
  position: absolute;
  border-radius: 50%;
  background: rgba(199, 210, 254, 0.45);
  box-shadow: 0 0 10px rgba(125, 211, 252, 0.45);
  animation-name: particle-drift;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
}

@keyframes particle-drift {
  0% {
    transform: translateY(0) scale(1);
    opacity: 0.15;
  }
  50% {
    opacity: 0.85;
  }
  100% {
    transform: translateY(-48px) scale(1.25);
    opacity: 0.1;
  }
}

/* Hero extras */
.hero-title {
  background: linear-gradient(92deg, #ffffff 0%, #c7d2fe 45%, #7dd3fc 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-title .typing-cursor {
  -webkit-text-fill-color: #7dd3fc;
}

.hero-avatar-wrap {
  position: relative;
  display: inline-block;
}

.hero-avatar-glow {
  position: absolute;
  inset: -18px;
  border-radius: 50%;
  background: conic-gradient(from 0deg, #7c3aed, #2563eb, #06b6d4, #7c3aed);
  filter: blur(26px);
  opacity: 0.55;
  animation: glow-spin 12s linear infinite;
  z-index: 0;
}

.hero-avatar {
  position: relative;
  z-index: 1;
  border: 3px solid rgba(255, 255, 255, 0.18);
  animation: float-soft 6s ease-in-out infinite;
}

@keyframes glow-spin {
  to {
    transform: rotate(360deg);
  }
}

@keyframes float-soft {
  0%,
  100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-12px);
  }
}

/* Scroll cue */
.scroll-cue {
  margin-top: 2rem;
}

.scroll-cue-dot {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.85);
  box-shadow: 0 0 0 6px rgba(255, 255, 255, 0.12);
  animation: cue-bounce 1.8s ease-in-out infinite;
}

@keyframes cue-bounce {
  0%,
  100% {
    transform: translateY(0);
    opacity: 0.9;
  }
  50% {
    transform: translateY(12px);
    opacity: 0.4;
  }
}

/* Glass panels in dark mode */
.bg-dark {
  .card {
    background: rgba(17, 24, 43, 0.62) !important;
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);
    border: 1px solid rgba(148, 163, 184, 0.18);
    color: #e2e8f0;
  }

  .card:hover {
    border-color: rgba(125, 211, 252, 0.45);
    box-shadow: 0 0 0 1px rgba(125, 211, 252, 0.18),
      0 18px 40px rgba(2, 6, 23, 0.55) !important;
  }
}

/* Neon buttons */
.btn-primary {
  background: linear-gradient(120deg, #6d28d9, #2563eb);
  border: none;
  box-shadow: 0 6px 20px rgba(76, 29, 149, 0.35);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 28px rgba(56, 189, 248, 0.35);
}

/* Scroll-reveal */
.reveal-init [data-reveal] {
  opacity: 0;
  transform: translateY(26px);
  transition: opacity 0.7s ease, transform 0.7s ease;
}

.reveal-init [data-reveal].is-visible {
  opacity: 1;
  transform: none;
}

@media (prefers-reduced-motion: reduce) {
  .particle,
  .hero-avatar,
  .hero-avatar-glow,
  .scroll-cue-dot {
    animation: none !important;
  }

  .reveal-init [data-reveal] {
    opacity: 1;
    transform: none;
    transition: none;
  }
}

/* Hero */
.hero-kicker {
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.8);
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

/* Project highlights */
.project-highlights li {
  margin-bottom: 0.35rem;
  opacity: 0.9;
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
  font-weight: bold;
}
.navbar-brand {
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
</style>