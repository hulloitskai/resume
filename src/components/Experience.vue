<template>
  <resume-section title="EXPERIENCE">
    <div class="item" v-for="(exp, i) in data" :key="i">
      <h3 class="title">{{ exp.title }}</h3>
      <h4 class="timestamp">{{ exp.timestamp }}</h4>
      <a v-if="exp.link" :href="exp.link.url">
        <h4 class="link">{{ exp.link.title }}</h4>
      </a>
      <ul class="points">
        <li v-for="(point, j) in points[i]" :key="j" v-html="point" />
      </ul>
    </div>
  </resume-section>
</template>

<script>
import Section from "./Section.vue";
import emphParse from "@/utils/emphParse.js";

export default {
  props: {
    data: { type: Array, default: () => [] },
  },
  computed: {
    points: function() {
      return this.data.map(({ points }) => points.map(emphParse));
    },
  },
  components: { "resume-section": Section },
};
</script>

<style lang="scss" scoped>
// prettier-ignore
.item { margin-bottom: 1.35em; }

.title {
  font-weight: 600;
  font-size: 12pt;
}

a {
  display: flex;
  text-decoration: none;
}

h4 {
  font-weight: 500;
  font-size: 10.5pt;

  &.link {
    padding: 0.2em 0.4em;
    margin-bottom: 0.3em;
    border-radius: 0.25em;

    font-size: 9.5pt;
    background-color: #f1f1f1;
    color: grey;
  }
}

.points {
  margin: 0.1em 0 1em 0;
  padding-left: 1.5em;

  color: #4d4d4d;
  font-size: 11.25pt;

  li {
    margin-top: 0.3em;
    margin-bottom: 0.4em;
    list-style-type: none;

    /deep/ p {
      display: inline;

      // prettier-ignore
      span.emphasis { color: rgb(0, 0, 0); }
    }

    &::before {
      content: "– ";
      margin-left: -1em;
    }
  }
}
</style>
