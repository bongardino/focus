/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: [],
      calendars: []
    };
  },
  created: function() {
    // axios.get('/api/users/show').then(function(response) {
    //   console.log(response.data);
    //   this.message = response.data;
    // }.bind(this));
    // axios.get('/api/calendars').then(function(response) {
    //   console.log(response.data);
    //   this.calendars = response.data;
    // }.bind(this));
  },
  methods: {},
  computed: {}
};

var LineChart = {
  template: "#chart-page", // doesn't do anything
  extends: VueChartJs.Line,
  data: function() {
    return {
      duration: []
    }
  },
  mounted () {
    axios.get('/api/calendars').then(function(response) {
      console.log(response.data);
      this.duration = response.data.map(x => x.duration);
      console.log("this.duration");
      console.log(this.duration);
      this.renderChart({
        labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
        datasets: [
          {
            label: 'Duration',
            backgroundColor: '#191970',
            data: this.duration
          }
        ]
      }, {responsive: true, maintainAspectRatio: false})
    }.bind(this))
  }
}

var router = new VueRouter({
  routes: [
  { path: "/", component: LineChart }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});

// var vm = new Vue({
//   el: '.app',
//   data: {
//     message: 'Hello World'
//   }
// })
