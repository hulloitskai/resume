<template>
  <div class="resume">
    <resume-header v-bind="headerData" />
    <div class="content">
      <div class="column left">
        <experience :data="experienceData" />
      </div>
      <div class="column right" />
    </div>
  </div>
</template>

<script>
import _ from "lodash";
import Header from "@/components/Header.vue";
import Experience from "@/components/Experience.vue";

export default {
  props: {
    data: { type: Object, required: true }
  },
  computed: {
    headerData: function() {
      return _.pick(this.data, ["name", "blurb", "links"]);
    },
    experienceData: function() {
      return this.data.experiences;
    }
  },
  components: { "resume-header": Header, Experience }
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
  padding-top: 40px;

  &.left {
    flex: 5;
    padding-right: 20px;
  }

  &.right {
    flex: 3;
    padding-left: 20px;
  }
}
</style>
