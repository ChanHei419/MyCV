<template>
  <div class="page">
    <!-- Top Banner -->
    <div class="banner">
      <div class="banner-left">My Portfolio</div>
      <div class="banner-right">
        <NuxtLink to="/experience"><button>Experience</button></NuxtLink>
        <NuxtLink to="/education"><button>Education</button></NuxtLink>
        <NuxtLink to="/skills"><button>Skills</button></NuxtLink>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <!-- Left Description -->
      <div class="description">
        <h1>Hi, I am Helen Chan</h1>
        <p class="caption">You can generate any caption here</p>
      </div>

      <!-- Right Icon -->
      <div class="icon">
        https://via.placeholder.com/120
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
// No script logic needed
</script>

<style lang="scss" scoped>
.page {
  background-color: #87ceeb; // Sky blue
  font-family: Arial, sans-serif;
  padding: 0;
  min-height: 100vh;
  position: relative;
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

  .banner-left {
    font-weight: bold;
    font-size: 1rem;
  }

  .banner-right {
    display: flex;
    gap: 10px;

    button {
      background-color: rgba(0, 0, 0, 0.1);
      border: none;
      padding: 6px 12px;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s ease;

      &:hover {
        background-color: rgba(0, 0, 0, 0.2);
      }
    }
  }
}

// Main Content
.main-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 40px 20px;

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
}
</style>
