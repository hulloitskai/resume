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
    data: { type: Array, default: () => [] }
  },
  computed: {
    points: function() {
      return this.data.map(({ points }) => points.map(emphParse));
    }
  },
  components: { "resume-section": Section }
};
</script>

<style lang="scss" scoped>
// prettier-ignore
.item { margin-bottom: 20px; }

.title {
  font-weight: 600;
  font-size: 16px;
}

a {
  display: flex;
  text-decoration: none;
}

h4 {
  font-weight: 500;
  font-size: 14px;

  &.link {
    padding: 1px 5px;
    border-radius: 3px;

    font-size: 13px;
    background-color: #f0f0f0;
    color: grey;
  }
}

.points {
  margin: 5px 0 20px 0;
  padding-left: 20px;

  color: #4d4d4d;
  font-size: 15px;

  li {
    margin-top: 5px;
    margin-bottom: 7px;
    list-style-type: none;

    /deep/ p {
      display: inline;

      // prettier-ignore
      span.emphasis { color: rgb(0, 0, 0); }
    }

    &::before {
      content: "– ";
      margin-left: -16px;
    }
  }
}
</style>
