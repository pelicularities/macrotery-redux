// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 
    'name',
    'select',
    'protein',
    'carbs',
    'fats',
    'userProtein',
    'userCarbs',
    'userFats',
    'userCalories'
  ];

  connect() {
    console.log('macrosController is connected');

    // if url params does not include lat and long
    // get user location
    // send user to url with location
    const url = new URL(document.location.href);
    let params = new URLSearchParams(url.search);
    let lat = params.get("lat");
    let lng = params.get("lng");

    if (lat === null && lng === null) {
      navigator.geolocation.getCurrentPosition((data) => {
        lat = data.coords.latitude;
        lng = data.coords.longitude;
        params.append('lat', lat);
        params.append('lng', lng);
        console.log(params.toString());
        
        // console.log(query);
        // Turbolinks.visit(query);
      });
    }
    const query = `${url.pathname}?${params}`;
    console.log(query);
    const data = this.fetchJSON(query);
    console.log("I'm inside the connect function");
    console.log(data);
  }

  changeMeal() {
    const meal = this.selectTarget.value;
    console.log(meal);

    // is map currently loaded? if it is, make sure to show map tab
    const mapTab = document.getElementById('results-map-tab');
    
    const mapVisible = mapTab.classList.contains('active');

    const query = `/dishes?macro=${meal}`;
    console.log(query);
    const data = this.fetchJSON(query);
    console.log("I'm inside the changeMeal function");
    console.log(data);
    // Turbolinks.visit(query);
    // $('#results-map-tab').tab('show');

    // if (mapVisible === true) {
    //   console.log('show the map!');
    //   this.showMap();
    // }
  }
  
  refresh() {
    const protein = this.proteinTarget.value;
    const carbs = this.carbsTarget.value;
    const fats = this.fatsTarget.value;

    this.userProteinTarget.innerHTML = `${protein} g protein`;
    this.userCarbsTarget.innerHTML = `${carbs} g carbs`;
    this.userFatsTarget.innerHTML = `${fats} g fats`;
    const calories = 4 * protein + 4 * carbs + 9 * fats;
    this.userCaloriesTarget.innerHTML = `${calories} kcal calories`;

    const query = `/dishes?protein=${protein}&carbs=${carbs}&fats=${fats}`;
    console.log(query);
    const data = this.fetchJSON(query);
    console.log("I'm inside the refresh function");
    console.log(data);
    // Turbolinks.visit(query);
  }

  fetchJSON(query) {
    fetch(query, { headers: { accept: 'application/json' } })
    .then(response => response.json())
    .then((data) => {
      console.log("I'm inside the fetchJSON function");
      const dishList = document.querySelector('#dish-list');
      const map = document.querySelector('#map');
      dishList.innerHTML = data.dishes;
      console.log(data.map);
      map.innerHTML = data.map;
    });
  }

  // showMap() {
  //   console.log('this is showMap()');
  //   const listTab = document.getElementById('results-list-tab');
  //   const listContent = document.getElementById('results-list');
  //   const mapTab = document.getElementById('results-map-tab');
  //   const mapContent = document.getElementById('results-map');

  //   listTab.classList.remove('active');
  //   listContent.classList.remove('active');
  //   listContent.classList.remove('show');
  //   mapTab.classList.add('active');
  //   mapContent.classList.add('active');
  //   mapContent.classList.add('show');
  // }
}
