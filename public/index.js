/* global Vue, VueRouter, axios */


var StartPage = {
  template: "#start-page",
  data: function() {
    return {
      message: "Hi 👋 Log in why don't you?"
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var LandingPage = {
  template: "#landing-page",
  data: function() {
    return {
      message: "Nice! 🙌 Pick an Insight"
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var FolksPage = {
  template: "#folks-page",
  data: function() {
    return {
      message: "folks-page",
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
  extends: VueChartJs.Line,
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
            label: 'Hours spent in meetings',
            backgroundColor: '#191970',
            fill: false,
            lineTension: 0,
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
      count: [],
      one_to_ones: []
    }
  },
  mounted () {
    axios.get('/api/users/show').then(function(response) {
      console.log(response.data.busy_days);
      for (var day in response.data.busy_days){
        this.days.push(day);
        this.count.push(response.data.busy_days[day]);
      };
      console.log(response.data.one_to_ones);
      for (var day in response.data.one_to_ones){
        this.one_to_ones.push(response.data.one_to_ones[day]);
      };
      this.renderChart({
        labels: this.days,
        datasets: [
          {
            label: 'One to Ones',
            backgroundColor: 'rgba(42,203,211,1)',
            data: this.one_to_ones,
            borderWidth: 8
          },
          {
            label: 'Other Meetings',
            backgroundColor: '#191970',
            data: this.count,
            borderWidth: 8
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
              "min": 0,
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
  { path: "/", component: LandingPage },
  { path: "/start", component: StartPage },
  { path: "/durations", component: Duration },
  { path: "/people", component: FolksPage },
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
