import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['checkbox', 'price', 'quantity', 'protein', 'carbs', 'fats', 'quantitylabel', 'addlabel', 'minuslabel', 'add', 'minus', 'dis', 'tick']

    connect() {
        this.quantity = this.data.get('quantity');
        this.price = this.data.get('price');
    }

    handleClick(event) {
        this.checkboxTarget.checked = !this.checkboxTarget.checked;
        let checkbox = false;
        // const position = this.btnTarget.position();
        // console.log(position.left);

        if (this.checkboxTarget.checked) {
            this.quantityTarget.classList.remove('d-none');
            this.addlabelTarget.classList.remove('d-none');
            this.minuslabelTarget.classList.remove('d-none');

            this.quantityTarget.value = 1;
            this.quantitylabelTarget.innerText = 1;
            this.addlabelTarget.innerText = '+';
            this.minuslabelTarget.innerText = '-';
            this.disTarget.classList.add('dis');
            this.tickTarget.classList.add('tick');
            this.disTarget.classList.remove('nodis');
            this.tickTarget.classList.remove('notick');
            checkbox = true;

        } else {
            this.quantityTarget.classList.add('d-none');
            this.addlabelTarget.classList.add('d-none');
            this.minuslabelTarget.classList.add('d-none');
            this.disTarget.classList.remove('dis');
            this.tickTarget.classList.remove('tick');
            this.disTarget.classList.add('nodis');
            this.tickTarget.classList.add('notick');
            checkbox = false;

        }

        const detail = {
            unitPrice: parseFloat(this.priceTarget.dataset.unitPrice),
            quantity: this.quantityTarget.value,
            unitProtein: parseInt(this.proteinTarget.dataset.unitProtein),
            unitCarbs: parseInt(this.carbsTarget.dataset.unitCarbs),
            unitFats: parseInt(this.fatsTarget.dataset.unitFats),
        }
        detail.checkbox = checkbox;

        const e = document.createEvent("CustomEvent")
        e.initCustomEvent("total-change", true, true, detail);
        this.element.dispatchEvent(e)
    }

    handleChange() {
        const quantity = this.quantityTarget.value || 1;
        const unitPrice = this.priceTarget.dataset.unitPrice;
        const add = this.addTarget.innerText;
        const minus = this.minusTarget.innerText;

        const unitProtein = this.proteinTarget.dataset.unitProtein;
        const unitCarbs = this.carbsTarget.dataset.unitCarbs;
        const unitFats = this.fatsTarget.dataset.unitFats;

        const calcPrice = Math.round((quantity * unitPrice) * 100) / 100;
        const calcProtein = Math.round((quantity * unitProtein) * 100) / 100;
        const calcCarbs = Math.round((quantity * unitCarbs) * 100) / 100;
        const calcFats = Math.round((quantity * unitFats) * 100) / 100;

        this.data.set('quantity', quantity)
        this.quantity = this.data.get('quantity');

        this.priceTarget.innerText = `$${calcPrice}`;
        this.proteinTarget.innerText = `${calcProtein}`;
        this.carbsTarget.innerText = `${calcCarbs}`;
        this.fatsTarget.innerText = `${calcFats}`;
        this.quantitylabelTarget.innerText = quantity;

        if (!this.checkboxTarget.checked) {
            this.quantitylabelTarget.classList.add('d-none');
        }

        const e = document.createEvent("CustomEvent")
        e.initCustomEvent("total-change", true, true, {
            quantity: this.quantityTarget.value,
            unitPrice: parseFloat(unitPrice),
            add: add,
            minus: minus,

            unitProtein: parseInt(unitProtein),
            unitCarbs: parseInt(unitCarbs),
            unitFats: parseInt(unitFats),

        })
        this.element.dispatchEvent(e)
    }

    increase() {
        this.quantityTarget.value = parseInt(this.quantityTarget.value) + 1;
        this.addTarget.innerText = this.quantityTarget.value - 1;
        this.handleChange();
    }

    decrease() {
        if (parseInt(this.quantityTarget.value) > 1) {
            this.quantityTarget.value = parseInt(this.quantityTarget.value) - 1;
            this.minusTarget.innerText = parseInt(this.quantityTarget.value) + 1;
            this.handleChange();
        }
    }
}