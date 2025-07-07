<template>
  <div class="page">
    <h2>Skills</h2>
    <ul>
      <li>Skill 1</li>
      <li>Skill 2</li>
      <li>Skill 3</li>
    </ul>
    <NuxtLink to="/index" >Back</NuxtLink>
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

  ul {
    padding-left: 1.2rem;
    list-style-type: disc;

    li {
      margin-bottom: 0.5rem;
    }
  }
}
</style>
