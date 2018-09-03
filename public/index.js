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



var Duration = {
  template: "#duration-page",
  extends: VueChartJs.Bar,
  data: function() {
    return {
      days: [],
      count: []
    }
  },
  mounted () {
    axios.get('/api/users/show').then(function(response) {
      console.log(response.data);
      for (var day in response.data.durations){
        this.days.push(day);
        this.count.push(response.data.durations[day]);
      };
      this.renderChart({
        labels: this.days,
        datasets: [
          {
            label: 'Time in Meeting Per Day',
            backgroundColor: '#191970',
            data: this.count,
          }
        ]
      },
        {
        "animation":{"duration":500},
        "responsive":true,
        "maintainAspectRatio":false,
        "legend":{
          "position":"bottom",
          "display":true,
          "labels":{"usePointStyle":true}
        },
        "scales":{
          "yAxes":[{
            "ticks":{
              "beginAtZero":true,
              "min": 0
            },
            "stacked":true,
            "position": 'left',
  
          }],
          "xAxes":[{
            "barThickness":100,
            "stacked":true
          }]
        },
        }
      )
    }.bind(this))
  }
}

var Time = {
  template: "#time-page",
  extends: VueChartJs.Bar,
  data: function() {
    return {
      days: [],
      count: []
    }
  },
  mounted () {
    axios.get('/api/users/show').then(function(response) {
      console.log(response.data.busy_days);
      for (var day in response.data.busy_days){
        this.days.push(day);
        this.count.push(response.data.busy_days[day]);
      };
      this.renderChart({
        labels: this.days,
        datasets: [
          {
            label: 'Meetings Per Day',
            backgroundColor: '#191970',
            data: this.count,
          }
        ]
      },
        {
        "animation":{"duration":500},
        "responsive":true,
        "maintainAspectRatio":false,
        "legend":{
          "position":"bottom",
          "display":true,
          "labels":{"usePointStyle":true}
        },
        "scales":{
          "yAxes":[{
            "ticks":{
              "beginAtZero":true,
              "min": 0
            },
            "stacked":true,
            "position": 'left',
  
          }],
          "xAxes":[{
            "barThickness":100,
            "stacked":true
          }]
        },
        }
      )
    }.bind(this))
  }
}

var router = new VueRouter({
  routes: [
  { path: "/", component: Duration },
  { path: "/time", component: Time }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});
