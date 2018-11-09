<template>
  <resume-section title="SKILLS">
    <div class="section langs">
      <h2>languages</h2>
      <div class="tags">
        <p v-for="lang in languages" :key="lang">{{ lang }}</p>
      </div>
    </div>
    <div class="section libs">
      <h2>libraries</h2>
      <div class="section tags">
        <p v-for="lib in libraries" :key="lib">{{ lib }}</p>
      </div>
    </div>
    <div class="section techs">
      <h2>technologies</h2>
      <div class="tags">
        <p v-for="tech in technologies" :key="tech">{{ tech }}</p>
      </div>
    </div>
  </resume-section>
</template>

<script>
import Section from "./Section.vue";

// The default prop "type".
const propType = { type: Array, default: () => [] };

export default {
  props: {
    languages: propType,
    libraries: propType,
    technologies: propType
  },
  components: { "resume-section": Section }
};
</script>

<style lang="scss" scoped>
.section {
  margin-bottom: 8px;
}

h2 {
  margin-bottom: 2px;
  font-size: 15px;
  color: #585858;
}

.tags {
  display: flex;
  flex-wrap: wrap;

  p {
    margin: 0 4px 4px 0;
    padding: 2px 6px;
    border-radius: 3px;
    font-size: 15px;

    background-color: #f5f5f5;
    color: #777777;
  }
}
</style>
