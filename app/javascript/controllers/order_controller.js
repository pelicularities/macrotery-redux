import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['checkbox', 'price', 'quantity', 'protein', 'carbs', 'fats', 'quantitylabel']

    connect() {
        console.log()
        this.quantity = this.data.get('quantity');
    }

    handleClick(event) {
        this.checkboxTarget.checked = !this.checkboxTarget.checked;
        if (this.checkboxTarget.checked) {
            this.quantityTarget.classList.remove('d-none');
            this.quantityTarget.value = 1;
            this.quantitylabelTarget.innerText = 1;
        } else {
            this.quantityTarget.classList.add('d-none');
            this.quantityTarget.value = 0;
            this.quantitylabelTarget.innerText = 0;
        }

        const e = document.createEvent("CustomEvent")
        const detail = {
            unitPrice: parseFloat(this.priceTarget.dataset.unitPrice),
            quantity: this.quantityTarget.value
        }

        if (!this.checkboxTarget.checked) {
            detail.prevPrice = -(parseFloat(this.priceTarget.innerText.replace('$', '')));
        }


        e.initCustomEvent("total-change", true, true, detail);
        this.element.dispatchEvent(e)
    }

    handleChange() {
        const quantity = this.quantityTarget.value || 1;
        const unitPrice = this.priceTarget.dataset.unitPrice;
        const unitProtein = this.proteinTarget.dataset.unitProtein;
        const unitCarbs = this.carbsTarget.dataset.unitCarbs;
        const unitFats = this.fatsTarget.dataset.unitFats;

        const calcPrice = Math.round((quantity * unitPrice) * 100) / 100;
        const calcProtein = Math.round((quantity * unitProtein) * 100) / 100;
        const calcCarbs = Math.round((quantity * unitCarbs) * 100) / 100;
        const calcFats = Math.round((quantity * unitFats) * 100) / 100;

        const prevPrice = -(parseFloat(this.priceTarget.innerText.replace('$', '')))

        this.data.set('quantity', quantity)
        this.quantity = this.data.get('quantity');

        this.priceTarget.innerText = `$${calcPrice}`;
        this.proteinTarget.innerText = `${calcProtein}`;
        this.carbsTarget.innerText = `${calcCarbs}`;
        this.fatsTarget.innerText = `${calcFats}`;
        this.quantitylabelTarget.innerText = quantity;

        const e = document.createEvent("CustomEvent")
        e.initCustomEvent("total-change", true, true, {
            unitPrice: parseFloat(unitPrice),
            quantity: this.quantityTarget.value,
            prevPrice: prevPrice,
        })
        this.element.dispatchEvent(e)
    }

    increase() {
        this.quantityTarget.value = parseInt(this.quantityTarget.value) + 1;
        this.handleChange();
    }

    decrease() {
        if (parseInt(this.quantityTarget.value) > 1) {
            this.quantityTarget.value = parseInt(this.quantityTarget.value) - 1;
            this.handleChange();
        }
    }
}