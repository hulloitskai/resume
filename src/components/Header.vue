<template>
  <div class="header">
    <div class="panel left">
      <h1 class="name">{{ name }}</h1>
      <p class="blurb">{{ blurb }}</p>
    </div>
    <div class="panel spacer" />
    <div class="panel right">
      <p
        class="link" target="_blank" rel="noopener noreferrer"
        v-for="(link, index) in links"
        :key="link.url"
      >
        <a
          :href="link.url"
          :style="{ color: generateLinkColor(index) }"
          target="_blank"
        >
          {{ link.title }}
        </a>
      </p>
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
  data: () => ({ linkColors: ["#18bc72", "#56A1F7", "#D28EEE"] }),
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
  padding: 0 50px;
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
  color: #5d5d5d;
}

// prettier-ignore
.blurb { line-height: 115%; }

.panel {
  // prettier-ignore
  &.left { width: 330px; }
  // prettier-ignore
  &.spacer { flex: 1; }

  &.right {
    width: 250px;
    position: relative;
    top: 7px; // makes it feel more "balanced" with left side
    text-align: right;
  }
}

.link {
  margin-bottom: 4px;
  color: inherit;
  font-size: 16px;

  // prettier-ignore
  a { text-decoration: none; }
}
</style>
