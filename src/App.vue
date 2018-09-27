<template>
  <div id="app">
    <resume :data="data" />
  </div>
</template>

<script>
import Resume from "@/Resume.vue";
import data from "./data.json";

export default {
  data: function() {
    return { data };
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

  // Configure spacing.
  margin: 0;

  // Configure default fonts.
  font-size: 16px;
  font-family: "Ubuntu Mono", "Courier New", Courier, monospace;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  // prettier-ignore
  p, h1, h2, h3, h4, h5 {
    margin: 0;
    padding: 0;
  }

  background-color: darkgrey;
}
</style>
