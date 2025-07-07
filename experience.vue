<template>
  <div class="page">
    <h2>Experience</h2>
    <h3>Intern - Company Name</h3>
    <p><em>Jan 2020 - Present</em></p>
        <NuxtLink to="/index" class="btn btn-primary btn-sm">Back</NuxtLink>
    <ul>
      <li>Responsibility or achievement 1</li>
      <li>Responsibility or achievement 2</li>
    </ul>
  </div>
</template>

<script setup>
// No script logic needed for static content
</script>

<style lang="scss" scoped>
.page {
  padding: 40px;
  font-family: Arial, sans-serif;

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
</style>
