module.exports = {
  baseUrl: "resume",
  configureWebpack: {
    resolve: {
      alias: { vue$: "vue/dist/vue.runtime.esm.js" }
    }
  }
};
