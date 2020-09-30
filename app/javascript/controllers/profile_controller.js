// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ ];

  connect() {
    console.log('profileController is connected');
  }

  changeDefault(event) {
    // find which element fired the event
    const newDefault = event.target
    console.log(newDefault.value);
    const query = `/change_default_macros`;
    const queryBody = { new_default: newDefault.value };
    fetch(query, {
       method: 'post',
       headers: 
        {
         'Content-Type': 'application/json',
         'X-CSRF-Token': csrfToken(),
         accept: 'application/json'
        },
       body: JSON.stringify(queryBody) 
      })
    .then(response => response.json())
    .then((data) => {
      console.log(data.macro);
      console.log(data.success);
    });

    // update table so that the default-macros class is applied to the new default
    // get an array of the macro IDs for this user
    let macrosIDs = document.getElementById('macroIDs');
    macrosIDs = macrosIDs.value.split(' ');
    console.log('macrosIDs');
    
    // modify the DOM elements based on macroIDs
    macrosIDs.forEach((macro) => {
      const th = document.querySelector(`#row-${macro} th`);
      const tds = document.querySelectorAll(`#row-${macro} td`);
      if (macro === newDefault.value) {
        // this is the new default, let's apply the .default-macros class
        th.classList.add('default-macros')
        tds.forEach(td => td.classList.add('default-macros'));
      } else {
        // this is not a default, let's remove the .default-macros class
        th.classList.remove('default-macros')
        tds.forEach(td => td.classList.remove('default-macros'));
      }
    });
  }
}
