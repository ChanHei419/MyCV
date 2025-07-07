<template>
  <div class="page">
    <h2>Education</h2>
    <h3>Degree - School Name</h3>
    <p><em>2016 - 2020</em></p>
    <NuxtLink to="/index" class="btn btn-primary btn-sm">Back</NuxtLink>
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
  }
}
</style>
