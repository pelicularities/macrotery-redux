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

  initialize() {
    console.log('queryController is initialized');
  }

  connect() {
    console.log('queryController is connected');
  }

  fetchJSON(query) {
    fetch(query, { headers: { accept: 'application/json' } })
    .then(response => response.json())
    .then((data) => {
      console.log("I'm inside the fetchJSON function");
      console.log(data);
      return data;
    });
  }
}
