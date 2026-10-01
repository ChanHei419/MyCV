<template>
  <main class="home">
    <button class="theme-toggle" @click="toggleTheme" aria-label="Toggle theme">
      <i :class="isDarkMode ? 'fa-solid fa-sun' : 'fa-solid fa-moon'"></i>
    </button>

    <!-- ================= Hero ================= -->
    <section class="hero section-shell">
      <div class="container">
        <div class="row align-items-center g-5">
          <div class="col-lg-7" data-reveal>
            <span class="section-kicker">
              <i class="fa-solid fa-graduation-cap"></i>
              BEng Information Engineering · CUHK
            </span>
            <h1 class="hero-title">
              <span class="gradient-text">{{ typedText }}</span
              ><span class="typing-cursor">|</span>
            </h1>
            <p class="hero-lede">
              I build across three domains — software engineering, cloud &amp;
              AI automation, and data. From Azure infrastructure as code to
              applied audio ML and full-stack applications, I like problems
              that force me to learn something new fast.
            </p>

            <div class="d-flex flex-wrap gap-3 mt-4">
              <button class="btn btn-primary btn-lg" @click="scrollToSection('projects')">
                <i class="fa-solid fa-diagram-project me-2"></i>View Projects
              </button>
              <button class="btn btn-outline-light btn-lg" @click="scrollToSection('contact')">
                <i class="fa-solid fa-paper-plane me-2"></i>Get In Touch
              </button>
              <a
                href="https://github.com/ChanHei419"
                target="_blank"
                rel="noopener"
                class="btn btn-outline-light btn-lg"
              >
                <i class="fa-brands fa-github me-2"></i>GitHub
              </a>
            </div>

            <div class="row g-3 mt-5">
              <div class="col-6 col-md-3">
                <div class="glass-card stat-tile">
                  <div class="stat-value">{{ stats.repos }}</div>
                  <div class="stat-label">Public Repos</div>
                </div>
              </div>
              <div class="col-6 col-md-3">
                <div class="glass-card stat-tile">
                  <div class="stat-value">{{ stats.projects }}</div>
                  <div class="stat-label">Featured Projects</div>
                </div>
              </div>
              <div class="col-6 col-md-3">
                <div class="glass-card stat-tile">
                  <div class="stat-value">22</div>
                  <div class="stat-label">Skills</div>
                </div>
              </div>
              <div class="col-6 col-md-3">
                <div class="glass-card stat-tile">
                  <div class="stat-value">4</div>
                  <div class="stat-label">Domains</div>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-5 text-center" data-reveal>
            <div class="avatar-stage">
              <div class="avatar-ring"></div>
              <img src="/profile.jpg" alt="HeiChan" class="avatar-image" />
              <span class="tech-orbit orbit-1" title="Microsoft Azure">
                <i class="fa-brands fa-microsoft"></i>
              </span>
              <span class="tech-orbit orbit-2" title="PyTorch">
                <i class="fa-solid fa-brain"></i>
              </span>
              <span class="tech-orbit orbit-3" title="Nuxt 3 / Vue">
                <i class="fa-brands fa-vuejs"></i>
              </span>
              <span class="tech-orbit orbit-4" title="Terraform">
                <i class="fa-solid fa-cubes"></i>
              </span>
              <span class="tech-orbit orbit-5" title="Python">
                <i class="fa-brands fa-python"></i>
              </span>
              <span class="tech-orbit orbit-6" title="SQL Databases">
                <i class="fa-solid fa-database"></i>
              </span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ================= What I Do ================= -->
    <section class="section-shell" data-reveal>
      <div class="container">
        <div class="text-center mb-5">
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-bullseye"></i> What I Do
          </span>
          <h2 class="section-title gradient-text">Four domains, one engineer</h2>
          <p class="section-lede mx-auto">
            Every project I take on lands in one of these areas — and most of
            them connect more than one.
          </p>
        </div>

        <div class="row g-4">
          <div v-for="domain in domains" :key="domain.title" class="col-md-6 col-xl-3">
            <div class="glass-card h-100 p-4">
              <span class="icon-badge mb-3">
                <i :class="domain.icon"></i>
              </span>
              <h3 class="h5 fw-bold mb-2">{{ domain.title }}</h3>
              <p class="text-muted-s small mb-3">{{ domain.description }}</p>
              <div class="d-flex flex-wrap gap-1">
                <span v-for="tech in domain.tech" :key="tech" class="chip">{{ tech }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ================= Tech Stack ================= -->
    <section class="section-shell" data-reveal>
      <div class="container">
        <div class="row g-4 align-items-start">
          <div class="col-lg-4">
            <span class="section-kicker">
              <i class="fa-solid fa-microchip"></i> Tech Stack
            </span>
            <h2 class="section-title gradient-text">Tools I reach for</h2>
            <p class="section-lede mb-4">
              A working stack rather than a buzzword list — every item here has
              shipped in a project or runs in my lab.
            </p>
            <NuxtLink to="/skills" class="btn btn-outline-light">
              <i class="fa-solid fa-layer-group me-2"></i>Full skills breakdown
            </NuxtLink>
          </div>

          <div class="col-lg-8">
            <div class="glass-card p-4">
              <div class="stack-group" v-for="group in techStack" :key="group.name">
                <h6 class="stack-group-title">{{ group.name }}</h6>
                <div class="d-flex flex-wrap gap-2">
                  <span v-for="item in group.items" :key="item.name" class="chip">
                    <i :class="item.icon"></i> {{ item.name }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ================= Projects ================= -->
    <section id="projects" class="section-shell" data-reveal>
      <div class="container">
        <div class="text-center mb-4">
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-diagram-project"></i> Featured Work
          </span>
          <h2 class="section-title gradient-text">Projects, not tutorials</h2>
          <p class="section-lede mx-auto">
            Real work from internships, CUHK Information Engineering coursework,
            and personal builds — each with tests and documentation.
          </p>
        </div>

        <div class="text-center mb-4">
          <button
            v-for="filter in projectFilters"
            :key="filter.value"
            :class="[
              'btn btn-sm me-2 mb-2 filter-btn',
              activeFilter === filter.value ? 'btn-primary' : 'btn-outline-light',
            ]"
            @click="activeFilter = filter.value"
          >
            <i :class="filter.icon" class="me-1"></i>{{ filter.label }}
          </button>
        </div>

        <div class="row g-4">
          <div
            v-for="project in filteredProjects"
            :key="project.title"
            class="col-lg-4 col-md-6"
          >
            <div class="glass-card project-card h-100">
              <div class="project-cover-wrap">
                <img
                  :src="project.image"
                  :alt="project.title"
                  class="project-cover"
                />
                <span class="project-category">{{ project.badge }}</span>
              </div>
              <div class="p-4 d-flex flex-column h-100">
                <h3 class="h6 fw-bold mb-2">{{ project.title }}</h3>
                <p class="text-muted-s small mb-3">{{ project.description }}</p>
                <ul class="project-points small mb-3">
                  <li v-for="highlight in project.highlights" :key="highlight">
                    {{ highlight }}
                  </li>
                </ul>
                <div class="d-flex flex-wrap gap-1 mb-3">
                  <span
                    v-for="tech in project.technologies"
                    :key="tech"
                    class="chip chip-mini"
                    >{{ tech }}</span
                  >
                </div>
                <div class="mt-auto d-flex justify-content-between align-items-center">
                  <small class="text-muted-s">
                    <span v-if="project.language">
                      <i class="fa-solid fa-code"></i> {{ project.language }}
                    </span>
                    <span v-if="project.stars" class="ms-2">
                      <i class="fa-solid fa-star"></i> {{ project.stars }}
                    </span>
                    <span v-if="project.updatedAt" class="ms-2">
                      <i class="fa-regular fa-clock"></i> {{ project.updatedAt }}
                    </span>
                  </small>
                  <a
                    v-if="project.link"
                    :href="project.link"
                    target="_blank"
                    rel="noopener"
                    class="btn btn-sm btn-outline-light"
                  >
                    <i class="fa-brands fa-github me-1"></i>Code
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ================= How I Work ================= -->
    <section class="section-shell" data-reveal>
      <div class="container">
        <div class="text-center mb-5">
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-route"></i> How I Work
          </span>
          <h2 class="section-title gradient-text">From requirement to release</h2>
        </div>

        <div class="row g-4">
          <div v-for="(step, index) in workflow" :key="step.title" class="col-md-6 col-xl-3">
            <div class="glass-card h-100 p-4 process-card">
              <div class="d-flex align-items-center justify-content-between mb-3">
                <span class="icon-badge subtle">
                  <i :class="step.icon"></i>
                </span>
                <span class="process-index">0{{ index + 1 }}</span>
              </div>
              <h3 class="h6 fw-bold mb-2">{{ step.title }}</h3>
              <p class="text-muted-s small mb-0">{{ step.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ================= Contact ================= -->
    <section id="contact" class="section-shell" data-reveal>
      <div class="container">
        <div class="text-center mb-5">
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-envelope"></i> Contact
          </span>
          <h2 class="section-title gradient-text">Let's build something</h2>
          <p class="section-lede mx-auto">
            Open to graduate roles in software engineering, cloud &amp; AI
            automation, and data.
          </p>
        </div>

        <div class="row g-4 justify-content-center">
          <div class="col-lg-5">
            <div class="row g-3">
              <div class="col-sm-6">
                <div class="glass-card p-4 h-100 contact-tile">
                  <i class="fa-solid fa-location-dot"></i>
                  <h6>Location</h6>
                  <p>Hong Kong</p>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="glass-card p-4 h-100 contact-tile">
                  <i class="fa-solid fa-envelope"></i>
                  <h6>Email</h6>
                  <p>
                    <a href="mailto:cccheilllun419@gmail.com"
                      >cccheilllun419@gmail.com</a
                    >
                  </p>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="glass-card p-4 h-100 contact-tile">
                  <i class="fa-solid fa-phone"></i>
                  <h6>Phone</h6>
                  <p>(+852) 6586 8120</p>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="glass-card p-4 h-100 contact-tile">
                  <i class="fa-solid fa-circle-check"></i>
                  <h6>Status</h6>
                  <p>Open to opportunities</p>
                </div>
              </div>
              <div class="col-12">
                <div class="glass-card p-4 d-flex gap-3 flex-wrap">
                  <a
                    href="https://github.com/ChanHei419"
                    target="_blank"
                    rel="noopener"
                    class="btn btn-outline-light"
                  >
                    <i class="fa-brands fa-github me-2"></i>GitHub
                  </a>
                  <a
                    href="https://www.linkedin.com/in/helon-chan/"
                    target="_blank"
                    rel="noopener"
                    class="btn btn-outline-light"
                  >
                    <i class="fa-brands fa-linkedin me-2"></i>LinkedIn
                  </a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-6">
            <div class="glass-card p-4 p-lg-5">
              <h3 class="h5 fw-bold mb-4">
                <i class="fa-solid fa-paper-plane me-2"></i>Send a message
              </h3>
              <form @submit.prevent="handleContactForm">
                <div class="row g-3">
                  <div class="col-md-6">
                    <input
                      v-model="contactForm.name"
                      type="text"
                      class="form-control"
                      placeholder="Your name"
                      required
                    />
                  </div>
                  <div class="col-md-6">
                    <input
                      v-model="contactForm.email"
                      type="email"
                      class="form-control"
                      placeholder="Your email"
                      required
                    />
                  </div>
                  <div class="col-12">
                    <input
                      v-model="contactForm.subject"
                      type="text"
                      class="form-control"
                      placeholder="Subject"
                      required
                    />
                  </div>
                  <div class="col-12">
                    <textarea
                      v-model="contactForm.message"
                      class="form-control"
                      rows="5"
                      placeholder="Your message"
                      required
                    ></textarea>
                  </div>
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-4" :disabled="isSubmitting">
                  <span v-if="!isSubmitting">
                    <i class="fa-solid fa-paper-plane me-2"></i>Compose email
                  </span>
                  <span v-else>
                    <span class="spinner-border spinner-border-sm me-2"></span>
                    Opening your mail app...
                  </span>
                </button>
                <p class="text-muted-s small text-center mt-3 mb-0">
                  This opens your mail client with the message pre-filled.
                </p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Toast -->
    <Transition name="toast">
      <div v-if="showToast" class="toast-notice">
        <i class="fa-solid fa-circle-check me-2"></i>{{ toastMessage }}
      </div>
    </Transition>
  </main>
</template>

<script setup>
import { computed, onMounted, ref } from "vue";

const { isDarkMode, toggleTheme } = useDarkMode();
useReveal();

const scrollToSection = (sectionId) => {
  if (import.meta.client) {
    document.getElementById(sectionId)?.scrollIntoView({ behavior: "smooth" });
  }
};

/* ---------------- Typing animation ---------------- */
const typedText = ref("");
const roleTexts = [
  "Software Engineer",
  "Cloud & AI Automation",
  "Data-Driven Builder",
  "Information Engineering @ CUHK",
];
let textIndex = 0;
let charIndex = 0;

const startTyping = () => {
  const type = () => {
    const current = roleTexts[textIndex];
    if (charIndex < current.length) {
      typedText.value += current.charAt(charIndex);
      charIndex++;
      setTimeout(type, 70);
    } else {
      setTimeout(erase, 2200);
    }
  };
  const erase = () => {
    if (typedText.value.length > 0) {
      typedText.value = typedText.value.slice(0, -1);
      setTimeout(erase, 32);
    } else {
      textIndex = (textIndex + 1) % roleTexts.length;
      charIndex = 0;
      setTimeout(type, 400);
    }
  };
  type();
};

/* ---------------- Content ---------------- */
const domains = [
  {
    title: "Software Engineering",
    icon: "fa-solid fa-code",
    description:
      "Full-stack web and mobile applications — typed APIs, clean data models, and interfaces that hold up in production.",
    tech: ["Nuxt 3 / Vue", "Laravel", "Kotlin", "Flask / FastAPI"],
  },
  {
    title: "Cloud & AI Automation",
    icon: "fa-solid fa-cloud",
    description:
      "Azure infrastructure as code, secretless CI/CD, enterprise workflow automation, and applied AI pipelines.",
    tech: ["Azure", "Terraform", "OIDC CI/CD", "ServiceNow"],
  },
  {
    title: "Data & Reporting",
    icon: "fa-solid fa-chart-column",
    description:
      "Schema design, SQL and MongoDB modelling, and Python automation that replaces manual spreadsheet work.",
    tech: ["SQL", "MongoDB", "Python", "Reporting"],
  },
  {
    title: "Security & Networks",
    icon: "fa-solid fa-shield-halved",
    description:
      "Linux tooling, network reconnaissance, intrusion detection, and applied cryptography fundamentals.",
    tech: ["Linux", "Nmap", "Suricata", "Cryptography"],
  },
];

const techStack = [
  {
    name: "Software Engineering",
    items: [
      { name: "Nuxt 3 / Vue", icon: "fa-brands fa-vuejs" },
      { name: "Python", icon: "fa-brands fa-python" },
      { name: "JavaScript", icon: "fa-brands fa-js" },
      { name: "Laravel / PHP", icon: "fa-brands fa-laravel" },
      { name: "Kotlin", icon: "fa-brands fa-android" },
      { name: "Git", icon: "fa-brands fa-git-alt" },
      { name: "Docker", icon: "fa-brands fa-docker" },
    ],
  },
  {
    name: "Cloud & AI",
    items: [
      { name: "Microsoft Azure", icon: "fa-brands fa-microsoft" },
      { name: "Terraform", icon: "fa-solid fa-cubes" },
      { name: "Azure DevOps", icon: "fa-solid fa-infinity" },
      { name: "ServiceNow", icon: "fa-solid fa-gears" },
      { name: "Power Automate", icon: "fa-solid fa-arrows-rotate" },
      { name: "PyTorch", icon: "fa-solid fa-brain" },
      { name: "Copilot Studio", icon: "fa-solid fa-robot" },
      { name: "Entra ID", icon: "fa-solid fa-fingerprint" },
    ],
  },
  {
    name: "Data",
    items: [
      { name: "SQL", icon: "fa-solid fa-database" },
      { name: "MongoDB", icon: "fa-solid fa-leaf" },
      { name: "REST APIs", icon: "fa-solid fa-plug" },
      { name: "Automation", icon: "fa-solid fa-chart-line" },
      { name: "DSA", icon: "fa-solid fa-sitemap" },
    ],
  },
  {
    name: "Security",
    items: [
      { name: "Linux", icon: "fa-brands fa-linux" },
      { name: "Nmap", icon: "fa-solid fa-network-wired" },
      { name: "Suricata", icon: "fa-solid fa-shield-halved" },
      { name: "Cryptography", icon: "fa-solid fa-lock" },
    ],
  },
];

const workflow = [
  {
    title: "Discover",
    icon: "fa-solid fa-magnifying-glass",
    description:
      "Clarify requirements, constraints, and success metrics before touching code — understanding first, keyboard second.",
  },
  {
    title: "Design",
    icon: "fa-solid fa-pen-ruler",
    description:
      "Sketch architecture, data models, and interfaces. Choose boring technology where it wins and justify the rest.",
  },
  {
    title: "Build & Test",
    icon: "fa-solid fa-hammer",
    description:
      "Ship incrementally with unit tests, readable code, and review-friendly commits. No untested moving parts.",
  },
  {
    title: "Automate & Observe",
    icon: "fa-solid fa-gauge-high",
    description:
      "CI/CD pipelines, metrics, and logs so quality is measurable after release — not just assumed.",
  },
];

/* ---------------- Project covers ---------------- */
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
      <path d="M0 380 L200 300 L400 360 L600 280 L800 340 L800 480 L0 480 Z" fill="rgba(0,0,0,0.18)"/>
      <text x="60" y="240" font-family="Segoe UI, Arial, sans-serif" font-size="58" font-weight="700" fill="#ffffff">${label}</text>
      <text x="62" y="295" font-family="Segoe UI, Arial, sans-serif" font-size="26" fill="rgba(255,255,255,0.85)">${sub}</text>
    </svg>`
  )}`;

/* ---------------- Projects ---------------- */
const projects = ref([
  {
    title: "AI Lyric Detection System",
    badge: "AI · Audio",
    category: "ai-cloud",
    description:
      "End-to-end pipeline that extracts lyrics from songs — vocal separation, speech recognition, and a REST API with a web interface.",
    highlights: [
      "3-stage pipeline: Demucs → Wav2Vec2 → text output",
      "Fine-tuning script + WER evaluation on real clips",
      "FastAPI with background jobs, progress, and Gradio UI",
    ],
    technologies: ["PyTorch", "Wav2Vec2", "Demucs", "FastAPI"],
    image: svgCover("AI Lyrics", "Demucs → Wav2Vec2 → Text", "#6d28d9", "#2563eb"),
    link: "https://github.com/ChanHei419/ai-lyric-detection",
  },
  {
    title: "Azure Terraform Lab",
    badge: "Cloud · IaC",
    category: "ai-cloud",
    description:
      "Modular Azure infrastructure as code with secretless OIDC CI/CD and least-privilege managed identities.",
    highlights: [
      "Reusable Terraform modules with validated inputs",
      "GitHub Actions → Azure via OIDC — no stored secrets",
      "Managed identity scoped to a single storage account",
    ],
    technologies: ["Terraform", "Azure", "GitHub Actions", "OIDC"],
    image: svgCover("Azure Lab", "Terraform · OIDC CI/CD", "#0369a1", "#22d3ee"),
    link: "https://github.com/ChanHei419/azure-terraform-lab",
  },
  {
    title: "ML Model Serving",
    badge: "MLOps",
    category: "ai-cloud",
    description:
      "Production-style serving pattern: a trained model artifact behind a tested FastAPI service with health probes and metrics.",
    highlights: [
      "Training script produces a versioned JSON model artifact",
      "Prometheus-format metrics with /health and /ready probes",
      "Docker image with non-root user and healthcheck",
    ],
    technologies: ["FastAPI", "Docker", "Prometheus", "Python"],
    image: svgCover("Model Serving", "FastAPI · Docker", "#0f766e", "#14b8a6"),
    link: "https://github.com/ChanHei419/model-serving-demo",
  },
  {
    title: "Campus Navigator",
    badge: "Android",
    category: "swe",
    description:
      "Android app with a local Dijkstra route planner over the campus walkway graph and a Retrofit backend contract.",
    highlights: [
      "Jetpack Compose UI with ViewModel + StateFlow",
      "Pure-Kotlin shortest path engine, unit tested",
      "Offline fallback keeps navigation working without a network",
    ],
    technologies: ["Kotlin", "Compose", "Retrofit", "Dijkstra"],
    image: svgCover("Campus Navigator", "Kotlin · Compose · Maps", "#0f766e", "#0ea5e9"),
    link: "https://github.com/ChanHei419/campus-navigator",
  },
  {
    title: "Student Management System",
    badge: "Full-Stack",
    category: "swe",
    description:
      "Laravel 12 MVC application for managing students, teachers, and country records with a clean Blade interface.",
    highlights: [
      "Full CRUD with server-side validation, search, and pagination",
      "Migrations, seeders, factories, and soft deletes",
      "Blade + Tailwind CSS 4 served through Vite",
    ],
    technologies: ["Laravel 12", "PHP 8.2", "MySQL", "Blade"],
    image: svgCover("Student Mgmt", "Laravel 12 · Blade · SQL", "#b91c1c", "#f97316"),
    link: "https://github.com/ChanHei419/studentManagement",
  },
  {
    title: "HeiChan CV Platform",
    badge: "Web",
    category: "swe",
    description:
      "This portfolio: a multi-page Nuxt 3 site with dark-first design, live GitHub stats, and interactive dashboards.",
    highlights: [
      "Nuxt 3 routing, layouts, composables, and auto-imports",
      "Live GitHub REST API stats with offline fallbacks",
      "Custom SCSS design system with scroll-reveal animations",
    ],
    technologies: ["Nuxt 3", "Vue 3", "Bootstrap", "SCSS"],
    image: svgCover("CV Platform", "Nuxt 3 · Vue 3", "#4338ca", "#7c3aed"),
    link: "https://github.com/ChanHei419/MyCV",
  },
  {
    title: "Data Automation Toolkit",
    badge: "Data",
    category: "data",
    description:
      "Dependency-free Python toolkit that cleans CSV data, loads SQLite, and generates CSV / HTML summary reports.",
    highlights: [
      "Normalises and de-duplicates messy CSV exports",
      "SQLite aggregation producing monthly summary reports",
      "7 unit tests and GitHub Actions CI",
    ],
    technologies: ["Python", "SQLite", "CLI", "unittest"],
    image: svgCover("Data Toolkit", "CSV → SQLite → Reports", "#7c2d12", "#f59e0b"),
    link: "https://github.com/ChanHei419/data-automation-toolkit",
  },
  {
    title: "DSA Practice",
    badge: "Fundamentals",
    category: "swe",
    description:
      "From-scratch data structures and algorithms with complexity notes and a full unit test suite.",
    highlights: [
      "Stacks, queues, linked lists, heaps, and union-find",
      "Sorting, binary search, BFS/DFS, Dijkstra, topological sort",
      "28 unit tests running in CI on Python 3.10 and 3.12",
    ],
    technologies: ["Python", "Algorithms", "Data Structures"],
    image: svgCover("DSA Practice", "28 tests · Big-O notes", "#4c1d95", "#8b5cf6"),
    link: "https://github.com/ChanHei419/dsa-practice",
  },
  {
    title: "Security Lab",
    badge: "Security",
    category: "security",
    description:
      "Nmap reconnaissance and Suricata IDS lab write-ups, plus a report generator that turns scan XML into Markdown.",
    highlights: [
      "Nmap XML → Markdown report tool (stdlib only)",
      "Suricata rule writing, alert triage, and tuning notes",
      "8 unit tests over the parser and renderer",
    ],
    technologies: ["Nmap", "Suricata", "Linux", "Python"],
    image: svgCover("Security Lab", "Nmap · Suricata · IDS", "#1f2937", "#475569"),
    link: "https://github.com/ChanHei419/security-lab",
  },
]);

const projectFilters = ref([
  { label: "All", value: "all", icon: "fa-solid fa-border-all" },
  { label: "AI & Cloud", value: "ai-cloud", icon: "fa-solid fa-cloud" },
  { label: "Full-Stack", value: "swe", icon: "fa-solid fa-code" },
  { label: "Data", value: "data", icon: "fa-solid fa-database" },
  { label: "Security", value: "security", icon: "fa-solid fa-shield-halved" },
]);
const activeFilter = ref("all");

const filteredProjects = computed(() => {
  if (activeFilter.value === "all") return projects.value;
  return projects.value.filter((project) => project.category === activeFilter.value);
});

/* ---------------- Live GitHub stats ---------------- */
const stats = ref({ repos: 11, projects: projects.value.length });

const fetchStats = async () => {
  try {
    const [userResponse, reposResponse] = await Promise.all([
      fetch("https://api.github.com/users/ChanHei419"),
      fetch("https://api.github.com/users/ChanHei419/repos?per_page=100"),
    ]);
    if (userResponse.ok) {
      const user = await userResponse.json();
      stats.value.repos = user.public_repos ?? stats.value.repos;
    }
    if (reposResponse.ok) {
      const repos = await reposResponse.json();
      repos.forEach((repo) => {
        const project = projects.value.find((item) => item.link === repo.html_url);
        if (project) {
          project.stars = repo.stargazers_count;
          project.language = repo.language;
          project.updatedAt = new Date(repo.pushed_at).toLocaleDateString("en-US", {
            month: "short",
            year: "numeric",
          });
        }
      });
    }
  } catch (error) {
    // Offline or rate limited — static values remain.
  }
};

/* ---------------- Contact ---------------- */
const EMAIL = "cccheilllun419@gmail.com";
const contactForm = ref({ name: "", email: "", subject: "", message: "" });
const isSubmitting = ref(false);
const showToast = ref(false);
const toastMessage = ref("");

const handleContactForm = () => {
  isSubmitting.value = true;
  if (import.meta.client) {
    const subject = encodeURIComponent(contactForm.value.subject);
    const body = encodeURIComponent(
      `${contactForm.value.message}\n\n— ${contactForm.value.name} (${contactForm.value.email})`
    );
    window.location.href = `mailto:${EMAIL}?subject=${subject}&body=${body}`;
  }
  setTimeout(() => {
    isSubmitting.value = false;
    contactForm.value = { name: "", email: "", subject: "", message: "" };
    toastMessage.value = "Mail app opened with your message";
    showToast.value = true;
    setTimeout(() => {
      showToast.value = false;
    }, 3000);
  }, 800);
};

onMounted(() => {
  startTyping();
  fetchStats();
});
</script>

<style lang="scss" scoped>
.text-muted-s {
  color: var(--text-muted);
}

/* ---------- Hero ---------- */
.hero {
  padding-top: 4rem;
}

.hero-title {
  font-size: clamp(2.2rem, 5vw, 3.4rem);
  font-weight: 800;
  letter-spacing: -0.02em;
  line-height: 1.15;
  min-height: 4.4rem;
}

.typing-cursor {
  color: var(--accent-cyan);
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

.hero-lede {
  color: var(--text-muted);
  font-size: 1.05rem;
  max-width: 620px;
  margin-top: 1rem;
}

/* ---------- Avatar ---------- */
.avatar-stage {
  position: relative;
  display: inline-block;
  padding: 30px;
}

.avatar-ring {
  position: absolute;
  inset: 10px;
  border-radius: 50%;
  background: conic-gradient(from 0deg, #8b5cf6, #3b82f6, #22d3ee, #8b5cf6);
  filter: blur(30px);
  opacity: 0.55;
  animation: ring-spin 12s linear infinite;
}

@keyframes ring-spin {
  to {
    transform: rotate(360deg);
  }
}

.avatar-image {
  position: relative;
  width: min(280px, 70vw);
  border-radius: 50%;
  border: 3px solid rgba(255, 255, 255, 0.16);
  box-shadow: 0 24px 60px rgba(2, 6, 23, 0.6);
  animation: float-soft 6s ease-in-out infinite;
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

.tech-orbit {
  position: absolute;
  width: 46px;
  height: 46px;
  border-radius: 14px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 1.15rem;
  color: #ffffff;
  background: rgba(15, 22, 44, 0.85);
  border: 1px solid var(--border-soft);
  backdrop-filter: blur(10px);
  box-shadow: 0 12px 28px rgba(2, 6, 23, 0.5);
  animation: float-soft 5s ease-in-out infinite;
}

.orbit-1 {
  top: 4%;
  left: 6%;
  animation-delay: -1s;
}

.orbit-2 {
  top: 0%;
  right: 14%;
  animation-delay: -2.4s;
}

.orbit-3 {
  top: 42%;
  left: -4%;
  animation-delay: -0.6s;
}

.orbit-4 {
  top: 40%;
  right: -6%;
  animation-delay: -3.2s;
}

.orbit-5 {
  bottom: 4%;
  left: 12%;
  animation-delay: -1.8s;
}

.orbit-6 {
  bottom: 0%;
  right: 16%;
  animation-delay: -4s;
}

/* ---------- Tech stack ---------- */
.stack-group + .stack-group {
  margin-top: 1.25rem;
}

.stack-group-title {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.72rem;
  font-weight: 700;
  color: var(--accent-cyan);
  margin-bottom: 0.6rem;
}

.chip-mini {
  font-size: 0.72rem;
  padding: 0.22rem 0.6rem;
}

/* ---------- Projects ---------- */
.filter-btn {
  border-radius: 999px;
  font-size: 0.82rem;
}

.project-card {
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.project-cover-wrap {
  position: relative;
}

.project-cover {
  width: 100%;
  height: 190px;
  object-fit: cover;
  display: block;
}

.project-category {
  position: absolute;
  top: 12px;
  left: 12px;
  padding: 0.28rem 0.7rem;
  border-radius: 999px;
  font-size: 0.72rem;
  font-weight: 600;
  color: #ffffff;
  background: rgba(2, 6, 23, 0.62);
  border: 1px solid rgba(255, 255, 255, 0.18);
  backdrop-filter: blur(8px);
}

.project-points {
  list-style: none;
  padding: 0;
  margin: 0;
  color: var(--text-muted);
}

.project-points li {
  position: relative;
  padding-left: 1.1rem;
  margin-bottom: 0.35rem;
}

.project-points li::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0.45rem;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--gradient-main);
}

/* ---------- Process ---------- */
.process-card {
  position: relative;
}

.process-index {
  font-family: "JetBrains Mono", monospace;
  font-size: 1.4rem;
  font-weight: 600;
  color: rgba(148, 163, 184, 0.35);
}

/* ---------- Contact ---------- */
.contact-tile i {
  font-size: 1.2rem;
  color: var(--accent-cyan);
  margin-bottom: 0.6rem;
  display: inline-block;
}

.contact-tile h6 {
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 0.72rem;
  color: var(--text-muted);
  margin-bottom: 0.35rem;
}

.contact-tile p {
  margin-bottom: 0;
  font-weight: 600;
  font-size: 0.92rem;
  word-break: break-word;
}

.contact-tile a {
  color: var(--text-primary);
  text-decoration: none;
}

.contact-tile a:hover {
  color: var(--accent-cyan);
}

/* ---------- Form ---------- */
.form-control {
  background: rgba(2, 6, 23, 0.4);
  border: 1px solid var(--border-soft);
  color: var(--text-primary);
  border-radius: 12px;
  padding: 0.7rem 1rem;
}

.form-control:focus {
  background: rgba(2, 6, 23, 0.55);
  border-color: var(--accent-violet);
  color: var(--text-primary);
  box-shadow: 0 0 0 0.2rem rgba(139, 92, 246, 0.2);
}

.form-control::placeholder {
  color: rgba(148, 163, 184, 0.7);
}

html[data-theme="light"] .form-control {
  background: rgba(255, 255, 255, 0.85);
}

/* ---------- Toast ---------- */
.toast-notice {
  position: fixed;
  top: 92px;
  right: 20px;
  z-index: 1060;
  padding: 0.85rem 1.2rem;
  border-radius: 12px;
  background: linear-gradient(120deg, #059669, #10b981);
  color: #ffffff;
  font-weight: 600;
  box-shadow: 0 16px 36px rgba(2, 6, 23, 0.5);
}

.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateX(60px);
}

/* ---------- Theme toggle ---------- */
.theme-toggle {
  position: fixed;
  right: 22px;
  bottom: 24px;
  width: 46px;
  height: 46px;
  border-radius: 14px;
  border: 1px solid var(--border-soft);
  background: var(--surface-strong);
  color: var(--text-primary);
  backdrop-filter: blur(12px);
  z-index: 1040;
  transition: transform 0.2s ease, border-color 0.2s ease;
}

.theme-toggle:hover {
  transform: translateY(-3px);
  border-color: var(--border-bright);
}

@media (max-width: 991px) {
  .hero {
    padding-top: 2.5rem;
  }

  .avatar-stage {
    margin-top: 1rem;
  }

  .orbit-3,
  .orbit-4 {
    display: none;
  }
}
</style>
