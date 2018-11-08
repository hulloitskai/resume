<template>
  <div :class="['section', title.toLowerCase()]">
    <h2 class="title">{{ title }}</h2>
    <div class="content"><slot /></div>
  </div>
</template>

<script>
export default {
  props: {
    title: { type: String, default: "" }
  }
};
</script>

<style lang="scss" scoped>
h2.title {
  margin-bottom: 2px;

  letter-spacing: 1px;
  font-size: 23px;
  font-weight: bold;
  color: #7b8bdb;
}

// prettier-ignore
h3, h4, h5 {
  font-family: "Source Code Pro", "Courier New", Courier, monospace;
  letter-spacing: -0.5px;
}
// prettier-ignore
h3 { color: #585858; }
// prettier-ignore
h4 { color: #909090; }
</style>
