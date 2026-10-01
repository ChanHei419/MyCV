<template>
  <main class="page">
    <button class="theme-toggle" @click="toggleTheme" aria-label="Toggle theme">
      <i :class="isDarkMode ? 'fa-solid fa-sun' : 'fa-solid fa-moon'"></i>
    </button>

    <!-- Hero -->
    <section class="section-shell">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-9 text-center" data-reveal>
            <span class="section-kicker justify-content-center d-inline-flex">
              <i class="fa-solid fa-user"></i> About Me
            </span>
            <h1 class="page-title gradient-text">
              <span>{{ typedText }}</span><span class="typing-cursor">|</span>
            </h1>
            <p class="section-lede mx-auto">
              I build across three domains: software engineering, cloud &amp;
              AI automation, and data. This site is my engineering notebook
              made public — it runs on Nuxt 3, pulls live stats from the GitHub
              API, and doubles as an interactive résumé.
            </p>
          </div>
        </div>

        <!-- Quick facts -->
        <div class="row g-4 mt-2 justify-content-center">
          <div v-for="fact in quickFacts" :key="fact.label" class="col-sm-6 col-lg-3" data-reveal>
            <div class="glass-card h-100 p-4 text-center">
              <span class="icon-badge subtle mb-3">
                <i :class="fact.icon"></i>
              </span>
              <h6 class="fact-label">{{ fact.label }}</h6>
              <p class="fact-value mb-0">{{ fact.value }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Mission + principles -->
    <section class="section-shell">
      <div class="container">
        <div class="row g-4">
          <div class="col-lg-5" data-reveal>
            <div class="glass-card h-100 p-4 p-lg-5">
              <span class="section-kicker">
                <i class="fa-solid fa-rocket"></i> Mission
              </span>
              <h2 class="h3 fw-bold mb-3">Why I build</h2>
              <p class="text-muted-s mb-4">
                I like owning problems end-to-end: understanding the
                requirement, designing the data model, shipping the API and UI,
                then automating the deployment and measuring the result. The
                best compliment my work can get is that it quietly keeps
                running.
              </p>
              <p class="text-muted-s mb-0">
                Right now I'm focused on graduate roles where I can ship real
                systems across software, cloud, and data — and keep learning
                fast.
              </p>
            </div>
          </div>

          <div class="col-lg-7" data-reveal>
            <div class="row g-4">
              <div
                v-for="principle in principles"
                :key="principle.title"
                class="col-sm-6"
              >
                <div class="glass-card h-100 p-4">
                  <span class="icon-badge mb-3">
                    <i :class="principle.icon"></i>
                  </span>
                  <h3 class="h6 fw-bold mb-2">{{ principle.title }}</h3>
                  <p class="text-muted-s small mb-0">{{ principle.description }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Journey -->
    <section class="section-shell">
      <div class="container">
        <div class="text-center mb-5" data-reveal>
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-route"></i> Journey
          </span>
          <h2 class="section-title gradient-text">How I got here</h2>
        </div>

        <div class="row justify-content-center">
          <div class="col-lg-8">
            <div
              v-for="(milestone, index) in milestones"
              :key="milestone.title"
              class="journey-item glass-card p-4 mb-4"
              data-reveal
            >
              <div class="d-flex align-items-start gap-3">
                <span class="journey-icon">
                  <i :class="milestone.icon"></i>
                </span>
                <div>
                  <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                    <h3 class="h6 fw-bold mb-0">{{ milestone.title }}</h3>
                    <span class="chip chip-mini">{{ milestone.stage }}</span>
                  </div>
                  <p class="text-muted-s small mb-0">{{ milestone.description }}</p>
                </div>
                <span class="journey-index ms-auto">0{{ index + 1 }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="text-center mt-4" data-reveal>
          <NuxtLink to="/experience" class="btn btn-primary btn-lg">
            <i class="fa-solid fa-briefcase me-2"></i>See what I did in industry
          </NuxtLink>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup>
import { onMounted, ref } from "vue";

const { isDarkMode, toggleTheme } = useDarkMode();
useReveal();

/* Typing */
const fullText = "Building across Software, Cloud & AI, and Data.";
const typedText = ref("");
let index = 0;

const type = () => {
  if (index < fullText.length) {
    typedText.value += fullText.charAt(index);
    index++;
    setTimeout(type, 55);
  }
};

onMounted(type);

const quickFacts = [
  {
    label: "Degree",
    value: "BEng Information Engineering, CUHK",
    icon: "fa-solid fa-graduation-cap",
  },
  {
    label: "Based in",
    value: "Hong Kong",
    icon: "fa-solid fa-location-dot",
  },
  {
    label: "Languages",
    value: "Cantonese · Mandarin · English",
    icon: "fa-solid fa-language",
  },
  {
    label: "Looking for",
    value: "Graduate roles in SWE, Cloud & AI, Data",
    icon: "fa-solid fa-bullseye",
  },
];

const principles = [
  {
    title: "Automate the repeatable",
    icon: "fa-solid fa-arrows-rotate",
    description:
      "If a task happens twice, it gets a script the third time. Manual spreadsheet work is a bug, not a process.",
  },
  {
    title: "Measure, don't guess",
    icon: "fa-solid fa-chart-line",
    description:
      "Tests, WER, latency, and coverage over intuition. If quality matters, it gets a number.",
  },
  {
    title: "Security by default",
    icon: "fa-solid fa-shield-halved",
    description:
      "Secretless authentication, least-privilege identities, and secure defaults from the first commit.",
  },
  {
    title: "Ship, then refine",
    icon: "fa-solid fa-rocket",
    description:
      "Working software early. Polish is an iteration, not a phase — feedback beats speculation.",
  },
];

const milestones = [
  {
    title: "Engineering Foundations",
    stage: "CUHK",
    icon: "fa-solid fa-book-open",
    description:
      "Started my BEng in Information Engineering — data structures and algorithms, systems programming in C, computer networks, and cryptography.",
  },
  {
    title: "First Industry Experience",
    stage: "FinTech",
    icon: "fa-solid fa-briefcase",
    description:
      "Shipped a Nuxt.js corporate website, automated database-driven Python reporting, and cut a legacy C#/SQL system's runtime from 2m 30s to 1m 20s.",
  },
  {
    title: "Applied AI Pipeline",
    stage: "Audio ML",
    icon: "fa-solid fa-brain",
    description:
      "Designed a 3-stage lyric transcription system — Demucs vocal separation, a Wav2Vec2 model, and a Flask API with a Gradio interface.",
  },
  {
    title: "Cloud & AI Automation",
    stage: "Azure · ServiceNow",
    icon: "fa-solid fa-cloud",
    description:
      "Automated ServiceNow workflows, provisioned Azure with Terraform and OIDC-based CI/CD, and completed a network intrusion detection lab.",
  },
];
</script>

<style lang="scss" scoped>
.text-muted-s {
  color: var(--text-muted);
}

.page {
  position: relative;
  z-index: 1;
}

.page-title {
  font-size: clamp(1.9rem, 4vw, 2.8rem);
  font-weight: 800;
  letter-spacing: -0.02em;
  min-height: 3.4rem;
  margin-bottom: 1rem;
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

.fact-label {
  text-transform: uppercase;
  letter-spacing: 0.14em;
  font-size: 0.72rem;
  color: var(--text-muted);
  margin-bottom: 0.4rem;
}

.fact-value {
  font-weight: 600;
  font-size: 0.95rem;
}

/* Journey */
.journey-item {
  position: relative;
}

.journey-icon {
  width: 46px;
  height: 46px;
  flex-shrink: 0;
  border-radius: 13px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  background: var(--gradient-main);
  box-shadow: 0 10px 22px rgba(59, 130, 246, 0.3);
}

.journey-index {
  font-family: "JetBrains Mono", monospace;
  font-size: 1.2rem;
  color: rgba(148, 163, 184, 0.35);
}

/* Theme toggle */
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
</style>
