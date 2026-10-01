<template>
  <footer class="site-footer">
    <div class="container">
      <div class="row g-4 align-items-start">
        <div class="col-lg-5">
          <div class="footer-brand">
            <span class="brand-mark">
              <i class="fa-solid fa-code"></i>
            </span>
            <span class="brand-text">HeiChan</span>
          </div>
          <p class="footer-tagline">
            BEng in Information Engineering at The Chinese University of Hong
            Kong. Building across software engineering, cloud &amp; AI
            automation, and data.
          </p>
        </div>

        <div class="col-6 col-lg-3">
          <h6 class="footer-heading">Explore</h6>
          <ul class="footer-links">
            <li>
              <NuxtLink to="/about">
                <i class="fa-solid fa-chevron-right"></i> About
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/education">
                <i class="fa-solid fa-chevron-right"></i> Education
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/experience">
                <i class="fa-solid fa-chevron-right"></i> Experience
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/skills">
                <i class="fa-solid fa-chevron-right"></i> Skills
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/#projects">
                <i class="fa-solid fa-chevron-right"></i> Projects
              </NuxtLink>
            </li>
          </ul>
        </div>

        <div class="col-6 col-lg-4">
          <h6 class="footer-heading">Connect</h6>
          <ul class="footer-links">
            <li>
              <a href="https://github.com/ChanHei419" target="_blank" rel="noopener">
                <i class="fa-brands fa-github"></i> github.com/ChanHei419
              </a>
            </li>
            <li>
              <a
                href="https://www.linkedin.com/in/helon-chan/"
                target="_blank"
                rel="noopener"
              >
                <i class="fa-brands fa-linkedin"></i> linkedin.com/in/helon-chan
              </a>
            </li>
            <li>
              <a href="mailto:cccheilllun419@gmail.com">
                <i class="fa-solid fa-envelope"></i> cccheilllun419@gmail.com
              </a>
            </li>
            <li>
              <span>
                <i class="fa-solid fa-location-dot"></i> Hong Kong
              </span>
            </li>
          </ul>
        </div>
      </div>

      <hr class="footer-divider" />

      <div
        class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2"
      >
        <p class="mb-0 footer-copy">
          &copy; {{ new Date().getFullYear() }} HeiChan · Chan Hei Lun. All
          rights reserved.
        </p>
        <p class="mb-0 footer-built">
          Built with Nuxt 3, TypeScript-ready Vue 3, and SCSS
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup>
</script>

<style lang="scss" scoped>
.site-footer {
  position: relative;
  z-index: 1;
  padding: 3.5rem 0 2rem;
  border-top: 1px solid var(--border-soft);
  background: rgba(7, 11, 24, 0.55);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
}

html[data-theme="light"] .site-footer {
  background: rgba(255, 255, 255, 0.6);
}

.footer-brand {
  display: inline-flex;
  align-items: center;
  gap: 0.6rem;
  margin-bottom: 0.75rem;
}

.brand-mark {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  background: var(--gradient-main);
}

.brand-text {
  font-weight: 800;
  font-size: 1.1rem;
  background: var(--gradient-main);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.footer-tagline {
  color: var(--text-muted);
  font-size: 0.92rem;
  max-width: 420px;
  margin-bottom: 0;
}

.footer-heading {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.74rem;
  font-weight: 700;
  color: var(--accent-cyan);
  margin-bottom: 1rem;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 0.55rem;
}

.footer-links a,
.footer-links span {
  color: var(--text-muted);
  text-decoration: none;
  font-size: 0.9rem;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: var(--text-primary);
}

.footer-links i {
  font-size: 0.8rem;
  color: var(--accent-violet);
  width: 14px;
  text-align: center;
}

.footer-divider {
  border-color: var(--border-soft);
  margin: 2rem 0 1.25rem;
  opacity: 1;
}

.footer-copy,
.footer-built {
  color: var(--text-muted);
  font-size: 0.84rem;
}
</style>
