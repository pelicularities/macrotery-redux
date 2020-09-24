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
  static targets = [ 'protein', 'carbs', 'fats', 'userProtein', 'userCarbs', 'userFats', 'userCalories' ];

  connect() {
    console.log('Stimulus is connected');
  }
  
  refresh() {
    const protein = this.proteinTarget.value;
    const carbs = this.carbsTarget.value;
    const fats = this.fatsTarget.value;

    this.userProteinTarget.innerHTML = `Protein: ${protein} g`;
    this.userCarbsTarget.innerHTML = `Carbs: ${carbs} g`;
    this.userFatsTarget.innerHTML = `Fats: ${fats} g`;
    const calories = 4 * protein + 4 * carbs + 9 * fats;
    this.userCaloriesTarget.innerHTML = `Cals: ${calories} g`;

    const query = `/dishes?protein=${protein}&carbs=${carbs}&fats=${fats}`;
    fetch(query, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        data["dishes"].forEach(dish => {
          
        });
      });
  }
}
