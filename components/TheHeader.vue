<template>
 <div
    :data-bs-theme="isDarkMode ? 'dark' : 'light'"
    :class="['container-fluid' , 'gradient-bg',
    { 'bg-dark darkmode': isDarkMode, 'bg-light': !isDarkMode 
      
    }]"
  >
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top bg-primary bg-gradient shadow-sm">
      <div class="container">
        <NuxtLink to="/" class="navbar-brand text-white fw-bold">
          <span class="code-icon">⚡</span> Helen Chan
        </NuxtLink>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
               <li class="nav-item">
              <NuxtLink to="/" class="nav-link text-white">Home</NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/about" class="nav-link text-white">About</NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/education" class="nav-link text-white">Education</NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/experience" class="nav-link text-white">Experience</NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/skills" class="nav-link text-white">Skills</NuxtLink>
            </li>
            <li class="nav-item">
               <NuxtLink to="/#projects" class="nav-link text-white">Projects</NuxtLink>
            </li>
            <li class="nav-item">
               <NuxtLink to="/#contact" class="nav-link text-white">Contact</NuxtLink>
            </li>
            <li class="nav-item">
             
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";

const isDarkMode = ref(false);

const updateTheme = () => {
  if (process.client) {
    document.documentElement.setAttribute("data-bs-theme", isDarkMode.value ? "dark" : "light");
    console.log("data-bs-theme set to:", document.documentElement.getAttribute("data-bs-theme"));
  }
};

const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
  if (process.client) {
    try {
      localStorage.setItem("darkMode", isDarkMode.value.toString());
      updateTheme();
    } catch (e) {
      console.error("Failed to save theme:", e);
    }
  }
};

const checkDarkMode = () => {
  if (process.client) {
    try {
      const savedMode = localStorage.getItem("darkMode");
      if (savedMode) {
        isDarkMode.value = savedMode === "true";
      }
      updateTheme();
    } catch (e) {
      console.error("Failed to load theme:", e);
    }
  }
};

const scrollToSection = (sectionId) => {
  if (process.client) {
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
  }
};

onMounted(() => {
  checkDarkMode();
});

watch(isDarkMode, () => {
  updateTheme();
});
</script>

<style lang="scss" >
.darkmode {
  background-color: #212529;
  color: #ffffff;

  .nav-item:hover {
  background-color: var(--toggle-hover-bg, #9385d1);
  transform: scale(1.05);
}

.gradient-bg {
  background: linear-gradient(135deg, #4a90e2 0%, #63b3ed 100%);
  color: #fff; /* Text color for contrast */
  min-height: 100vh; /* Ensure it covers the viewport */
  transition: background 0.3s ease; /* Smooth transition for theme changes */
}

/* Alternative gradient: Purple to Blue (Bootstrap-like) */
.gradient-bg-alt1 {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  min-height: 100vh;
  transition: background 0.3s ease;
}

/* Alternative gradient: Green to Teal */
.gradient-bg-alt2 {
  background: linear-gradient(135deg, #34d399 0%, #2b6cb0 100%);
  color: #fff;
  min-height: 100vh;
  transition: background 0.3s ease;
}

/* Dark mode gradient */
[data-theme="dark"] .gradient-bg {
  background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
  color: #e2e8f0;
}

/* Apply to body or specific container */
body.gradient-bg,
.container.gradient-bg {
  padding: 20px; /* Optional padding for content */
}

/* Ensure text readability on gradients */
.gradient-bg h1,
.gradient-bg h2,
.gradient-bg p {
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2); /* Subtle shadow for text contrast */
}

}
</style>