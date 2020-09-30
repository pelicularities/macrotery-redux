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
  static targets = [];

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
  }
}
