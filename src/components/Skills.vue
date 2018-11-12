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
@import "@/mixins/_colors.scss";

// prettier-ignore
.section { margin-bottom: .5em; }

h2 {
  margin-bottom: 0.15em;
  font-size: 11.25pt;
  color: #606060;
}

.tags {
  display: flex;
  flex-wrap: wrap;

  p {
    margin: 0 0.25em 0.25em 0;
    padding: 0.16em 0.4em;
    border-radius: 0.25em;
    font-size: 11.25pt;
  }
}

.langs p {
  background-color: rgba($lang-color, 0.22);
  color: $lang-color-dark;
}

.libs p {
  background-color: rgba($lib-color, 0.22);
  color: $lib-color-dark;
}

.techs p {
  background-color: rgba($tech-color, 0.25);
  color: $tech-color-dark;
}
</style>
