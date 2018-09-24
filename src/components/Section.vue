<template>
  <div :class="['section', title.toLowerCase()]">
    <h2 class="title">{{ title }}</h2>
    <div class="content"><slot /></div>
  </div>
</template>

<script>
export default {
  props: {
    title: String
  }
};
</script>

<style lang="scss" scoped>
h2.title {
  margin-bottom: 7px;

  font-size: 18px;
  font-weight: bold;
  color: #7b8bdb;
}
</style>
