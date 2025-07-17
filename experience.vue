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
<button  @click="toggleTheme" class=" theme-toggle btn btn-light btn-sm mt-50">
            {{ isDarkMode ? "☀️ Light Mode" : "🌙 Dark Mode" }}</button>
    <!-- Main Content -->
    <main class="container">
      <!-- Statistics -->
      <section class="row row-cols-1 row-cols-md-4 g-3 mb-4">
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ totalYears }}</h2>
              <p class="card-text">Years Experience</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ experiences.length }}</h2>
              <p class="card-text">Positions Held</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ totalAchievements }}</h2>
              <p class="card-text">Key Achievements</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ highlightCount }}</h2>
              <p class="card-text">Highlights Made</p>
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
            placeholder="Search experiences, companies, or achievements..."
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
                <h3 class="card-title h5 mb-0">{{ exp.title }} - {{ exp.company }}</h3>
                <p class="card-text text-white-75 mb-0">{{ exp.years }}</p>
              </div>
            </div>
            <transition name="slide">
              <div v-if="openExperienceId === exp.id" class="card-body">
                <h4 class="h6 fw-bold text-primary">Key Achievements:</h4>
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
                  <label class="form-label">Job Title</label>
                  <input v-model="newExperience.title" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Company</label>
                  <input v-model="newExperience.company" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Years</label>
                  <input v-model="newExperience.years" type="text" class="form-control" placeholder="e.g., 2020 - 2022" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Type</label>
                  <select v-model="newExperience.type" class="form-select">
                    <option value="junior">Junior</option>
                    <option value="mid">Mid-level</option>
                    <option value="senior">Senior</option>
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
                  <label class="form-label">Job Title</label>
                  <input v-model="editingExperience.title" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Company</label>
                  <input v-model="editingExperience.company" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Years</label>
                  <input v-model="editingExperience.years" type="text" class="form-control" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">Type</label>
                  <select v-model="editingExperience.type" class="form-select">
                    <option value="junior">Junior</option>
                    <option value="mid">Mid-level</option>
                    <option value="senior">Senior</option>
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

// Data
const experiences = ref([
  {
    id: 1,
    title: "Senior Software Engineer",
    company: "Tech Innovations Inc.",
    years: "2022 - Present",
    type: "senior",
    category: "technical",
    achievements: [
      "Led development of microservices architecture serving 1M+ users",
      "Mentored 5 junior developers and improved team productivity by 40%",
      "Implemented CI/CD pipeline reducing deployment time by 60%",
      "Designed and built real-time analytics dashboard",
      "Contributed to open-source projects with 500+ GitHub stars",
    ],
  },
  {
    id: 2,
    title: "Frontend Developer",
    company: "Digital Solutions Ltd.",
    years: "2020 - 2022",
    type: "mid",
    category: "technical",
    achievements: [
      "Developed responsive web applications using React and Vue.js",
      "Improved website performance by 50% through optimization",
      "Collaborated with UX team to implement modern design systems",
      "Built Progressive Web App with offline capabilities",
    ],
  },
  {
    id: 3,
    title: "Junior Developer",
    company: "StartUp Ventures",
    years: "2018 - 2020",
    type: "junior",
    category: "technical",
    achievements: [
      "Built and maintained company website using modern frameworks",
      "Participated in agile development processes",
      "Learned and applied best practices in software development",
      "Contributed to code reviews and technical documentation",
    ],
  },
]);

// State
const openExperienceId = ref(null);
const highlightedAchievement = ref(null);
const highlightCount = ref(0);
const searchTerm = ref("");
const activeFilter = ref("all");
const showAddModal = ref(false);
const showEditModal = ref(false);
const newExperience = ref({
  title: "",
  company: "",
  years: "",
  type: "mid",
  category: "technical",
  achievements: ["New achievement to be added"],
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
  { key: "recent", label: "Recent" },
  { key: "senior", label: "Senior" },
  { key: "technical", label: "Technical" },
];

// Computed properties
const totalYears = computed(() => {
  const currentYear = new Date().getFullYear();
  const startYear = Math.min(
    ...experiences.value.map((exp) => {
      const match = exp.years.match(/(\d{4})/);
      return match ? parseInt(match[1]) : currentYear;
    })
  );
  return currentYear - startYear;
});

const totalAchievements = computed(() => {
  return experiences.value.reduce(
    (sum, exp) => sum + exp.achievements.length,
    0
  );
});

const filteredExperiences = computed(() => {
  return experiences.value.filter((exp) => {
    const matchesSearch =
      searchTerm.value === "" ||
      exp.title.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      exp.company.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      exp.achievements.some((achievement) =>
        achievement.toLowerCase().includes(searchTerm.value.toLowerCase())
      );

    let matchesFilter = true;
    if (activeFilter.value === "recent") {
      matchesFilter =
        exp.years.includes("2022") ||
        exp.years.includes("2023") ||
        exp.years.includes("Present");
    } else if (activeFilter.value === "senior") {
      matchesFilter = exp.type === "senior";
    } else if (activeFilter.value === "technical") {
      matchesFilter = exp.category === "technical";
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
  highlightCount.value++;
};

const highlightRandomAchievement = (expId) => {
  const exp = experiences.value.find((e) => e.id === expId);
  if (exp) {
    const randomIndex = Math.floor(Math.random() * exp.achievements.length);
    highlightAchievement(expId, randomIndex);
  }
};

const shareExperience = async (exp) => {
  const shareText = `Check out my experience as ${exp.title} at ${exp.company} (${exp.years})`;
  if (process.client) {
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
    category: "technical",
  };
  experiences.value.unshift(newExp);
  showAddModal.value = false;
  newExperience.value = {
    title: "",
    company: "",
    years: "",
    type: "mid",
    category: "technical",
    achievements: ["New achievement to be added"],
  };
  showNotification("New experience added successfully!", "success");
};

const exportData = () => {
  if (process.client) {
    const content = experiences.value
      .map(
        (exp) =>
          `${exp.title} - ${exp.company} (${exp.years})\n${exp.achievements
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
  if (process.client) {
    const url = window.location.href;
    if (navigator.share) {
      try {
        await navigator.share({
          title: "My Professional Experience Timeline",
          text: "Check out my professional journey and achievements",
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
  if (process.client && window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
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
.word_beautiful,
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
