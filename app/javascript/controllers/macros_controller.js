// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import mapboxgl from 'mapbox-gl';

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
    'userCalories',
    'params'
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
        params.set('lat', lat);
        params.set('lng', lng);
        const query = `${url.pathname}?${params.toString()}`;
        console.log(query);
        this.fetchJSON(query);
        this.paramsTarget.value = params.toString();
      });
    }
  }

  changeMeal() {
    console.log("I'm inside the changeMeal function");
    const meal = this.selectTarget.value;
    const mealName = this.selectTarget.options[this.selectTarget.selectedIndex].text;
    this.nameTarget.innerHTML = mealName;
    console.log(meal);

    const url = new URL(document.location.href);
    let params = new URLSearchParams(this.paramsTarget.value);
    params.set('macro', meal);
    params.delete('protein');
    params.delete('carbs');
    params.delete('fats');

    const query = `${url.pathname}?${params.toString()}`;
    console.log(query);
    this.fetchJSON(query);
    this.paramsTarget.value = params.toString();
  }
  
  refresh() {
    console.log("I'm inside the refresh function");
    this.nameTarget.innerHTML = '';

    const protein = this.proteinTarget.value;
    const carbs = this.carbsTarget.value;
    const fats = this.fatsTarget.value;

    const url = new URL(document.location.href);
    let params = new URLSearchParams(this.paramsTarget.value);
    params.set('protein', protein);
    params.set('carbs', carbs);
    params.set('fats', fats);
    params.delete('macro');

    const query = `${url.pathname}?${params.toString()}`;

    console.log(query);
    this.fetchJSON(query);
    this.paramsTarget.value = params.toString();
  }

  fitMapToMarkers(map, markers) {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  fetchJSON(query) {
    fetch(query, { headers: { accept: 'application/json' } })
    .then(response => response.json())
    .then((data) => {
      console.log("I'm inside the fetchJSON function");

      const protein = data.macro.protein;
      const carbs = data.macro.carbs;
      const fats = data.macro.fats;
  
      this.userProteinTarget.innerHTML = `${protein} g protein`;
      this.userCarbsTarget.innerHTML = `${carbs} g carbs`;
      this.userFatsTarget.innerHTML = `${fats} g fats`;
  
      const calories = 4 * protein + 4 * carbs + 9 * fats;
      this.userCaloriesTarget.innerHTML = `${calories} kcal calories`;

      const dishList = document.querySelector('#dish-list');
      dishList.innerHTML = data.dishes;
      // console.log(data.dishes);
      // console.log(data.markers);

      const markers = data.markers;
      const oldMarkers = document.querySelectorAll('.mapboxgl-marker');
      oldMarkers.forEach(marker => marker.remove());
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(map);
      });
      this.fitMapToMarkers(map, markers);
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
