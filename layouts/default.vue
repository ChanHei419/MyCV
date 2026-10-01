<template>
  <div class="site-shell">
    <!-- Global ambient background: aurora + grid + particles -->
    <div class="global-bg" aria-hidden="true">
      <div class="aurora aurora-one"></div>
      <div class="aurora aurora-two"></div>
      <div class="aurora aurora-three"></div>
      <div class="grid-overlay"></div>
      <span
        v-for="particle in particles"
        :key="particle.id"
        class="particle"
        :style="{
          left: particle.left + '%',
          top: particle.top + '%',
          width: particle.size + 'px',
          height: particle.size + 'px',
          animationDuration: particle.duration + 's',
          animationDelay: particle.delay + 's',
        }"
      ></span>
    </div>

    <TheHeader />
    <slot />
    <TheFooter />

    <button
      v-show="showBackToTop"
      class="back-to-top"
      aria-label="Back to top"
      @click="scrollToTop"
    >
      <i class="fa-solid fa-arrow-up"></i>
    </button>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from "vue";

const { initTheme } = useDarkMode();

const particles = ref([]);
const showBackToTop = ref(false);

const buildParticles = () => {
  particles.value = Array.from({ length: 28 }, (_, id) => ({
    id,
    left: Math.random() * 100,
    top: Math.random() * 100,
    size: 2 + Math.random() * 4,
    duration: 10 + Math.random() * 16,
    delay: -Math.random() * 26,
  }));
};

const handleScroll = () => {
  showBackToTop.value = window.scrollY > 600;
};

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
};

onMounted(() => {
  initTheme();
  buildParticles();
  window.addEventListener("scroll", handleScroll, { passive: true });
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});
</script>

<style>
/* ---------- Global design system ---------- */

:root {
  --bg-0: #070b18;
  --bg-1: #0d1226;
  --bg-2: #140f2b;
  --surface: rgba(15, 22, 44, 0.62);
  --surface-strong: rgba(15, 22, 44, 0.86);
  --border-soft: rgba(148, 163, 184, 0.18);
  --border-bright: rgba(125, 211, 252, 0.45);
  --text-primary: #e5e7eb;
  --text-muted: #94a3b8;
  --accent-violet: #8b5cf6;
  --accent-blue: #3b82f6;
  --accent-cyan: #22d3ee;
  --gradient-main: linear-gradient(120deg, #8b5cf6, #3b82f6 55%, #22d3ee);
  --shadow-card: 0 18px 40px rgba(2, 6, 23, 0.55);
}

html[data-theme="light"] {
  --surface: rgba(255, 255, 255, 0.82);
  --surface-strong: rgba(255, 255, 255, 0.94);
  --border-soft: rgba(15, 23, 42, 0.12);
  --text-primary: #0f172a;
  --text-muted: #64748b;
  --shadow-card: 0 18px 40px rgba(15, 23, 42, 0.12);
}

html {
  scroll-behavior: smooth;
}

body {
  margin: 0;
  font-family: "Inter", system-ui, -apple-system, "Segoe UI", sans-serif;
  background-color: var(--bg-0);
  color: var(--text-primary);
  -webkit-font-smoothing: antialiased;
}

html[data-theme="light"] body {
  background-color: #eef2ff;
}

::selection {
  background: rgba(139, 92, 246, 0.4);
  color: #ffffff;
}

::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: rgba(15, 23, 42, 0.6);
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(180deg, #8b5cf6, #22d3ee);
  border-radius: 8px;
}

/* ---------- Ambient background ---------- */

.site-shell {
  min-height: 100vh;
  position: relative;
}

.global-bg {
  position: fixed;
  inset: 0;
  overflow: hidden;
  z-index: 0;
  background:
    radial-gradient(1100px 620px at 12% 8%, rgba(124, 58, 237, 0.3), transparent 60%),
    radial-gradient(900px 540px at 88% 16%, rgba(37, 99, 235, 0.26), transparent 62%),
    radial-gradient(820px 620px at 50% 104%, rgba(14, 165, 233, 0.16), transparent 65%),
    linear-gradient(160deg, var(--bg-0) 0%, var(--bg-1) 55%, var(--bg-2) 100%);
  transition: background 0.6s ease;
}

html[data-theme="light"] .global-bg {
  background:
    radial-gradient(1100px 620px at 12% 8%, rgba(139, 92, 246, 0.18), transparent 60%),
    radial-gradient(900px 540px at 88% 16%, rgba(59, 130, 246, 0.16), transparent 62%),
    linear-gradient(160deg, #eef2ff 0%, #e0e7ff 60%, #ede9fe 100%);
}

.aurora {
  position: absolute;
  border-radius: 50%;
  filter: blur(90px);
  opacity: 0.5;
  animation: aurora-drift 22s ease-in-out infinite alternate;
}

.aurora-one {
  width: 520px;
  height: 520px;
  top: -140px;
  left: -120px;
  background: radial-gradient(circle, rgba(139, 92, 246, 0.55), transparent 65%);
}

.aurora-two {
  width: 620px;
  height: 620px;
  top: 20%;
  right: -180px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.45), transparent 65%);
  animation-delay: -7s;
}

.aurora-three {
  width: 460px;
  height: 460px;
  bottom: -160px;
  left: 32%;
  background: radial-gradient(circle, rgba(34, 211, 238, 0.35), transparent 65%);
  animation-delay: -14s;
}

@keyframes aurora-drift {
  0% {
    transform: translate3d(0, 0, 0) scale(1);
  }
  50% {
    transform: translate3d(40px, -30px, 0) scale(1.08);
  }
  100% {
    transform: translate3d(-30px, 28px, 0) scale(0.96);
  }
}

.grid-overlay {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(148, 163, 184, 0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(148, 163, 184, 0.06) 1px, transparent 1px);
  background-size: 48px 48px;
  mask-image: radial-gradient(circle at 50% 30%, black 30%, transparent 78%);
  -webkit-mask-image: radial-gradient(circle at 50% 30%, black 30%, transparent 78%);
}

.particle {
  position: absolute;
  border-radius: 50%;
  background: rgba(199, 210, 254, 0.45);
  box-shadow: 0 0 10px rgba(125, 211, 252, 0.45);
  animation-name: particle-drift;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
}

@keyframes particle-drift {
  0% {
    transform: translateY(0) scale(1);
    opacity: 0.15;
  }
  50% {
    opacity: 0.8;
  }
  100% {
    transform: translateY(-48px) scale(1.25);
    opacity: 0.1;
  }
}

/* ---------- Shared components ---------- */

.section-shell {
  position: relative;
  z-index: 1;
  padding: 5rem 0;
}

.section-kicker {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  text-transform: uppercase;
  letter-spacing: 0.22em;
  font-size: 0.74rem;
  font-weight: 600;
  color: var(--accent-cyan);
  margin-bottom: 0.75rem;
}

.section-title {
  font-size: clamp(1.7rem, 3vw, 2.4rem);
  font-weight: 800;
  letter-spacing: -0.01em;
  margin-bottom: 0.75rem;
}

.gradient-text {
  background: var(--gradient-main);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.section-lede {
  color: var(--text-muted);
  max-width: 640px;
}

.glass-card {
  background: var(--surface);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid var(--border-soft);
  border-radius: 18px;
  color: var(--text-primary);
  transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
}

.glass-card:hover {
  transform: translateY(-4px);
  border-color: var(--border-bright);
  box-shadow: var(--shadow-card);
}

.icon-badge {
  width: 52px;
  height: 52px;
  border-radius: 14px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
  color: #ffffff;
  background: var(--gradient-main);
  box-shadow: 0 10px 24px rgba(59, 130, 246, 0.35);
}

.icon-badge.subtle {
  background: rgba(139, 92, 246, 0.14);
  color: var(--accent-violet);
  box-shadow: none;
}

.chip {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.32rem 0.8rem;
  border-radius: 999px;
  border: 1px solid var(--border-soft);
  background: rgba(139, 92, 246, 0.1);
  color: var(--text-primary);
  font-size: 0.8rem;
  font-weight: 500;
}

.chip i {
  color: var(--accent-cyan);
}

.stat-tile {
  text-align: center;
  padding: 1.4rem 1rem;
}

.stat-tile .stat-value {
  font-size: 2rem;
  font-weight: 800;
  background: var(--gradient-main);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  line-height: 1.1;
}

.stat-tile .stat-label {
  margin-top: 0.35rem;
  font-size: 0.78rem;
  text-transform: uppercase;
  letter-spacing: 0.14em;
  color: var(--text-muted);
}

/* Buttons */
.btn {
  border-radius: 12px;
  font-weight: 600;
  letter-spacing: 0.01em;
}

.btn-primary,
.btn-gradient {
  background: var(--gradient-main);
  border: none;
  color: #ffffff;
  box-shadow: 0 10px 26px rgba(76, 29, 149, 0.35);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.btn-primary:hover,
.btn-gradient:hover {
  color: #ffffff;
  transform: translateY(-2px);
  box-shadow: 0 14px 32px rgba(56, 189, 248, 0.35);
}

.btn-outline-light:hover {
  color: var(--bg-0);
}

/* Reveal on scroll */
.reveal-init [data-reveal] {
  opacity: 0;
  transform: translateY(26px);
  transition: opacity 0.7s ease, transform 0.7s ease;
}

.reveal-init [data-reveal].is-visible {
  opacity: 1;
  transform: none;
}

/* Back to top */
.back-to-top {
  position: fixed;
  right: 22px;
  bottom: 86px;
  width: 44px;
  height: 44px;
  border-radius: 12px;
  border: 1px solid var(--border-soft);
  background: var(--surface-strong);
  color: var(--text-primary);
  backdrop-filter: blur(12px);
  z-index: 1040;
  transition: transform 0.2s ease, border-color 0.2s ease;
}

.back-to-top:hover {
  transform: translateY(-3px);
  border-color: var(--border-bright);
}

@media (prefers-reduced-motion: reduce) {
  .aurora,
  .particle {
    animation: none !important;
  }

  .reveal-init [data-reveal] {
    opacity: 1;
    transform: none;
    transition: none;
  }
}
</style>
