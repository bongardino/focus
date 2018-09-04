// dont name any other variable duration
Vue.prototype.duration = []

Vue.component('line-chart', {
  extends: VueChartJs.Line,
  data: {
    message: 'Hello World'
  },
  mounted () {
    this.renderChart({
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
      datasets: [
        {
          label: 'Data One',
          backgroundColor: '#f87979',
          data: []
        }
      ]
    }, {responsive: true, maintainAspectRatio: false})
    axios.get('/api/calendars').then(function(response) {
      console.log(response.data);
      for (let i=0; i<response.data.length; i++) {
        this.duration.push(response.data[i].duration)
      } 
      console.log(this.duration);
    }.bind(this));
  }
})

var vm = new Vue({
  el: '.app',
  data: {
    message: 'Hello World'
  }
})

var vm = new Vue.component('line-chart',{
  el: '.app',
  extends: VueChartJs.Line,
    data: {
    message: 'Hello World'
  },
  mounted () {
    this.renderChart({
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
      datasets: [
        {
          label: 'Data One',
          backgroundColor: '#f87979',
          data: [40, 39, 10, 40, 39, 80, 40]
        }
      ]
    }, {responsive: true, maintainAspectRatio: false})
  }
})