<template>
  <div id="app">
    <resume :data="data" />
  </div>
</template>

<script>
import Resume from "@/Resume.vue";

const { BASE_URL: baseURL } = process.env;

// App contains global styling and functions as a wrapper for the Resume
// component.
export default {
  data: () => ({ data: {} }),
  // Fetch JSON data upon creation.
  created: function() {
    fetch(`${baseURL}data.json`)
      .then(res => res.json())
      .then(data => (this.data = data));
  },
  components: { Resume }
};
</script>

<style lang="scss">
body {
  // Display resume in center of screen.
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0;
  background-color: darkgrey;

  // Configure default font styling.
  font-size: 16px;
  font-family: "Ubuntu Mono", "Courier New", Courier, monospace;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

  // Normalize spacing around text.
  // prettier-ignore
  p, h1, h2, h3, h4, h5 {
    margin: 0;
    padding: 0;
  }
}
</style>
