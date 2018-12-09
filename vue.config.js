const { NODE_ENV: env } = process.env;

module.exports = {
  baseUrl: env === "development" ? undefined : "/resume/",
  configureWebpack: {
    resolve: {
      alias: { vue$: "vue/dist/vue.runtime.esm.js" },
    },
  },
};
