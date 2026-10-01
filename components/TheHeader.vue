<template>
  <header class="site-header">
    <nav class="navbar navbar-expand-lg">
      <div class="container">
        <NuxtLink to="/" class="navbar-brand">
          <span class="brand-mark">
            <i class="fa-solid fa-code"></i>
          </span>
          <span class="brand-text">HeiChan</span>
        </NuxtLink>

        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#siteNav"
          aria-controls="siteNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <i class="fa-solid fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="siteNav">
          <ul class="navbar-nav ms-auto align-items-lg-center">
            <li class="nav-item">
              <NuxtLink to="/" class="nav-link">
                <i class="fa-solid fa-house"></i> Home
              </NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/about" class="nav-link">
                <i class="fa-solid fa-user"></i> About
              </NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/education" class="nav-link">
                <i class="fa-solid fa-graduation-cap"></i> Education
              </NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/experience" class="nav-link">
                <i class="fa-solid fa-briefcase"></i> Experience
              </NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/skills" class="nav-link">
                <i class="fa-solid fa-layer-group"></i> Skills
              </NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/#projects" class="nav-link">
                <i class="fa-solid fa-diagram-project"></i> Projects
              </NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink to="/#contact" class="nav-link">
                <i class="fa-solid fa-envelope"></i> Contact
              </NuxtLink>
            </li>
            <li class="nav-item ms-lg-3 mt-2 mt-lg-0">
              <a
                href="https://github.com/ChanHei419"
                target="_blank"
                rel="noopener"
                class="nav-link github-link"
              >
                <i class="fa-brands fa-github"></i> GitHub
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup>
</script>

<style lang="scss" scoped>
.site-header {
  position: sticky;
  top: 0;
  z-index: 1030;
}

.navbar {
  background: rgba(7, 11, 24, 0.72);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border-bottom: 1px solid var(--border-soft);
  padding: 0.7rem 0;
}

html[data-theme="light"] .navbar {
  background: rgba(255, 255, 255, 0.8);
}

.navbar-brand {
  display: inline-flex;
  align-items: center;
  gap: 0.6rem;
  font-weight: 800;
  letter-spacing: -0.01em;
}

.brand-mark {
  width: 38px;
  height: 38px;
  border-radius: 11px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  background: var(--gradient-main);
  box-shadow: 0 8px 20px rgba(59, 130, 246, 0.35);
}

.brand-text {
  background: var(--gradient-main);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  font-size: 1.15rem;
}

.navbar-toggler {
  border: 1px solid var(--border-soft);
  color: var(--text-primary);
  border-radius: 10px;
  padding: 0.35rem 0.6rem;
}

.navbar-toggler:focus {
  box-shadow: none;
}

.nav-link {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  color: var(--text-muted) !important;
  font-weight: 500;
  font-size: 0.92rem;
  padding: 0.5rem 0.75rem !important;
  border-radius: 10px;
  transition: color 0.2s ease, background 0.2s ease;
}

.nav-link i {
  font-size: 0.82rem;
  opacity: 0.85;
}

.nav-link:hover {
  color: var(--text-primary) !important;
  background: rgba(139, 92, 246, 0.12);
}

.nav-link.router-link-active {
  color: var(--text-primary) !important;
  background: rgba(139, 92, 246, 0.16);
}

.github-link {
  border: 1px solid var(--border-soft);
}

.github-link:hover {
  border-color: var(--border-bright);
}
</style>
