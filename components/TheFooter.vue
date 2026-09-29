<template>
  <footer class="bg-dark text-white py-4">
    <div class="container">
      <div class="row">
        <div class="col text-center">
          <p class="mb-2">
            &copy; {{ new Date().getFullYear() }} HeiChan · Chan Hei Lun. All
            rights reserved.
          </p>
          <p class="mb-0">
            <a
              href="https://github.com/ChanHei419"
              target="_blank"
              rel="noopener"
              class="text-white me-3"
              >GitHub</a
            >
            <a
              href="https://www.linkedin.com/in/helon-chan/"
              target="_blank"
              rel="noopener"
              class="text-white me-3"
              >LinkedIn</a
            >
            <a href="mailto:cccheilllun4129@gmail.com" class="text-white"
              >Email</a
            >
          </p>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
// Static footer — links live in the template.
</script>

<style lang="scss" scoped>
footer {
  position: relative;
  z-index: 1;
}
</style>