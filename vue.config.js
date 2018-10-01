const isGHPages = process.env.GH_PAGES === "true";

module.exports = {
  baseUrl: isGHPages ? "/vue-resume" : "/resume",
  configureWebpack: {
    resolve: {
      alias: {
        vue$: "vue/dist/vue.runtime.esm.js",
        vuex$: "vuex/dist/vuex.esm.js",
        "vue-router$": "vue-router/dist/vue-router.esm.js"
      }
    }
  }
};
