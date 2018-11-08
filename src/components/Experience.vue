<template>
  <resume-section title="EXPERIENCE">
    <div class="item" v-for="(exp, i) in data" :key="i">
      <h3 class="title">{{ exp.title }}</h3>
      <h4 class="timestamp">{{ exp.timestamp }}</h4>
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

.timestamp {
  font-weight: 500;
  font-size: 14px;
}

.points {
  margin: 5px 0 20px 0;
  padding-left: 20px;

  color: #4d4d4d;
  font-size: 15.5px;

  li {
    margin-bottom: 5px;
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
