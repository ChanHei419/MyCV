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
              <i class="fa-solid fa-briefcase"></i> Experience
            </span>
            <h1 class="page-title gradient-text">What industry taught me</h1>
            <p class="section-lede mx-auto">
              Role outcomes and the skills each experience built — no employer
              names, no dates. The work speaks for itself.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Stats -->
    <section class="section-shell pt-0">
      <div class="container">
        <div class="row g-3 justify-content-center">
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ experiences.length }}</div>
              <div class="stat-label">Industry Roles</div>
            </div>
          </div>
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ totalAchievements }}</div>
              <div class="stat-label">Impact Highlights</div>
            </div>
          </div>
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ skillsCount }}</div>
              <div class="stat-label">Skills Built</div>
            </div>
          </div>
          <div class="col-6 col-lg-3" data-reveal>
            <div class="glass-card stat-tile">
              <div class="stat-value">{{ domainCount }}</div>
              <div class="stat-label">Tech Domains</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Filters -->
    <section class="section-shell pt-0">
      <div class="container">
        <div class="row justify-content-center mb-4" data-reveal>
          <div class="col-lg-9">
            <div class="glass-card p-3 p-md-4">
              <div class="row g-3 align-items-center">
                <div class="col-md-5">
                  <div class="input-icon">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input
                      v-model="searchTerm"
                      type="text"
                      class="form-control"
                      placeholder="Search roles, skills, or outcomes..."
                    />
                  </div>
                </div>
                <div class="col-md-7">
                  <div class="d-flex flex-wrap gap-2 justify-content-md-end">
                    <button
                      v-for="filter in filters"
                      :key="filter.key"
                      :class="[
                        'btn btn-sm filter-btn',
                        activeFilter === filter.key ? 'btn-primary' : 'btn-outline-light',
                      ]"
                      @click="activeFilter = filter.key"
                    >
                      <i :class="filter.icon" class="me-1"></i>{{ filter.label }}
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Timeline -->
        <div class="row justify-content-center">
          <div class="col-lg-9">
            <div class="timeline">
              <div
                v-for="experience in filteredExperiences"
                :key="experience.id"
                class="timeline-entry"
                data-reveal
              >
                <span class="timeline-node">
                  <i :class="experience.icon"></i>
                </span>

                <div class="glass-card overflow-hidden">
                  <button
                    class="entry-header"
                    :aria-expanded="openExperienceId === experience.id"
                    @click="toggleDetails(experience.id)"
                  >
                    <div class="text-start">
                      <h2 class="h6 fw-bold mb-1">{{ experience.title }}</h2>
                      <p class="entry-focus mb-0">{{ experience.focus }}</p>
                    </div>
                    <i
                      class="fa-solid fa-chevron-down entry-chevron"
                      :class="{ open: openExperienceId === experience.id }"
                    ></i>
                  </button>

                  <Transition name="expand">
                    <div v-if="openExperienceId === experience.id" class="entry-body">
                      <p class="text-muted-s small mb-3">
                        {{ experience.summary }}
                      </p>

                      <h3 class="entry-subheading">Outcomes</h3>
                      <ul class="outcome-list">
                        <li
                          v-for="achievement in experience.achievements"
                          :key="achievement"
                        >
                          <i class="fa-solid fa-circle-check"></i>
                          <span>{{ achievement }}</span>
                        </li>
                      </ul>

                      <h3 class="entry-subheading">Skills built</h3>
                      <div class="d-flex flex-wrap gap-1 mb-3">
                        <span
                          v-for="skill in experience.skills"
                          :key="skill"
                          class="chip chip-mini"
                        >
                          {{ skill }}
                        </span>
                      </div>

                      <button
                        class="btn btn-sm btn-outline-light"
                        @click="shareExperience(experience)"
                      >
                        <i class="fa-solid fa-share-nodes me-1"></i>Share this role
                      </button>
                    </div>
                  </Transition>
                </div>
              </div>
            </div>

            <p
              v-if="filteredExperiences.length === 0"
              class="text-center text-muted-s mt-4"
            >
              No roles match your search.
            </p>
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

const experiences = ref([
  {
    id: 1,
    title: "AI & Cloud Engineering Intern",
    focus: "ServiceNow · Azure · Infrastructure as Code · CI/CD",
    type: "cloud",
    category: "cloud-ai",
    icon: "fa-solid fa-cloud",
    summary:
      "Enterprise automation and cloud engineering in production: designing service workflows, provisioning infrastructure as code, and removing secrets from deployment pipelines.",
    skills: [
      "ServiceNow",
      "Now Assist",
      "Virtual Agent",
      "Azure",
      "Terraform",
      "Azure DevOps",
      "OIDC",
      "Power Automate",
      "Copilot Studio",
      "Entra ID",
    ],
    achievements: [
      "Built a ServiceNow workflow that consolidates per-group incident data into automated CSV reports, replacing manual collection",
      "Developed custom ServiceNow tables, Business Rules, and Script Includes to make reporting repeatable and auditable",
      "Built a Now Assist Skill Kit and fixed Virtual Agent catalog mis-routing across request types",
      "Provisioned Azure resources via Terraform with OIDC-based CI/CD authentication — no long-lived credentials",
      "Automated guest-domain whitelisting across SharePoint, Entra ID, and Teams using Copilot Studio and Power Automate",
      "Implemented Azure Automation runbooks with certificate-based and Managed Identity auth for least-privilege provisioning",
    ],
  },
  {
    id: 2,
    title: "Software Engineering Intern (FinTech)",
    focus: "Nuxt.js · Python · C# · SQL",
    type: "software",
    category: "software",
    icon: "fa-solid fa-code",
    summary:
      "Shipped user-facing software, automated database-driven reporting, and optimised a legacy service without breaking it.",
    skills: [
      "Nuxt.js",
      "Vue.js",
      "Python",
      "C#",
      "SQL",
      "Reporting Automation",
    ],
    achievements: [
      "Built and deployed a redesigned corporate website using Nuxt.js",
      "Automated database-driven Excel reporting with Python, replacing a recurring manual process",
      "Improved a legacy C# and SQL system, cutting runtime from 2m 30s to 1m 20s (≈45%)",
      "Updated SQL queries and application logic to improve notification reliability and data handling",
    ],
  },
  {
    id: 3,
    title: "UAT & Technical Intern",
    focus: "Quality Assurance · Requirements Validation",
    type: "quality",
    category: "quality",
    icon: "fa-solid fa-clipboard-check",
    summary:
      "Turned business requirements into reproducible test evidence and precise defect reports.",
    skills: ["UAT", "Defect Reporting", "Business Requirements", "Test Evidence"],
    achievements: [
      "Execute UAT scenarios against business requirements and document reproducible defects with evidence",
      "Translate requirements into test cases that developers can act on immediately",
    ],
  },
]);

const filters = [
  { key: "all", label: "All", icon: "fa-solid fa-border-all" },
  { key: "cloud", label: "Cloud & AI", icon: "fa-solid fa-cloud" },
  { key: "software", label: "Software", icon: "fa-solid fa-code" },
  { key: "quality", label: "Quality", icon: "fa-solid fa-clipboard-check" },
];

const searchTerm = ref("");
const activeFilter = ref("all");
const openExperienceId = ref(experiences.value[0].id);

const totalAchievements = computed(() =>
  experiences.value.reduce((sum, item) => sum + item.achievements.length, 0)
);

const domainCount = computed(
  () => new Set(experiences.value.map((item) => item.category)).size
);

const skillsCount = computed(
  () => new Set(experiences.value.flatMap((item) => item.skills)).size
);

const filteredExperiences = computed(() => {
  const term = searchTerm.value.trim().toLowerCase();

  return experiences.value.filter((experience) => {
    const matchesFilter =
      activeFilter.value === "all" ||
      experience.type === activeFilter.value;

    if (!matchesFilter) return false;
    if (!term) return true;

    return (
      experience.title.toLowerCase().includes(term) ||
      experience.focus.toLowerCase().includes(term) ||
      experience.summary.toLowerCase().includes(term) ||
      experience.skills.some((skill) => skill.toLowerCase().includes(term)) ||
      experience.achievements.some((achievement) =>
        achievement.toLowerCase().includes(term)
      )
    );
  });
});

const toggleDetails = (id) => {
  openExperienceId.value = openExperienceId.value === id ? null : id;
};

const shareExperience = async (experience) => {
  const text = `${experience.title} — ${experience.focus}: ${experience.achievements[0]}`;
  if (!import.meta.client) return;

  if (navigator.share) {
    try {
      await navigator.share({
        title: experience.title,
        text,
        url: window.location.href,
      });
    } catch (error) {
      /* share cancelled */
    }
  } else if (navigator.clipboard) {
    await navigator.clipboard.writeText(`${text}\n${window.location.href}`);
  }
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

.filter-btn {
  border-radius: 999px;
  font-size: 0.82rem;
}

/* Search input with icon */
.input-icon {
  position: relative;
}

.input-icon i {
  position: absolute;
  left: 14px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-muted);
  font-size: 0.85rem;
  pointer-events: none;
}

.input-icon .form-control {
  padding-left: 2.4rem;
  background: rgba(2, 6, 23, 0.4);
  border: 1px solid var(--border-soft);
  color: var(--text-primary);
  border-radius: 12px;
}

.input-icon .form-control:focus {
  background: rgba(2, 6, 23, 0.55);
  border-color: var(--accent-violet);
  color: var(--text-primary);
  box-shadow: 0 0 0 0.2rem rgba(139, 92, 246, 0.2);
}

/* Timeline */
.timeline {
  position: relative;
  padding-left: 2.2rem;
}

.timeline::before {
  content: "";
  position: absolute;
  left: 0.85rem;
  top: 0;
  bottom: 0;
  width: 2px;
  background: linear-gradient(180deg, #8b5cf6, #22d3ee);
  opacity: 0.5;
}

.timeline-entry {
  position: relative;
  margin-bottom: 1.75rem;
}

.timeline-entry:last-child {
  margin-bottom: 0;
}

.timeline-node {
  position: absolute;
  left: -2.2rem;
  top: 1.2rem;
  width: 38px;
  height: 38px;
  border-radius: 12px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  background: var(--gradient-main);
  box-shadow: 0 8px 20px rgba(59, 130, 246, 0.35);
  z-index: 2;
}

/* Entry card */
.entry-header {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  padding: 1.2rem 1.4rem;
  background: transparent;
  border: none;
  color: inherit;
  cursor: pointer;
  text-align: left;
}

.entry-focus {
  color: var(--text-muted);
  font-size: 0.85rem;
}

.entry-chevron {
  transition: transform 0.25s ease;
  color: var(--text-muted);
}

.entry-chevron.open {
  transform: rotate(180deg);
}

.entry-body {
  padding: 0 1.4rem 1.4rem;
  border-top: 1px solid var(--border-soft);
  padding-top: 1.2rem;
}

.entry-subheading {
  text-transform: uppercase;
  letter-spacing: 0.14em;
  font-size: 0.72rem;
  font-weight: 700;
  color: var(--accent-cyan);
  margin-bottom: 0.7rem;
}

.outcome-list {
  list-style: none;
  padding: 0;
  margin: 0 0 1.25rem;
}

.outcome-list li {
  display: flex;
  gap: 0.6rem;
  align-items: flex-start;
  color: var(--text-muted);
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
}

.outcome-list i {
  color: #34d399;
  margin-top: 0.2rem;
  flex-shrink: 0;
}

/* Expand transition */
.expand-enter-active,
.expand-leave-active {
  transition: all 0.35s ease;
  overflow: hidden;
}

.expand-enter-from,
.expand-leave-to {
  opacity: 0;
  max-height: 0;
}

.expand-enter-to,
.expand-leave-from {
  opacity: 1;
  max-height: 800px;
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

@media (max-width: 575px) {
  .timeline {
    padding-left: 1.6rem;
  }

  .timeline-node {
    left: -1.7rem;
    width: 32px;
    height: 32px;
    font-size: 0.85rem;
  }

  .entry-header {
    padding: 1rem;
  }

  .entry-body {
    padding: 1rem;
  }
}
</style>
