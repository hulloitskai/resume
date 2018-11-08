<template>
  <resume-section title="PROJECTS">
    <div class="item" v-for="(proj, i) in data" :key="i">
      <h3 class="name">{{ proj.name }}</h3>
      <div class="description">
        <a v-if="proj.link" class="link" :href="proj.link.url" target="_blank">
          <h4>{{ proj.link.title }}</h4>
        </a>
        <h4 v-if="proj.timestamp" class="timestamp">{{ proj.timestamp }}</h4>
        <h5 v-if="proj.flair" class="flair">{{ proj.flair }}</h5>
      </div>
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
$flair-color: #0d78f4;

.name {
  font-weight: 600;
  font-size: 16px;
}

.description {
  display: flex;
  align-items: center;
}

.link h4,
.timestamp {
  font-weight: 500;
  font-size: 14px;
  margin-right: 12px;
}

// prettier-ignore
.link { text-decoration: none; }

.flair {
  padding: 1px 5px;
  border-radius: 3px;
  background-color: rgba($flair-color, 0.22);

  font-size: 13px;
  font-weight: 500;
  color: $flair-color;
}

.points {
  margin: 5px 0 20px 0;
  padding-left: 20px;

  color: #4f4f4f;
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
