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
    console.log('Stimulus is connected');
  }

  changeMeal() {
    const meal = this.selectTarget.value;
    console.log(meal);

    // is map currently loaded? if it is, make sure to show map tab
    const mapTab = document.getElementById('results-map-tab');
    
    const mapVisible = mapTab.classList.contains('active');

    const query = `/dishes?macro=${meal}`;
    console.log(query);
    Turbolinks.visit(query);
    // $('#results-map-tab').tab('show');

    if (mapVisible === true) {
      console.log('show the map!');
      this.showMap();
    }
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
    Turbolinks.visit(query);
  }

  showMap() {
    console.log('this is showMap()');
    const listTab = document.getElementById('results-list-tab');
    const listContent = document.getElementById('results-list');
    const mapTab = document.getElementById('results-map-tab');
    const mapContent = document.getElementById('results-map');

    listTab.classList.remove('active');
    listContent.classList.remove('active');
    listContent.classList.remove('show');
    mapTab.classList.add('active');
    mapContent.classList.add('active');
    mapContent.classList.add('show');
  }
}
