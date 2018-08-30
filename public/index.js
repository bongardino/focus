/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      calendars: []
    };
  },
  created: function() {
    axios.get('/api/users/show').then(function(response) {
      console.log(response.data);
      this.message = response.data;
    }.bind(this));
    // axios.get('/api/calendars').then(function(response) {
    //   console.log(response.data);
    //   this.calendars = response.data;
    // }.bind(this));
  },
  methods: {},
  computed: {}
};

var router = new VueRouter({
  routes: [
  { path: "/", component: HomePage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});
