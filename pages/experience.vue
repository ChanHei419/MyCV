<template>
  <div :class="['container-fluid', { 'bg-dark': isDarkMode, 'bg-light': !isDarkMode }]">
    <!-- Header -->
    <header class="bg-primary bg-gradient text-white py-3 mb-4 shadow-sm sticky-top">
      <div class="container d-flex justify-content-between align-items-center flex-wrap gap-3">
        <h1 class="h4 mb-0 fw-bold">Professional Experience Timeline</h1>
        <div class="d-flex gap-2">
          <button @click="exportData" class="btn btn-outline-light btn-sm">📄 Export</button>
          <button @click="sharePortfolio" class="btn btn-outline-light btn-sm">🔗 Share</button>
          <NuxtLink to="/" class="btn btn-light btn-sm">🏠 Home</NuxtLink>
        </div>
      </div>
    </header>
    <button @click="toggleTheme" class="theme-toggle btn btn-light btn-sm mt-50">
      {{ isDarkMode ? "☀️ Light Mode" : "🌙 Dark Mode" }}</button>

    <!-- Main Content -->
    <main class="container">
      <p class="lead text-center mb-4" :class="isDarkMode ? 'text-light' : 'text-dark'">
        Role outcomes and the skills each experience built — no employer names.
      </p>

      <!-- Statistics -->
      <section class="row row-cols-1 row-cols-md-4 g-3 mb-4">
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ totalYears }}</h2>
              <p class="card-text">Years in Tech</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ experiences.length }}</h2>
              <p class="card-text">Industry Roles</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ totalAchievements }}</h2>
              <p class="card-text">Impact Highlights</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ domainCount }}</h2>
              <p class="card-text">Tech Domains</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Search and Filters -->
      <section :class="['card mb-4', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
        <div class="card-body">
          <input
            v-model="searchTerm"
            type="text"
            class="form-control mb-3"
            placeholder="Search roles, skills, or achievements..."
          />
          <div class="d-flex flex-wrap gap-2">
            <button
              v-for="filter in filters"
              :key="filter.key"
              @click="activeFilter = filter.key"
              :class="['btn btn-sm', activeFilter === filter.key ? 'btn-primary' : 'btn-outline-primary']"
            >
              {{ filter.label }}
            </button>
          </div>
        </div>
      </section>

      <!-- Experience Timeline -->
      <section class="position-relative ps-4">
        <div
          v-for="exp in filteredExperiences"
          :key="exp.id"
          class="mb-4 position-relative"
        >
          <div class="position-absolute bg-primary rounded-circle" style="width: 16px; height: 16px; left: -8px; top: 20px;"></div>
          <div :class="['card', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-header bg-primary bg-gradient text-white d-flex align-items-center" @click="toggleDetails(exp.id)">
              <span :class="['me-3 fs-5', { 'rotate-45': openExperienceId === exp.id }]">+</span>
              <div>
                <h3 class="card-title h5 mb-0">{{ exp.title }}</h3>
                <p class="card-text text-white-75 mb-0">{{ exp.focus }} · {{ exp.years }}</p>
              </div>
            </div>
            <transition name="slide">
              <div v-if="openExperienceId === exp.id" class="card-body">
                <h4 class="h6 fw-bold text-primary">What This Role Gave Me:</h4>
                <ul class="list-unstyled">
                  <li
                    v-for="(achievement, index) in exp.achievements"
                    :key="index"
                    @click="highlightAchievement(exp.id, index)"
                    :class="['py-1', {
                      'border-start border-3 border-warning bg-warning-subtle': highlightedAchievement?.expId === exp.id && highlightedAchievement?.index === index
                    }]"
                  >
                    • {{ achievement }}
                  </li>
                </ul>
                <h4 class="h6 fw-bold text-primary mt-3">Skills Built:</h4>
                <div class="d-flex flex-wrap gap-1 mb-3">
                  <span
                    v-for="skill in exp.skills"
                    :key="skill"
                    class="badge bg-secondary"
                  >
                    {{ skill }}
                  </span>
                </div>
                <div class="d-flex flex-wrap gap-2">
                  <button @click="highlightRandomAchievement(exp.id)" class="btn btn-primary btn-sm">✨ Highlight Random</button>
                  <button @click="shareExperience(exp)" class="btn btn-success btn-sm">🔗 Share This</button>
                  <button @click="editExperience(exp)" class="btn btn-warning btn-sm">✏️ Edit</button>
                </div>
              </div>
            </transition>
          </div>
        </div>
      </section>

      <!-- Add Experience Button -->
      <section class="text-center my-4">
        <button @click="showAddModal = true" class="btn btn-primary">➕ Add New Experience</button>
      </section>

      <!-- Add Experience Modal -->
      <div v-if="showAddModal" class="modal fade show d-block" tabindex="-1" @click="showAddModal = false">
        <div class="modal-dialog modal-dialog-centered" @click.stop>
          <div :class="['modal-content', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="modal-header">
              <h5 class="modal-title">Add New Experience</h5>
              <button type="button" class="btn-close" @click="showAddModal = false"></button>
            </div>
            <form @submit.prevent="addNewExperience">
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Role Title</label>
                  <input v-model="newExperience.title" type="text" class="form-control" placeholder="e.g., AI & Cloud Engineering Intern" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Focus Area</label>
                  <input v-model="newExperience.focus" type="text" class="form-control" placeholder="e.g., ServiceNow · Azure · CI/CD" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Years</label>
                  <input v-model="newExperience.years" type="text" class="form-control" placeholder="e.g., 2026 – Present" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Type</label>
                  <select v-model="newExperience.type" class="form-select">
                    <option value="cloud">Cloud & AI</option>
                    <option value="software">Software</option>
                    <option value="quality">Quality / UAT</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" @click="showAddModal = false" class="btn btn-secondary">Cancel</button>
                <button type="submit" class="btn btn-primary">Add Experience</button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- Edit Experience Modal -->
      <div v-if="showEditModal" class="modal fade show d-block" tabindex="-1" @click="showEditModal = false">
        <div class="modal-dialog modal-dialog-centered" @click.stop>
          <div :class="['modal-content', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="modal-header">
              <h5 class="modal-title">Edit Experience</h5>
              <button type="button" class="btn-close" @click="showEditModal = false"></button>
            </div>
            <form @submit.prevent="updateExperience">
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Role Title</label>
                  <input v-model="editingExperience.title" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Focus Area</label>
                  <input v-model="editingExperience.focus" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Years</label>
                  <input v-model="editingExperience.years" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Type</label>
                  <select v-model="editingExperience.type" class="form-select">
                    <option value="cloud">Cloud & AI</option>
                    <option value="software">Software</option>
                    <option value="quality">Quality / UAT</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" @click="showEditModal = false" class="btn btn-secondary">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Experience</button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- Notification -->
      <div v-if="notification.show" :class="['alert', `alert-${notification.type}`, 'position-fixed top-0 end-0 m-3']">
        {{ notification.message }}
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';

// Theme management
const isDarkMode = ref(false);

// Data — role outcomes only, no employer names (by design)
const experiences = ref([
  {
    id: 1,
    title: "AI & Cloud Engineering Intern",
    focus: "ServiceNow · Azure · IaC · CI/CD",
    years: "2026 – Present",
    type: "cloud",
    category: "cloud-ai",
    skills: ["ServiceNow", "Now Assist", "Virtual Agent", "Azure", "Terraform", "Azure DevOps", "OIDC", "Power Automate", "Copilot Studio", "Entra ID"],
    achievements: [
      "Built a ServiceNow workflow consolidating per-group incident data into automated CSV reports",
      "Developed custom ServiceNow tables, Business Rules, and Script Includes for report automation",
      "Built a Now Assist Skill Kit and fixed Virtual Agent catalog mis-routing across request types",
      "Provisioned Azure resources via Terraform with secure OIDC-based CI/CD authentication",
      "Automated guest-domain whitelisting across SharePoint, Entra ID, and Teams with Copilot Studio and Power Automate",
      "Implemented Azure Automation runbooks with certificate-based and Managed Identity auth for least-privilege provisioning",
    ],
  },
  {
    id: 2,
    title: "Software Engineering Intern (FinTech)",
    focus: "Nuxt.js · Python · C# · SQL",
    years: "2025",
    type: "software",
    category: "software",
    skills: ["Nuxt.js", "Python", "C#", "SQL", "Reporting Automation"],
    achievements: [
      "Built and deployed a redesigned corporate webpage using Nuxt.js",
      "Automated database-driven Excel reporting with Python for project records",
      "Improved a legacy C# and SQL system, cutting runtime from 2m 30s to 1m 20s (≈45%)",
      "Updated SQL queries and application logic to improve notification reliability and data handling",
    ],
  },
  {
    id: 3,
    title: "UAT & Technical Intern (Part-time)",
    focus: "Quality Assurance · Requirements Validation",
    years: "2026 – Present",
    type: "quality",
    category: "quality",
    skills: ["UAT", "Defect Reporting", "Business Requirements"],
    achievements: [
      "Execute UAT scenarios against business requirements and document reproducible defects with evidence",
    ],
  },
]);

// State
const openExperienceId = ref(null);
const highlightedAchievement = ref(null);
const searchTerm = ref("");
const activeFilter = ref("all");
const showAddModal = ref(false);
const showEditModal = ref(false);
const newExperience = ref({
  title: "",
  focus: "",
  years: "",
  type: "cloud",
  category: "cloud-ai",
  achievements: ["New achievement to be added"],
  skills: [],
});
const editingExperience = ref({});
const notification = ref({
  show: false,
  message: "",
  type: "success",
});

// Filters
const filters = [
  { key: "all", label: "All" },
  { key: "current", label: "Current" },
  { key: "cloud", label: "Cloud & AI" },
  { key: "software", label: "Software" },
  { key: "quality", label: "Quality" },
];

// Computed properties
const totalYears = computed(() => {
  const startYear = 2023; // Start of BEng Information Engineering
  return new Date().getFullYear() - startYear;
});

const totalAchievements = computed(() => {
  return experiences.value.reduce(
    (sum, exp) => sum + exp.achievements.length,
    0
  );
});

const domainCount = computed(() => {
  return new Set(experiences.value.map((exp) => exp.category)).size;
});

const filteredExperiences = computed(() => {
  return experiences.value.filter((exp) => {
    const matchesSearch =
      searchTerm.value === "" ||
      exp.title.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      exp.focus.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      exp.skills.some((skill) =>
        skill.toLowerCase().includes(searchTerm.value.toLowerCase())
      ) ||
      exp.achievements.some((achievement) =>
        achievement.toLowerCase().includes(searchTerm.value.toLowerCase())
      );

    let matchesFilter = true;
    if (activeFilter.value === "current") {
      matchesFilter = exp.years.includes("Present");
    } else if (activeFilter.value === "cloud") {
      matchesFilter = exp.category === "cloud-ai";
    } else if (activeFilter.value === "software") {
      matchesFilter = exp.category === "software";
    } else if (activeFilter.value === "quality") {
      matchesFilter = exp.category === "quality";
    }

    return matchesSearch && matchesFilter;
  });
});

// Methods
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
};

const toggleDetails = (expId) => {
  openExperienceId.value = openExperienceId.value === expId ? null : expId;
};

const highlightAchievement = (expId, achIndex) => {
  highlightedAchievement.value = { expId, index: achIndex };
};

const highlightRandomAchievement = (expId) => {
  const exp = experiences.value.find((e) => e.id === expId);
  if (exp) {
    const randomIndex = Math.floor(Math.random() * exp.achievements.length);
    highlightAchievement(expId, randomIndex);
  }
};

const shareExperience = async (exp) => {
  const shareText = `Check out my experience as ${exp.title} (${exp.years}): ${exp.focus}`;
  if (import.meta.client) {
    if (navigator.share) {
      try {
        await navigator.share({
          title: "Professional Experience",
          text: shareText,
          url: window.location.href,
        });
      } catch (err) {
        console.log("Share cancelled");
      }
    } else if (navigator.clipboard) {
      try {
        await navigator.clipboard.writeText(shareText);
        showNotification("Experience details copied to clipboard!", "success");
      } catch (err) {
        showNotification("Failed to copy to clipboard", "error");
      }
    }
  }
};

const editExperience = (exp) => {
  editingExperience.value = { ...exp };
  showEditModal.value = true;
};

const updateExperience = () => {
  const index = experiences.value.findIndex(
    (e) => e.id === editingExperience.value.id
  );
  if (index !== -1) {
    experiences.value[index] = { ...editingExperience.value };
    showEditModal.value = false;
    showNotification("Experience updated successfully!", "success");
  }
};

const addNewExperience = () => {
  const newExp = {
    ...newExperience.value,
    id: Math.max(...experiences.value.map((e) => e.id)) + 1,
  };
  experiences.value.unshift(newExp);
  showAddModal.value = false;
  newExperience.value = {
    title: "",
    focus: "",
    years: "",
    type: "cloud",
    category: "cloud-ai",
    achievements: ["New achievement to be added"],
    skills: [],
  };
  showNotification("New experience added successfully!", "success");
};

const exportData = () => {
  if (import.meta.client) {
    const content = experiences.value
      .map(
        (exp) =>
          `${exp.title} (${exp.years}) — ${exp.focus}\n${exp.achievements
            .map((a) => `• ${a}`)
            .join("\n")}`
      )
      .join("\n\n");
    const blob = new Blob([content], { type: "text/plain" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "professional-experience.txt";
    a.click();
    URL.revokeObjectURL(url);
    showNotification("Experience exported successfully!", "success");
  }
};

const sharePortfolio = async () => {
  if (import.meta.client) {
    const url = window.location.href;
    if (navigator.share) {
      try {
        await navigator.share({
          title: "My Professional Experience Timeline",
          text: "Check out my professional journey and the skills I've built",
          url: url,
        });
      } catch (err) {
        console.log("Share cancelled");
      }
    } else if (navigator.clipboard) {
      try {
        await navigator.clipboard.writeText(url);
        showNotification("Portfolio link copied to clipboard!", "success");
      } catch (err) {
        showNotification("Failed to copy link", "error");
      }
    }
  }
};

const showNotification = (message, type = "success") => {
  notification.value = { show: true, message, type };
  setTimeout(() => {
    notification.value.show = false;
  }, 3000);
};

// Theme detection
onMounted(() => {
  if (import.meta.client && window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
    isDarkMode.value = true;
  }
});
</script>

<style lang="scss" scoped>
/* Minimal SCSS for essential customizations */
.container-fluid {
  min-height: 100vh;
}

/* Timeline line */
section.position-relative::before {
  content: "";
  position: absolute;
  left: 15px;
  top: 0;
  bottom: 0;
  width: 4px;
  background: linear-gradient(to bottom, #0d6efd, #6610f2);
  border-radius: 2px;
}

/* Rotate expand icon */
.rotate-45 {
  transform: rotate(45deg);
  transition: transform 0.3s ease;
}

/* Slide transition for card content */
.slide-enter-active,
.slide-leave-active {
  transition: all 0.4s ease;
}

.slide-enter-from,
.slide-leave-to {
  opacity: 0;
  max-height: 0;
  overflow: hidden;
}

.slide-enter-to,
.slide-leave-from {
  opacity: 1;
  max-height: 1000px;
}

/* White text for specific elements */
.card-header .card-title,
.card-header .card-text {
  color: #ffffff !important;
  font-weight: bold;
}

/* Default light mode */
:root, [data-theme="light"] {
  --background: #fff;
  --text-color: #1a202c;
  --toggle-bg: #4a90e2;
  --toggle-hover-bg: #357abd;
  --toggle-focus: #2a5a94;
  --toggle-color: #fff;
}

/* Dark mode */
[data-theme="dark"] {
  --background: #1a202c;
  --text-color: #e2e8f0;
  --toggle-bg: #6b7280;
  --toggle-hover-bg: #4b5563;
  --toggle-focus: #9ca3af;
  --toggle-color: #fff;
}

/* Apply theme variables */
body {
  background-color: var(--background);
  color: var(--text-color);
  transition: background-color 0.3s ease, color 0.3s ease;
}
</style>