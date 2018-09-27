const isGHPages = process.env.GH_PAGES === "true";

module.exports = {
  baseUrl: isGHPages ? "/vue-resume/" : "/resume"
};
