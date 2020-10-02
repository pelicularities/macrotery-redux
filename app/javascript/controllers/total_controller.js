import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['totalprice', 'totalprotein', 'totalcarbs', 'totalfats', 'dinein', 'yourMacros', 'userProtein', 'userCarbs', 'userFats' ];

    connect() {
        this.amount = parseFloat(this.data.get("amount"));
        this.protein = parseInt(this.data.get("allprotein"));
        this.carbs = parseInt(this.data.get("allcarbs"));
        this.fats = parseInt(this.data.get("allfats"));
    }

    handleUpdate(e) {
        this.amount = parseFloat(this.data.get("amount"));
        this.protein = parseInt(this.data.get("allprotein"));
        this.carbs = parseInt(this.data.get("allcarbs"));
        this.fats = parseInt(this.data.get("allfats"));

        const quantity = e.detail.quantity;
        const unitPrice = e.detail.unitPrice;
        const unitProtein = e.detail.unitProtein;
        const unitCarbs = e.detail.unitCarbs;
        const unitFats = e.detail.unitFats;

        const add = e.detail.add;
        const minus = e.detail.minus;
        const checkbox = e.detail.checkbox;
        let dishAll = 0;
        let proteinAll = 0;
        let carbsAll = 0;
        let fatsAll = 0;

        this.amount += unitPrice * quantity;
        dishAll = unitPrice * quantity;
        this.protein += unitProtein * quantity;
        proteinAll = unitProtein * quantity;
        this.carbs += unitCarbs * quantity;
        carbsAll = unitCarbs * quantity;
        this.fats += unitFats * quantity;
        fatsAll = unitFats * quantity;

        if (add !== undefined || minus !== undefined) {
            if (quantity > add) {
                this.amount -= unitPrice * add;
                dishAll - unitPrice * add;
                this.protein -= unitProtein * add;
                proteinAll - unitProtein * add;
                this.carbs -= unitCarbs * add;
                carbsAll - unitCarbs * add;
                this.fats -= unitFats * add;
                fatsAll - unitFats * add;
            }

            if (quantity < minus) {
                this.amount -= unitPrice * minus;
                dishAll - unitPrice * minus;
                this.protein -= unitProtein * minus;
                proteinAll - unitProtein * minus;
                this.carbs -= unitCarbs * minus;
                carbsAll - unitCarbs * minus;
                this.fats -= unitFats * minus;
                fatsAll - unitFats * minus;
            }
        }

        if (checkbox === false) {
            this.amount -= dishAll * 2;
            this.protein -= proteinAll * 2;
            this.carbs -= carbsAll * 2;
            this.fats -= fatsAll * 2;
        }

        this.amount = Math.round(this.amount * 100) / 100;

        this.data.set('amount', this.amount);
        this.data.set('allprotein', this.protein);
        this.data.set('allcarbs', this.carbs);
        this.data.set('allfats', this.fats);

        this.totalpriceTarget.innerText = `$${this.amount}`;
        this.totalproteinTarget.innerText = this.protein;
        this.totalcarbsTarget.innerText = this.carbs;
        this.totalfatsTarget.innerText = this.fats;

        if (this.userProteinTarget && this.userCarbsTarget && this.userFatsTarget) {
          console.log('this user has macros');
          console.log(this.userProteinTarget.innerText);
          console.log(this.userCarbsTarget.innerText);
          console.log(this.userFatsTarget.innerText);

          let isOver;

          if (this.protein > this.userProteinTarget.innerText) {
            isOver = true;
          } else if (this.carbs > this.userCarbsTarget.innerText) {
            isOver = true;
          } else if (this.fats > this.userFatsTarget.innerText) {
            isOver = true;
          } else {
            isOver = false;
          }
          console.log(isOver);

          const warning = document.getElementById('warning');
          if (isOver) {
            warning.style.display = 'inline';
          } else {
            warning.style.display = 'none';
          }
        }
    }
}