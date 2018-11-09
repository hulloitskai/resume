<template>
  <div class="header">
    <div class="panel left">
      <h1 class="name">{{ name }}</h1>
      <p class="blurb">{{ blurb }}</p>
    </div>
    <div class="panel spacer" />
    <div class="panel right">
      <a
        class="link"
        v-for="(link, i) in links"
        :key="link.url"
        :style="{ color: generateLinkColor(i) }"
        :href="link.url"
        target="_blank"
        rel="noopener noreferrer"
      >
        <p>{{ link.title }}</p>
        <i :class="link.icon" />
      </a>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    name: { type: String, default: "" },
    blurb: { type: String, default: "" },
    links: { type: Array, default: () => [] }
  },
  data: () => ({ linkColors: ["#18BA72", "#5691F0", "#c063dc"] }),
  methods: {
    generateLinkColor: function(index) {
      return this.linkColors[index % 3];
    }
  }
};
</script>

<style lang="scss" scoped>
.header {
  height: 160px;
  padding: 0 45px;
  display: flex;
  align-items: center;

  background-color: #f5f5f5;
  color: #7a7a7a;
}

.name {
  margin-bottom: 5px;

  letter-spacing: 1px;
  font-weight: bold;
  font-size: 33px;
  color: #3f3f3f;
}

// prettier-ignore
.blurb { line-height: 115%; }

.panel {
  // prettier-ignore
  &.left { width: 330px; }
  // prettier-ignore
  &.spacer { flex: 1; }

  &.right {
    width: 275px;
    position: relative;
    top: 7px; // makes it feel more "balanced" with left side
  }
}

.link {
  display: flex;
  margin-bottom: 4px;
  align-items: center;
  justify-content: flex-end;

  text-decoration: none;

  p {
    font-size: 16px;
    color: inherit;
  }

  i {
    display: flex;
    justify-content: center;
    width: 27px;
  }
}
</style>
