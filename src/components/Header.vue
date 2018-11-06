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
        <a :href="link.url" :style="{ color: generateLinkColor(index) }">
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
div.header {
  height: 160px;
  padding: 0 50px;
  display: flex;
  align-items: center;

  background-color: #f5f5f5;
  color: #7a7a7a;
}

h1.name {
  margin-bottom: 5px;

  color: #5d5d5d;
  font-weight: bold;
  font-size: 33px;
}

// prettier-ignore
p.blurb { line-height: 115%; }

div.panel {
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

p.link {
  margin-bottom: 4px;
  color: inherit;
  font-size: 16px;

  // prettier-ignore
  a { text-decoration: none; }
}
</style>
