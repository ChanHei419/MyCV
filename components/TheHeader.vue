<template>
  <div
    :data-bs-theme="isDarkMode ? 'dark' : 'light'"
    :class="['container-fluid', 'gradient-bg', { 'bg-dark darkmode': isDarkMode, 'bg-light': !isDarkMode }]"
  >
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top bg-primary bg-gradient shadow-sm">
      <div class="container">
        <NuxtLink to="/" class="navbar-brand text-white fw-bold">
          <span class="code-icon">⚡</span> HeiChan
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
              <a
                href="https://github.com/ChanHei419"
                target="_blank"
                rel="noopener"
                class="nav-link text-white"
                >GitHub ↗</a
              >
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
  if (import.meta.client) {
    document.documentElement.setAttribute(
      "data-bs-theme",
      isDarkMode.value ? "dark" : "light"
    );
  }
};

const checkDarkMode = () => {
  if (import.meta.client) {
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

onMounted(() => {
  checkDarkMode();
});

watch(isDarkMode, () => {
  updateTheme();
});
</script>

<style lang="scss">
.navbar {
  z-index: 1030;
}

.darkmode {
  background-color: #212529;
  color: #ffffff;

  .nav-item:hover {
    background-color: var(--toggle-hover-bg, #9385d1);
    transform: scale(1.05);
  }
}

.nav-item:hover {
  border-radius: 6px;
  transform: scale(1.05);
  transition: all 0.2s ease;
}

.gradient-bg {
  background: linear-gradient(135deg, #4a90e2 0%, #63b3ed 100%);
  color: #fff;
  transition: background 0.3s ease;
}
</style>