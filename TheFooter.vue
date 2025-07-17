<template>
    <footer class="bg-dark text-white py-4">
      <div class="container">
        <div class="row">
          <div class="col text-center">
            <!-- <div class="btn btn-primary" @click="handleClick">button</div> -->
            <p>&copy; {{ new Date().getFullYear() }} My Website. All rights reserved.</p>
            <p>
              Follow us on
              <a href="https://twitter.com" target="_blank" class="text-white">Twitter</a>,
              <a href="https://facebook.com" target="_blank" class="text-white">Facebook</a>,
              and
              <a href="https://instagram.com" target="_blank" class="text-white">Instagram</a>.
            </p>
          </div>
        </div>
      </div>

    </footer>
</template>

<script setup>
const data = reactive({
  counter:0
});

const handleClick = () => {  
  data.counter++;
    // console.log("Button clicked! Counter:", data.counter);
};
</script>

<style lang="scss" scoped>

</style>