<template>
  <div id="app"><resume :data="data" /></div>
</template>

<script>
import Resume from "@/Resume.vue";

// App contains global styling and functions as a wrapper for the Resume
// component.
export default {
  data: () => ({ data: {} }),
  // Fetch JSON data upon creation.
  created: function() {
    fetch("data.json")
      .then(res => res.json())
      .then(data => (this.data = data));
  },
  components: { Resume },
};
</script>

<style lang="scss">
body {
  margin: 0;
  background-color: darkgrey;

  // Keep #app centered.
  // prettier-ignore
  > #app { margin: 0 auto; }

  // Configure default font styling.
  font-size: 11pt;
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

// Keep resume centered.
// prettier-ignore
#app > div { margin: 0 auto; }
</style>
