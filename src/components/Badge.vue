<template>
  <a class="footer-badge" :href="source.url">
    <i class="fas fa-code" />
    <p>{{ source.title }}</p>
  </a>
</template>

<script>
export default {
  props: {
    source: { type: String, default: "" }
  }
};
</script>

<style lang="scss" scoped>
.footer-badge {
  padding: 5px 6px;
  border-radius: 5px;
  display: flex;
  justify-content: center;
  font-size: 15px;

  background-color: #eeeeee;
  color: #707070;
}

a {
  text-decoration: none;
  color: inherit;
}

i {
  margin-right: 6px;
  color: #888888;
}
</style>
