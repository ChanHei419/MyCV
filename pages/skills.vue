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
              <i class="fa-solid fa-layer-group"></i> Skills
            </span>
            <h1 class="page-title gradient-text">Tools I've actually shipped with</h1>
            <p class="section-lede mx-auto">
              A working stack, not a buzzword list. Every skill below was used
              in a project, an internship, or a graded course — with an honest
              proficiency estimate.
            </p>
            <button class="btn btn-outline-light mt-3" @click="exportSkills">
              <i class="fa-solid fa-download me-2"></i>Export as JSON
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Dashboard -->
    <section class="section-shell pt-0">
      <div class="container">
        <div class="row g-3 justify-content-center">
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ stats.totalSkills }}</div>
              <div class="stat-label">Skills</div>
            </div>
          </div>
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ stats.avgProficiency }}%</div>
              <div class="stat-label">Avg Proficiency</div>
            </div>
          </div>
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value stat-value-text">{{ stats.topSkill.name }}</div>
              <div class="stat-label">Top Skill</div>
            </div>
          </div>
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ stats.categories }}</div>
              <div class="stat-label">Categories</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Filter + grid -->
    <section class="section-shell pt-0">
      <div class="container">
        <div class="d-flex flex-wrap gap-2 justify-content-center mb-5" data-reveal>
          <button
            v-for="category in categoryFilters"
            :key="category.value"
            :class="[
              'btn btn-sm filter-btn',
              selectedCategory === category.value ? 'btn-primary' : 'btn-outline-light',
            ]"
            @click="selectedCategory = category.value"
          >
            <i :class="category.icon" class="me-1"></i>{{ category.label }}
            <span class="filter-count">{{ category.count }}</span>
          </button>
        </div>

        <div class="row g-4">
          <div
            v-for="skill in filteredSkills"
            :key="skill.name"
            class="col-md-6 col-lg-4"
            data-reveal
          >
            <div class="glass-card h-100 p-4 skill-card">
              <div class="d-flex align-items-center gap-3 mb-3">
                <span class="skill-icon">
                  <i :class="skill.icon"></i>
                </span>
                <div>
                  <h2 class="h6 fw-bold mb-0">{{ skill.name }}</h2>
                  <span class="skill-category">{{ skill.category }}</span>
                </div>
              </div>

              <p class="text-muted-s small mb-3">{{ skill.description }}</p>

              <div class="d-flex justify-content-between align-items-center mb-1">
                <span class="skill-level">{{ levelFor(skill.proficiency) }}</span>
                <span class="skill-percent">{{ skill.proficiency }}%</span>
              </div>
              <div class="skill-bar">
                <div
                  class="skill-bar-fill"
                  :style="{ width: skill.proficiency + '%' }"
                ></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Legend -->
    <section class="section-shell pt-0">
      <div class="container">
        <div class="row justify-content-center" data-reveal>
          <div class="col-lg-8">
            <div class="glass-card p-4">
              <h2 class="h6 fw-bold mb-3">
                <i class="fa-solid fa-circle-info me-2"></i>How to read the levels
              </h2>
              <div class="row g-3">
                <div class="col-sm-6 col-lg-3">
                  <div class="level-row">
                    <span class="level-dot level-advanced"></span>
                    <div>
                      <div class="level-name">Advanced · 85%+</div>
                      <div class="level-desc">Shipped multiple projects</div>
                    </div>
                  </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                  <div class="level-row">
                    <span class="level-dot level-proficient"></span>
                    <div>
                      <div class="level-name">Proficient · 75%+</div>
                      <div class="level-desc">Used in production or graded work</div>
                    </div>
                  </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                  <div class="level-row">
                    <span class="level-dot level-working"></span>
                    <div>
                      <div class="level-name">Working · 65%+</div>
                      <div class="level-desc">Comfortable with documentation</div>
                    </div>
                  </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                  <div class="level-row">
                    <span class="level-dot level-learning"></span>
                    <div>
                      <div class="level-name">Learning · below 65%</div>
                      <div class="level-desc">Actively improving</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup>
import { computed, ref } from "vue";

const { isDarkMode, toggleTheme } = useDarkMode();
useReveal();

const skills = ref([
  // Software Engineering
  {
    name: "Nuxt.js / Vue 3",
    category: "Software Engineering",
    icon: "fa-brands fa-vuejs",
    proficiency: 85,
    description:
      "Built and deployed a production corporate website, and engineered this multi-page portfolio with Nuxt 3, Vue 3, and SCSS.",
  },
  {
    name: "Python",
    category: "Software Engineering",
    icon: "fa-brands fa-python",
    proficiency: 85,
    description:
      "Automation, Flask / FastAPI REST APIs, and data tooling used across AI and reporting projects.",
  },
  {
    name: "JavaScript",
    category: "Software Engineering",
    icon: "fa-brands fa-js",
    proficiency: 82,
    description:
      "Modern ES6+, async patterns, and browser APIs powering interactive user interfaces.",
  },
  {
    name: "C#",
    category: "Software Engineering",
    icon: "fa-solid fa-hashtag",
    proficiency: 70,
    description:
      "Optimized a legacy .NET / SQL messaging service, cutting runtime by 45%.",
  },
  {
    name: "Kotlin",
    category: "Software Engineering",
    icon: "fa-brands fa-android",
    proficiency: 72,
    description:
      "Android development with Jetpack Compose, ViewModel state, and Retrofit networking.",
  },
  {
    name: "PHP / Laravel",
    category: "Software Engineering",
    icon: "fa-brands fa-laravel",
    proficiency: 75,
    description:
      "MVC architecture, Eloquent ORM, migrations, validation, and Blade views in a full CRUD system.",
  },
  {
    name: "Git & GitHub",
    category: "Software Engineering",
    icon: "fa-brands fa-git-alt",
    proficiency: 85,
    description:
      "Version control, branching strategies, pull requests, and CI workflows across every project.",
  },

  // Cloud & AI
  {
    name: "Microsoft Azure",
    category: "Cloud & AI",
    icon: "fa-brands fa-microsoft",
    proficiency: 80,
    description:
      "Provisioned resources as code and automated deployments through Azure DevOps pipelines.",
  },
  {
    name: "Terraform",
    category: "Cloud & AI",
    icon: "fa-solid fa-cubes",
    proficiency: 78,
    description:
      "Declarative infrastructure with secure OIDC authentication and least-privilege access.",
  },
  {
    name: "ServiceNow",
    category: "Cloud & AI",
    icon: "fa-solid fa-gears",
    proficiency: 80,
    description:
      "Custom tables, Business Rules, Script Includes, Virtual Agent, and Now Assist Skill Kits.",
  },
  {
    name: "Power Automate & Copilot Studio",
    category: "Cloud & AI",
    icon: "fa-solid fa-arrows-rotate",
    proficiency: 80,
    description:
      "Cross-platform automation across SharePoint, Entra ID, and Teams.",
  },
  {
    name: "Identity & Access",
    category: "Cloud & AI",
    icon: "fa-solid fa-fingerprint",
    proficiency: 75,
    description:
      "OIDC federated credentials, certificate authentication, and Managed Identities for secretless flows.",
  },
  {
    name: "PyTorch & Wav2Vec2",
    category: "Cloud & AI",
    icon: "fa-solid fa-brain",
    proficiency: 72,
    description:
      "Fine-tuned speech recognition models; designed multi-stage AI pipelines with WER evaluation.",
  },
  {
    name: "Docker",
    category: "Cloud & AI",
    icon: "fa-brands fa-docker",
    proficiency: 65,
    description:
      "Containerized services with multi-stage builds and non-root runtime users.",
  },

  // Data
  {
    name: "SQL",
    category: "Data",
    icon: "fa-solid fa-database",
    proficiency: 82,
    description:
      "Schema design, complex queries, aggregation, and performance tuning for production systems.",
  },
  {
    name: "MongoDB",
    category: "Data",
    icon: "fa-solid fa-leaf",
    proficiency: 75,
    description:
      "Document modelling for authentication, profiles, and chat history in an app backend.",
  },
  {
    name: "REST API Design",
    category: "Data",
    icon: "fa-solid fa-plug",
    proficiency: 82,
    description:
      "Designed Flask / FastAPI endpoints with asynchronous processing and progress reporting.",
  },
  {
    name: "Data Structures & Algorithms",
    category: "Data",
    icon: "fa-solid fa-sitemap",
    proficiency: 85,
    description:
      "Complexity analysis, graphs, trees, and algorithm design, practised with a 28-test library.",
  },
  {
    name: "Data Automation",
    category: "Data",
    icon: "fa-solid fa-chart-line",
    proficiency: 80,
    description:
      "Python pipelines that clean datasets and generate database-driven reports, replacing manual work.",
  },

  // Security & Tools
  {
    name: "Linux",
    category: "Security & Tools",
    icon: "fa-brands fa-linux",
    proficiency: 78,
    description:
      "Daily command-line workflows, shell scripting, and lab environments.",
  },
  {
    name: "Nmap & Suricata",
    category: "Security & Tools",
    icon: "fa-solid fa-shield-halved",
    proficiency: 70,
    description:
      "Network reconnaissance, signature-based intrusion detection, and alert triage.",
  },
  {
    name: "Cryptography",
    category: "Security & Tools",
    icon: "fa-solid fa-lock",
    proficiency: 72,
    description:
      "Encryption, hashing, and secure protocol fundamentals from graded coursework.",
  },
]);

const categoryIcons = {
  "Software Engineering": "fa-solid fa-code",
  "Cloud & AI": "fa-solid fa-cloud",
  Data: "fa-solid fa-database",
  "Security & Tools": "fa-solid fa-shield-halved",
};

const selectedCategory = ref("All");

const categoryFilters = computed(() => {
  const counts = skills.value.reduce((acc, skill) => {
    acc[skill.category] = (acc[skill.category] || 0) + 1;
    return acc;
  }, {});

  const filters = [
    {
      value: "All",
      label: "All",
      icon: "fa-solid fa-border-all",
      count: skills.value.length,
    },
  ];

  Object.entries(counts).forEach(([category, count]) => {
    filters.push({
      value: category,
      label: category,
      icon: categoryIcons[category] || "fa-solid fa-circle",
      count,
    });
  });

  return filters;
});

const filteredSkills = computed(() => {
  if (selectedCategory.value === "All") return skills.value;
  return skills.value.filter((skill) => skill.category === selectedCategory.value);
});

const stats = computed(() => ({
  totalSkills: skills.value.length,
  avgProficiency: Math.round(
    skills.value.reduce((sum, skill) => sum + skill.proficiency, 0) /
      skills.value.length
  ),
  topSkill: skills.value.reduce((top, skill) =>
    skill.proficiency > top.proficiency ? skill : top
  ),
  categories: new Set(skills.value.map((skill) => skill.category)).size,
}));

const levelFor = (proficiency) => {
  if (proficiency >= 85) return "Advanced";
  if (proficiency >= 75) return "Proficient";
  if (proficiency >= 65) return "Working";
  return "Learning";
};

const exportSkills = () => {
  if (!import.meta.client) return;
  const payload = JSON.stringify(skills.value, null, 2);
  const blob = new Blob([payload], { type: "application/json" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.download = "heichan-skills.json";
  link.click();
  URL.revokeObjectURL(url);
};
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

.stat-value-text {
  font-size: 1.15rem !important;
  padding-top: 0.6rem;
}

.filter-btn {
  border-radius: 999px;
  font-size: 0.82rem;
}

.filter-count {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
  height: 20px;
  padding: 0 0.35rem;
  margin-left: 0.4rem;
  border-radius: 999px;
  font-size: 0.7rem;
  background: rgba(255, 255, 255, 0.16);
}

/* Skill cards */
.skill-card {
  position: relative;
}

.skill-icon {
  width: 48px;
  height: 48px;
  flex-shrink: 0;
  border-radius: 13px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 1.3rem;
  color: #ffffff;
  background: var(--gradient-main);
  box-shadow: 0 10px 22px rgba(59, 130, 246, 0.3);
}

.skill-category {
  font-size: 0.74rem;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  color: var(--text-muted);
}

.skill-level {
  font-size: 0.78rem;
  font-weight: 600;
  color: var(--accent-cyan);
}

.skill-percent {
  font-family: "JetBrains Mono", monospace;
  font-size: 0.82rem;
  color: var(--text-muted);
}

.skill-bar {
  height: 8px;
  border-radius: 999px;
  background: rgba(148, 163, 184, 0.18);
  overflow: hidden;
}

.skill-bar-fill {
  height: 100%;
  border-radius: 999px;
  background: var(--gradient-main);
  transition: width 0.8s ease;
}

/* Legend */
.level-row {
  display: flex;
  gap: 0.65rem;
  align-items: flex-start;
}

.level-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-top: 0.3rem;
  flex-shrink: 0;
}

.level-advanced {
  background: #8b5cf6;
}

.level-proficient {
  background: #3b82f6;
}

.level-working {
  background: #22d3ee;
}

.level-learning {
  background: #64748b;
}

.level-name {
  font-weight: 600;
  font-size: 0.85rem;
}

.level-desc {
  color: var(--text-muted);
  font-size: 0.78rem;
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
