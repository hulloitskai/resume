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
// $lang-color: rgb(24, 188, 114);
$lib-color: rgb(179, 179, 179);
// $tech-color: rgb(210, 142, 238);

$lang-color: $lib-color;
$tech-color: $lib-color;

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
    margin: 2px;
    padding: 2px 6px;
    border-radius: 3px;
    font-size: 15px;
  }
}

.langs {
  // prettier-ignore
  // h2 { color: darken($lang-color, 10%); }

  p {
    background-color: rgba($lang-color, 0.22);
    color: darken($lang-color, 30%);
  }
}

.libs {
  // prettier-ignore
  // h2 { color: darken($lib-color, 15%); }

  p {
    background-color: rgba($lib-color, 0.22);
    color: darken($lib-color, 30%);
  }
}

.techs {
  // prettier-ignore
  // h2 { color: darken($tech-color, 20%); }

  p {
    background-color: rgba($tech-color, 0.25);
    color: darken($tech-color, 30%);
  }
}
</style>
