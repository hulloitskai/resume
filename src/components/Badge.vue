<template>
  <a class="footer-badge" :href="source.url">
    <i class="fas fa-code" />
    <p>{{ source.title }}</p>
  </a>
</template>

<script>
export default {
  props: {
    source: { type: Object, default: () => ({}) },
  },
};
</script>

<style lang="scss" scoped>
$color: #888888;

.footer-badge {
  padding: 0.4em 0.5em;
  border-radius: 0.3em;
  display: flex;
  align-items: center;

  font-size: 10pt;
  background-color: #f0f0f0;
  color: $color;

  // prettier-ignore
  .emphasis { font-weight: 600; }
}

a {
  text-decoration: none;
  color: inherit;
}

i {
  margin-right: 0.5em;
  color: lighten($color, 7%);
}
</style>
