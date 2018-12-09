<template>
  <div :class="['section', title.toLowerCase()]">
    <h2 class="title">{{ title }}</h2>
    <div class="content"><slot /></div>
  </div>
</template>

<script>
export default {
  props: {
    title: { type: String, default: "" },
  },
};
</script>

<style lang="scss" scoped>
@import "@/mixins/_colors.scss";

h2.title {
  margin-bottom: 5px;

  letter-spacing: 1px;
  font-size: 17pt;
  font-weight: bold;
  color: #444444;
}

// prettier-ignore
h3, h4, h5 {
  font-family: "Source Code Pro", "Courier New", Courier, monospace;
  letter-spacing: -0.5px;
}

// prettier-ignore
h3 { color: #4d4d4d; }
// prettier-ignore
h4 { color: #909090; }

// prettier-ignore
/deep/ span {
  &.tech { color: $tech-color-dark !important; }
  &.lib { color: $lib-color-dark !important; }
  &.lang { color: $lang-color-dark !important; }
}
</style>
