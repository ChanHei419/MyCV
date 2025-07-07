<template>
  <div class="page">
    <!-- Background Clouds -->
    <div class="clouds">
      <div class="cloud cloud1"></div>
      <div class="cloud cloud2"></div>
      <div class="cloud cloud3"></div>
    </div>

    <!-- Top Banner -->
    <div class="banner">
      <div class="banner-left">My Portfolio</div>
      <div class="banner-right">
        <NuxtLink to="/experience"><button class="nav-btn">Experience</button></NuxtLink>
        <NuxtLink to="/education"><button class="nav-btn">Education</button></NuxtLink>
        <NuxtLink to="/skills"><button class="nav-btn">Skills</button></NuxtLink>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <!-- Left Description -->
      <div class="description">
        <h1>Hi, I am Helen Chan</h1>
        <p class="caption">You can generate any caption here</p>
        <button @click="showFunFact" class="fun-btn">Discover a Fun Fact!</button>
        <transition name="fade">
          <p v-if="currentFact" class="fun-fact">{{ currentFact }}</p>
        </transition>
      </div>

      <!-- Right Icon -->
      <div class="icon">
        <img src="https://via.placeholder.com/120" alt="Profile Icon">
      </div>
    </div>

    <!-- Experience Section -->
    <section class="experience">
      <h2>Experience</h2>
      <h3>Intern - Company Name</h3>
      <p><em>Jan 2020 - Present</em></p>
      <ul>
        <li>Responsibility or achievement 1</li>
        <li>Responsibility or achievement 2</li>
      </ul>
    </section>

    <!-- Contact Section -->
    <div class="contact">
      <p>Email: helenchan@email.com</p>
      <p>Phone: (123) 456-7890</p>
      <p>Location: City, Country</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Fun facts array (customize these with your own facts)
const funFacts = [
  "Helen once coded for 24 hours straight!",
  "Helen loves solving complex algorithms.",
  "Helen is passionate about web development."
]
const currentFact = ref('')

// Function to show a random fun fact
const showFunFact = () => {
  const randomIndex = Math.floor(Math.random() * funFacts.length)
  currentFact.value = funFacts[randomIndex]
}
</script>

<style lang="scss" scoped>
.page {
  background-color: #87ceeb; // Sky blue
  font-family: Arial, sans-serif;
  padding: 0;
  min-height: 100vh;
  position: relative;
  overflow: hidden; // To contain clouds within the page
}

// Clouds Background
.clouds {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: 0;
}

.cloud {
  position: absolute;
  background: white;
  border-radius: 50%;
  opacity: 0.7;
  animation: drift linear infinite;
}

.cloud1 {
  width: 100px;
  height: 60px;
  top: 10%;
  left: -100px;
  animation-duration: 20s;
}

.cloud2 {
  width: 150px;
  height: 90px;
  top: 30%;
  left: -150px;
  animation-duration: 25s;
}

.cloud3 {
  width: 80px;
  height: 50px;
  top: 50%;
  left: -80px;
  animation-duration: 30s;
}

@keyframes drift {
  from {
    transform: translateX(0);
  }
  to {
    transform: translateX(100vw);
  }
}

// Banner
.banner {
  background-color: white;
  height: 45px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: relative;
  z-index: 1;

  .banner-left {
    font-weight: bold;
    font-size: 1rem;
  }

  .banner-right {
    display: flex;
    gap: 10px;
  }
}

// Navigation Buttons
.nav-btn {
  background-color: rgba(0, 0, 0, 0.1);
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;

  &:hover {
    background-color: rgba(0, 0, 0, 0.2);
    transform: scale(1.05);
  }
}

// Main Content
.main-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 40px 20px;
  position: relative;
  z-index: 1;

  .description {
    flex: 1;

    h1 {
      font-size: 1.8rem;
      margin-bottom: 0.5rem;
    }

    .caption {
      font-size: 0.85rem;
      color: #333;
    }

    .fun-btn {
      margin-top: 10px;
      padding: 8px 16px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s ease;

      &:hover {
        background-color: #0056b3;
      }
    }

    .fun-fact {
      margin-top: 10px;
      font-style: italic;
      color: #555;
    }
  }

  .icon {
    flex: 0;
    img {
      border-radius: 50%;
      width: 120px;
      height: 120px;
      object-fit: cover;
    }
  }
}

// Experience Section
.experience {
  padding: 20px;
  position: relative;
  z-index: 1;

  h2 {
    color: #2c3e50;
    margin-bottom: 0.5rem;
  }

  h3 {
    margin-top: 1rem;
    font-weight: 600;
  }

  p {
    font-size: 0.95em;
    color: #555;
    margin-bottom: 0.5rem;
  }

  ul {
    padding-left: 1.2rem;
    list-style-type: disc;

    li {
      margin-bottom: 0.5rem;
    }
  }
}

// Contact Section
.contact {
  position: absolute;
  bottom: 20px;
  left: 20px;
  display: flex;
  gap: 20px;
  font-size: 0.9rem;
  color: #fff;
  z-index: 1;
}

// Fade Transition for Fun Fact
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>