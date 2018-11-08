<template>
  <div class="resume">
    <resume-header v-bind="headerData" />
    <div class="content">
      <div class="column left">
        <experience :data="experienceData" />
      </div>
      <div class="column right">
        <skills v-bind="skillsData" />
        <projects :data="projectsData" />
        <education :data="educationData" />
      </div>
    </div>
  </div>
</template>

<script>
import _ from "lodash";
import Header from "@/components/Header.vue";
import Experience from "@/components/Experience.vue";
import Skills from "@/components/Skills.vue";
import Projects from "@/components/Projects.vue";
import Education from "@/components/Education.vue";

export default {
  props: {
    data: { type: Object, required: true }
  },
  computed: {
    headerData: function() {
      return _.pick(this.data, ["name", "blurb", "links"]) || {};
    },
    experienceData: function() {
      return this.data.experiences;
    },
    skillsData: function() {
      return this.data.skills;
    },
    projectsData: function() {
      return this.data.projects;
    },
    educationData: function() {
      return this.data.education;
    }
  },
  components: {
    "resume-header": Header,
    Experience,
    Skills,
    Projects,
    Education
  }
};
</script>

<style lang="scss" scoped>
div.resume {
  width: 8.5in;
  height: 11in;
  display: flex;
  flex-direction: column;

  background-color: white;
}

div.content {
  flex: 1;
  display: flex;
}

div.column {
  padding: 50px;
  padding-top: 35px;
  flex: 1;

  // prettier-ignore
  &.left { padding-right: 15px; }

  &.right {
    padding-left: 15px;

    // '>' is the immediate-child selector.
    // prettier-ignore
    > div { margin-bottom: 18px; }
  }
}
</style>
