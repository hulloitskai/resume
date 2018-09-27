<template>
  <div class="header">
    <div class="panel left">
      <h1 class="name">{{ name }}</h1>
      <p class="blurb">{{ blurb }}</p>
    </div>
    <div class="panel spacer" />
    <div class="panel right">
      <a
        class="link" target="_blank" rel="noopener noreferrer"
        v-for="(link, index) in links"
        :href="link.url" :key="link.url"
      >
        <p :style="{ color: generateLinkColor(index) }">
          {{ link.title }}
        </p>
      </a>
    </div>
  </div>
</template>

<script>
export default {
  props: { name: String, blurb: String, links: Array },
  data: function() {
    return {
      linkColors: ["#1BCA7A", "#56A1F7", "#D28EEE"]
    };
  },
  methods: {
    generateLinkColor: function(index) {
      return this.linkColors[index % 3];
    }
  }
};
</script>

<style lang="scss" scoped>
div.header {
  height: 175px;
  display: flex;
  align-items: center;
  padding: 0 50px;

  background-color: #f6f6f6;
  color: #7e7e7e;
}

h1.name {
  margin-bottom: 5px;

  color: #5d5d5d;
  font-weight: bold;
  font-size: 33px;
}

p.blurb {
  line-height: 115%;
}

div.panel {
  // prettier-ignore
  &.left { width: 330px; }

  // prettier-ignore
  &.spacer { flex: 1; }

  &.right {
    width: 250px;
    position: relative; // makes it feel more "balanced" with left side
    top: 7px;

    text-align: right;
  }
}

a.link {
  color: inherit;
  text-decoration: none;

  p {
    margin-bottom: 4px;
    font-size: 17px;
  }
}
</style>
