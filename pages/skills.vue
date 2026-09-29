<template>
  <div :class="['container-fluid', { 'bg-dark': isDarkMode, 'bg-light': !isDarkMode }]">
    <!-- Banner -->
    <header class="bg-primary bg-gradient text-white py-3 mb-4 shadow-sm sticky-top">
      <div class="container d-flex justify-content-between align-items-center flex-wrap gap-3">
        <span class="h4 mb-0 fw-bold">💼 Skills Portfolio</span>
        <div class="d-flex gap-2">
          <button @click="toggleTheme" class="btn btn-light btn-sm">
            {{ isDarkMode ? "☀️ Light Mode" : "🌙 Dark Mode" }}
          </button>
          <button @click="exportSkills" class="btn btn-outline-light btn-sm">📤 Export</button>
          <NuxtLink to="/" class="btn btn-light btn-sm">🏠 Home</NuxtLink>
        </div>
      </div>
    </header>

    <button @click="toggleTheme" class="theme-toggle btn btn-light btn-sm mt-50">
      {{ isDarkMode ? "☀️ Light Mode" : "🌙 Dark Mode" }}</button>

    <!-- Main Content -->
    <main class="container">
      <!-- Stats Dashboard -->
      <section class="row row-cols-1 row-cols-md-4 g-3 mb-4">
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ stats.totalSkills }}</h2>
              <p class="card-text">Total Skills</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ stats.avgProficiency }}%</h2>
              <p class="card-text">Avg Proficiency</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ stats.highestSkill.name }}</h2>
              <p class="card-text">Top Skill</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div :class="['card h-100 text-center', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
            <div class="card-body">
              <h2 class="card-title h3 fw-bold">{{ Object.keys(stats.categoryCounts).length }}</h2>
              <p class="card-text">Categories</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Action Buttons -->
      <section class="d-flex flex-wrap gap-2 justify-content-center mb-4">
        <button @click="highlightSkill" class="btn btn-primary btn-sm">✨ Highlight Random</button>
        <button @click="shuffleSkills" class="btn btn-primary btn-sm">🔄 Shuffle Skills</button>
        <button @click="showAddForm = !showAddForm" class="btn btn-primary btn-sm">➕ Add Skill</button>
      </section>

      <!-- Category Filter -->
      <section class="mb-4">
        <div :class="['card', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
          <div class="card-body d-flex align-items-center gap-3">
            <label class="form-label mb-0">Filter by Category:</label>
            <select v-model="selectedCategory" class="form-select w-auto">
              <option v-for="category in categories" :key="category" :value="category">
                {{ category }}
              </option>
            </select>
          </div>
        </div>
      </section>

      <!-- Add Skill Form -->
      <Transition name="slide-down">
        <div v-if="showAddForm" :class="['card mb-4', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark']">
          <div class="card-body">
            <h3 class="card-title h5 mb-3">Add New Skill</h3>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">Skill Name</label>
                <input v-model="newSkill.name" type="text" class="form-control" placeholder="Enter skill name" />
              </div>
              <div class="col-md-6">
                <label class="form-label">Category</label>
                <select v-model="newSkill.category" class="form-select">
                  <option value="Software Engineering">Software Engineering</option>
                  <option value="Cloud & AI">Cloud & AI</option>
                  <option value="Data">Data</option>
                  <option value="Security & Tools">Security & Tools</option>
                </select>
              </div>
              <div class="col-12">
                <label class="form-label">Description</label>
                <textarea v-model="newSkill.description" class="form-control" rows="3" placeholder="Describe your skill and experience"></textarea>
              </div>
              <div class="col-12">
                <label class="form-label">Proficiency: {{ newSkill.proficiency }}%</label>
                <input v-model="newSkill.proficiency" type="range" min="0" max="100" class="form-range" />
              </div>
            </div>
            <div class="d-flex gap-2 justify-content-end mt-3">
              <button @click="addNewSkill" class="btn btn-primary">Add Skill</button>
              <button @click="showAddForm = false" class="btn btn-secondary">Cancel</button>
            </div>
          </div>
        </div>
      </Transition>

      <!-- Skills Grid -->
      <section class="row row-cols-1 row-cols-md-3 g-4">
        <TransitionGroup name="skill-list">
          <div v-for="(skill, index) in filteredSkills" :key="`${skill.name}-${index}`" class="col">
            <div :class="['card h-100', isDarkMode ? 'bg-dark text-light' : 'bg-white text-dark', { 'border-primary': highlightedSkill === skill.name }]" @click="toggleFlip(index)">
              <div class="card-header bg-primary bg-gradient text-white d-flex align-items-center">
                <span class="me-3 fs-4">{{ skill.icon }}</span>
                <div>
                  <h3 class="card-title h6 mb-0">{{ skill.name }}</h3>
                  <small class="text-white-75">{{ skill.category }}</small>
                </div>
              </div>
              <div :class="['card-body', { 'd-none': flippedIndex !== index }]">
                <p class="card-text">{{ skill.description }}</p>
                <div class="d-flex justify-content-between mb-2">
                  <span>Proficiency Level</span>
                  <span>{{ skill.proficiency }}%</span>
                </div>
                <div class="progress">
                  <div
                    :class="['progress-bar bg-primary', { 'bg-warning': highlightedSkill === skill.name }]"
                    :style="{ width: `${skill.proficiency}%` }"
                  ></div>
                </div>
                <button @click.stop="removeSkill(index)" class="btn btn-danger btn-sm mt-3">🗑️ Remove</button>
              </div>
            </div>
          </div>
        </TransitionGroup>
      </section>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';

// Theme Toggle
const isDarkMode = ref(false);
const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
};

// Skills Data — grouped by the four domains I build in
const skills = ref([
  // Software Engineering
  {
    name: "Nuxt.js / Vue 3",
    description: "Built and deployed a production corporate website, and engineered this multi-page animated portfolio with Nuxt 3, Vue 3, and SCSS.",
    proficiency: 85,
    icon: "💚",
    category: "Software Engineering",
  },
  {
    name: "Python",
    description: "Automation, Flask / FastAPI REST APIs, and data tooling used across AI and reporting projects.",
    proficiency: 85,
    icon: "🐍",
    category: "Software Engineering",
  },
  {
    name: "JavaScript",
    description: "Modern ES6+, async patterns, and browser APIs powering interactive user interfaces.",
    proficiency: 82,
    icon: "🟨",
    category: "Software Engineering",
  },
  {
    name: "C#",
    description: "Optimized a legacy .NET / SQL messaging service, cutting runtime by 45%.",
    proficiency: 70,
    icon: "🔷",
    category: "Software Engineering",
  },
  {
    name: "Kotlin",
    description: "Android development for a campus navigation app with Retrofit and MongoDB.",
    proficiency: 72,
    icon: "🤖",
    category: "Software Engineering",
  },
  {
    name: "PHP / Laravel",
    description: "MVC architecture, Eloquent ORM, migrations, validation, and Blade views in a full CRUD system.",
    proficiency: 75,
    icon: "🐘",
    category: "Software Engineering",
  },
  {
    name: "Git & GitHub",
    description: "Version control, branching, pull requests, and collaborative workflows.",
    proficiency: 85,
    icon: "🌿",
    category: "Software Engineering",
  },
  // Cloud & AI
  {
    name: "Microsoft Azure",
    description: "Provisioned resources as code with Terraform and automated deployment via Azure DevOps pipelines.",
    proficiency: 80,
    icon: "☁️",
    category: "Cloud & AI",
  },
  {
    name: "Terraform (IaC)",
    description: "Declarative infrastructure with secure OIDC authentication and least-privilege access.",
    proficiency: 78,
    icon: "🏗️",
    category: "Cloud & AI",
  },
  {
    name: "ServiceNow",
    description: "Custom tables, Business Rules, Script Includes, Virtual Agent, and Now Assist Skill Kits.",
    proficiency: 80,
    icon: "⚙️",
    category: "Cloud & AI",
  },
  {
    name: "Power Automate & Copilot Studio",
    description: "Cross-platform automation across SharePoint, Entra ID, and Teams.",
    proficiency: 80,
    icon: "🔄",
    category: "Cloud & AI",
  },
  {
    name: "Identity & Access",
    description: "Entra ID, OIDC federated credentials, certificate auth, and Managed Identities for secretless flows.",
    proficiency: 75,
    icon: "🔐",
    category: "Cloud & AI",
  },
  {
    name: "PyTorch & Wav2Vec2",
    description: "Fine-tuned speech recognition models; designed multi-stage AI pipelines (Demucs → Wav2Vec2).",
    proficiency: 72,
    icon: "🧠",
    category: "Cloud & AI",
  },
  {
    name: "Docker",
    description: "Containerized development environments and services.",
    proficiency: 65,
    icon: "🐳",
    category: "Cloud & AI",
  },
  // Data
  {
    name: "SQL (MySQL / SQLite)",
    description: "Schema design, complex queries, and performance tuning for production systems.",
    proficiency: 82,
    icon: "🗄️",
    category: "Data",
  },
  {
    name: "MongoDB",
    description: "Document modelling for user auth, profiles, and chat history in an Android app backend.",
    proficiency: 75,
    icon: "🍃",
    category: "Data",
  },
  {
    name: "REST API Design",
    description: "Designed Flask / FastAPI endpoints with asynchronous processing and real-time progress reporting.",
    proficiency: 82,
    icon: "🔌",
    category: "Data",
  },
  {
    name: "Data Structures & Algorithms",
    description: "CUHK Information Engineering coursework: complexity analysis, graphs, trees, and algorithm design.",
    proficiency: 85,
    icon: "📊",
    category: "Data",
  },
  {
    name: "Data Automation & Reporting",
    description: "Python scripts generating database-driven Excel reports, replacing manual work.",
    proficiency: 80,
    icon: "📈",
    category: "Data",
  },
  // Security & Tools
  {
    name: "Linux",
    description: "Daily command-line workflows, scripting, and lab environments.",
    proficiency: 78,
    icon: "🐧",
    category: "Security & Tools",
  },
  {
    name: "Nmap & Suricata",
    description: "Network scanning and signature-based intrusion detection.",
    proficiency: 70,
    icon: "🛡️",
    category: "Security & Tools",
  },
  {
    name: "Cryptography Fundamentals",
    description: "Applied cryptography coursework: encryption, hashing, and secure protocols.",
    proficiency: 72,
    icon: "🔏",
    category: "Security & Tools",
  },
]);

// State
const flippedIndex = ref(null);
const showAddForm = ref(false);
const newSkill = ref({
  name: "",
  description: "",
  proficiency: 50,
  icon: "⭐",
  category: "Software Engineering",
});
const selectedCategory = ref("All");
const highlightedSkill = ref("");

// Computed Properties
const categories = computed(() => {
  const cats = [...new Set(skills.value.map((skill) => skill.category))];
  return ["All", ...cats];
});

const filteredSkills = computed(() => {
  if (selectedCategory.value === "All") return skills.value;
  return skills.value.filter((skill) => skill.category === selectedCategory.value);
});

const stats = computed(() => ({
  totalSkills: skills.value.length,
  avgProficiency: Math.round(
    skills.value.reduce((sum, skill) => sum + skill.proficiency, 0) / skills.value.length
  ),
  highestSkill: skills.value.reduce((highest, skill) =>
    skill.proficiency > highest.proficiency ? skill : highest
  ),
  categoryCounts: skills.value.reduce((acc, skill) => {
    acc[skill.category] = (acc[skill.category] || 0) + 1;
    return acc;
  }, {}),
}));

// Methods
const toggleFlip = (index) => {
  flippedIndex.value = flippedIndex.value === index ? null : index;
};

const highlightSkill = () => {
  const randomIndex = Math.floor(Math.random() * skills.value.length);
  highlightedSkill.value = skills.value[randomIndex].name;
  setTimeout(() => {
    highlightedSkill.value = "";
  }, 3000);
};

const addNewSkill = () => {
  if (newSkill.value.name.trim() && newSkill.value.description.trim()) {
    const icons = ["🔥", "⚡", "🎯", "🚀", "💎", "⭐", "🌟", "💡", "🎪", "🎭", "🛠️", "⚙️"];
    skills.value.push({
      ...newSkill.value,
      icon: icons[Math.floor(Math.random() * icons.length)],
    });
    newSkill.value = {
      name: "",
      description: "",
      proficiency: 50,
      icon: "⭐",
      category: "Software Engineering",
    };
    showAddForm.value = false;
  }
};

const removeSkill = (index) => {
  skills.value.splice(index, 1);
  flippedIndex.value = null;
};

const shuffleSkills = () => {
  for (let i = skills.value.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [skills.value[i], skills.value[j]] = [skills.value[j], skills.value[i]];
  }
  flippedIndex.value = null;
};

const exportSkills = () => {
  if (import.meta.client) {
    const dataStr = JSON.stringify(skills.value, null, 2);
    const dataBlob = new Blob([dataStr], { type: "application/json" });
    const url = URL.createObjectURL(dataBlob);
    const link = document.createElement("a");
    link.href = url;
    link.download = "my-skills.json";
    link.click();
    URL.revokeObjectURL(url);
  }
};

// Theme Detection
onMounted(() => {
  if (import.meta.client && window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
    isDarkMode.value = true;
  }
});
</script>

<style lang="scss" scoped>
/* Minimal SCSS for transitions and white text enforcement */
.container-fluid {
  min-height: 100vh;
}

.card-header .card-title,
.card-header small {
  color: #ffffff !important;
  font-weight: bold;
}

/* Slide-down transition for add form */
.slide-down-enter-active,
.slide-down-leave-active {
  transition: all 0.3s ease;
}

.slide-down-enter-from,
.slide-down-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

/* Skill list transition */
.skill-list-move,
.skill-list-enter-active,
.skill-list-leave-active {
  transition: all 0.4s ease;
}

.skill-list-enter-from,
.skill-list-leave-to {
  opacity: 0;
  transform: scale(0.8);
}

.skill-list-leave-active {
  position: absolute;
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