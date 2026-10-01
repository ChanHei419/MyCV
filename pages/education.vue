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
              <i class="fa-solid fa-graduation-cap"></i> Education
            </span>
            <h1 class="page-title gradient-text">Academic foundation</h1>
            <p class="section-lede mx-auto">
              A degree in Information Engineering gave me the fundamentals —
              algorithms, systems, networks, and security. Everything else I
              built on top of that foundation, one project at a time.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Degree -->
    <section class="section-shell pt-0">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-9" data-reveal>
            <div class="glass-card p-4 p-lg-5">
              <div class="d-flex flex-wrap align-items-start gap-4">
                <span class="icon-badge degree-badge">
                  <i class="fa-solid fa-university"></i>
                </span>
                <div class="flex-grow-1">
                  <h2 class="h4 fw-bold mb-1">
                    Bachelor of Engineering in Information Engineering
                  </h2>
                  <p class="text-muted-s mb-4">
                    The Chinese University of Hong Kong
                  </p>

                  <h3 class="h6 fw-bold mb-2">Core Focus</h3>
                  <div class="d-flex flex-wrap gap-1 mb-4">
                    <span class="chip">
                      <i class="fa-solid fa-sitemap"></i> Software Systems
                    </span>
                    <span class="chip">
                      <i class="fa-solid fa-network-wired"></i> Networking
                    </span>
                    <span class="chip">
                      <i class="fa-solid fa-shield-halved"></i> Security
                    </span>
                  </div>

                  <h3 class="h6 fw-bold mb-2">Relevant Coursework</h3>
                  <div class="row g-3 mb-4">
                    <div
                      v-for="course in coursework"
                      :key="course.name"
                      class="col-sm-6"
                    >
                      <div class="course-row">
                        <i :class="course.icon"></i>
                        <div>
                          <div class="course-name">{{ course.name }}</div>
                          <div class="text-muted-s small">{{ course.detail }}</div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <h3 class="h6 fw-bold mb-2">What It Gave Me</h3>
                  <ul class="project-points small mb-0">
                    <li
                      v-for="highlight in degreeHighlights"
                      :key="highlight"
                    >
                      {{ highlight }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Beyond the classroom -->
    <section class="section-shell">
      <div class="container">
        <div class="text-center mb-5" data-reveal>
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-lightbulb"></i> Beyond the Classroom
          </span>
          <h2 class="section-title gradient-text">Self-directed learning</h2>
          <p class="section-lede mx-auto">
            The courses taught fundamentals; industry and personal projects
            taught the modern stack.
          </p>
        </div>

        <div class="row g-4">
          <div
            v-for="track in learningTracks"
            :key="track.title"
            class="col-md-6 col-xl-3"
            data-reveal
          >
            <div class="glass-card h-100 p-4">
              <span class="icon-badge subtle mb-3">
                <i :class="track.icon"></i>
              </span>
              <h3 class="h6 fw-bold mb-2">{{ track.title }}</h3>
              <p class="text-muted-s small mb-3">{{ track.description }}</p>
              <div class="d-flex flex-wrap gap-1">
                <span v-for="item in track.items" :key="item" class="chip chip-mini">
                  {{ item }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Coursework projects -->
    <section class="section-shell">
      <div class="container">
        <div class="text-center mb-5" data-reveal>
          <span class="section-kicker justify-content-center d-inline-flex">
            <i class="fa-solid fa-flask"></i> Applied Work
          </span>
          <h2 class="section-title gradient-text">
            Coursework that became projects
          </h2>
        </div>

        <div class="row g-4 justify-content-center">
          <div
            v-for="project in courseworkProjects"
            :key="project.title"
            class="col-md-6 col-lg-4"
            data-reveal
          >
            <a
              :href="project.link"
              target="_blank"
              rel="noopener"
              class="glass-card h-100 p-4 d-block text-decoration-none project-link"
            >
              <span class="icon-badge mb-3">
                <i :class="project.icon"></i>
              </span>
              <h3 class="h6 fw-bold mb-2">{{ project.title }}</h3>
              <p class="text-muted-s small mb-3">{{ project.description }}</p>
              <span class="project-link-cta">
                View repository <i class="fa-solid fa-arrow-right ms-1"></i>
              </span>
            </a>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup>
const { isDarkMode, toggleTheme } = useDarkMode();
useReveal();

const coursework = [
  {
    name: "Data Structures",
    detail: "Complexity analysis, trees, graphs, and algorithm design in C",
    icon: "fa-solid fa-sitemap",
  },
  {
    name: "Systems Programming",
    detail: "Memory management, pointers, and low-level systems work in C",
    icon: "fa-solid fa-microchip",
  },
  {
    name: "Computer Networks",
    detail: "Protocol stacks, routing, and network programming",
    icon: "fa-solid fa-network-wired",
  },
  {
    name: "Cryptography",
    detail: "Encryption, hashing, and secure protocol fundamentals",
    icon: "fa-solid fa-lock",
  },
];

const degreeHighlights = [
  "Merged theory with practice: every course concept ended up in a shipped project, from Dijkstra in the campus navigator to CTC models in the lyric pipeline",
  "Built and documented applied AI, Android, and security projects alongside coursework",
  "Practised version control, code review, and testing across C, C#, Kotlin, and Python codebases",
];

const learningTracks = [
  {
    title: "Cloud & Infrastructure",
    icon: "fa-solid fa-cloud",
    description:
      "Learned infrastructure as code on the job — now I provision Azure resources with Terraform instead of clicking portals.",
    items: ["Azure", "Terraform", "OIDC CI/CD"],
  },
  {
    title: "Applied AI",
    icon: "fa-solid fa-brain",
    description:
      "Moved from course theory to training and evaluating models on real audio datasets with PyTorch.",
    items: ["PyTorch", "Wav2Vec2", "Demucs"],
  },
  {
    title: "Enterprise Automation",
    icon: "fa-solid fa-gears",
    description:
      "Automated workflows that previously consumed hours of manual effort, end to end.",
    items: ["ServiceNow", "Power Automate", "Copilot Studio"],
  },
  {
    title: "Mobile Development",
    icon: "fa-brands fa-android",
    description:
      "Built an Android app with Compose, state management, and a REST backend contract.",
    items: ["Kotlin", "Compose", "Retrofit"],
  },
];

const courseworkProjects = [
  {
    title: "AI Lyric Detection System",
    description:
      "Vocal separation with Demucs and speech recognition with a fine-tuned Wav2Vec2, served through an API.",
    icon: "fa-solid fa-music",
    link: "https://github.com/ChanHei419/ai-lyric-detection",
  },
  {
    title: "Campus Navigator",
    description:
      "Android app with a local Dijkstra route planner over the campus walkway graph.",
    icon: "fa-solid fa-map-location-dot",
    link: "https://github.com/ChanHei419/campus-navigator",
  },
  {
    title: "Network Intrusion Detection Lab",
    description:
      "Nmap reconnaissance and Suricata IDS rules with a scan-report generator.",
    icon: "fa-solid fa-shield-halved",
    link: "https://github.com/ChanHei419/security-lab",
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
  margin-bottom: 1rem;
}

.degree-badge {
  width: 64px;
  height: 64px;
  font-size: 1.6rem;
}

.course-row {
  display: flex;
  gap: 0.75rem;
  align-items: flex-start;
  padding: 0.85rem 1rem;
  border-radius: 14px;
  background: rgba(139, 92, 246, 0.08);
  border: 1px solid var(--border-soft);
}

.course-row i {
  color: var(--accent-cyan);
  font-size: 1.05rem;
  margin-top: 0.15rem;
}

.course-name {
  font-weight: 600;
  font-size: 0.92rem;
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
  margin-bottom: 0.45rem;
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

.project-link {
  transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
}

.project-link-cta {
  color: var(--accent-cyan);
  font-size: 0.85rem;
  font-weight: 600;
}

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
