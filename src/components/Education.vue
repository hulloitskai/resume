<template>
  <resume-section title="EDUCATION">
    <div class="item" v-for="(school, i) in data" :key="i">
      <h3 class="name">{{ school.name }}</h3>
      <h4 class="timestamp">{{ school.timestamp }}</h4>
      <p class="blurb">{{ school.blurb }}</p>
    </div>
  </resume-section>
</template>

<script>
import Section from "./Section.vue";

export default {
  props: {
    data: { type: Array, default: () => [] }
  },
  components: { "resume-section": Section }
};
</script>

<style lang="scss" scoped>
.name {
  font-weight: 600;
  font-size: 16px;
}

.timestamp {
  font-weight: 500;
  font-size: 13px;
}

.blurb {
  margin-top: 1px;
  font-size: 15px;
  color: #4d4d4d;
}
</style>
