// brian help link

// https://codepen.io/apertureless/pen/vprOpj/

Vue.component('bar-chart', {
	extends: VueChartJs.Bar,
	data: function () {
		return {
			datacollection: {
				"Description": "statistics",
				"Id": "f5c059e0-260f-4e55-b0f6-05694fa8495f",
				"labels": ["lun", "mar", "mer", "gio", "ven", "sab", "dom"],
				"datasets": [
					{
						"label": "Cooking",
						"data": [3],
						"type": null,
						"backgroundColor": "rgba(42,203,211,1)",
						"borderColor": "rgba(255,255,255,1)",
						"borderWidth": 2
					},
					{
						"label": "Ready",
						"data": [4],
						"type": null,
						"backgroundColor": "rgba(235,104,82,1)",
						"borderColor": "rgba(255,255,255,1)",
						"borderWidth": 2
					},
					{
						"label": "StandBy",
						"data": [42],
						"type": null,
						"backgroundColor": "rgba(109,58,93,1)",
						"borderColor": "rgba(255,255,255,1)",
						"borderWidth": 2
					},
					{
						"label": "PreHeating",
						"data": [0],
						"type": null,
						"backgroundColor": "rgba(65,84,100,1)",
						"borderColor": "rgba(255,255,255,1)",
						"borderWidth": 2
					}
				]
			},
			options: {
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
			},
		}
	},
	mounted () {
		// this.chartData is created in the mixin
		this.renderChart(this.datacollection, this.options);
	}
})

var vm = new Vue({ 
	el: '.app',
})