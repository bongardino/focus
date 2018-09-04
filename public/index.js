/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "HomePage",
      people: {email: "", count: ""}
    };
  },
  created: function() {
    axios.get('/api/users/show').then(function(response) {
      console.log(response.data);
      console.log(response.data.attendees_tally);
      this.people = response.data.attendees_tally;
    }.bind(this));
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

var Day = {
  template: "#day-page",
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
  // { path: "/people", component: People },
  { path: "/home", component: HomePage },
  { path: "/day", component: Day }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});
