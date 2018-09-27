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
  props: { data: Array },
  computed: {
    points: function() {
      return this.data.map(({ points }) => {
        console.log("points", points);
        const newPoints = points.map(emphParse);
        console.log("newPoints", newPoints);
        return newPoints;
      });
    }
  },
  components: { "resume-section": Section }
};
</script>

<style lang="scss" scoped>
// prettier-ignore
h3, h4 { font-family: "Fira Code", "Courier New", Courier, monospace; }

h3.title {
  color: #585858;
  font-weight: 600;
  font-size: 16px;
}

h4.timestamp {
  color: #919191;
  font-weight: 500;
  font-size: 15px;
  font-style: oblique;
}

ul.points {
  margin: 7px 0 20px 0;
  padding-left: 20px;

  color: #5c5c5c;
  font-size: 15.5px;

  li {
    margin-bottom: 5px;
    list-style-type: none;

    /deep/ p {
      display: inline;

      span.emphasis {
        $emphcol: rgb(70, 70, 70);
        color: $emphcol;
        text-shadow: 0.6px 0 0 $emphcol;
        letter-spacing: 0.6px;
      }
    }

    &::before {
      content: "– ";
      margin-left: -12px;
    }
  }
}
</style>
