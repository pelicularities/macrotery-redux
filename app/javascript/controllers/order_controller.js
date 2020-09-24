import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['checkbox', 'price', 'quantity']

    handleClick(event) {
        this.checkboxTarget.checked = !this.checkboxTarget.checked;
        if (this.checkboxTarget.checked) {
            this.quantityTarget.classList.remove('d-none');
            this.quantityTarget.value = 1;
        } else {
            this.quantityTarget.classList.add('d-none');
            this.quantityTarget.value = 0;
        }
    }

    handleChange(event) {
        const quantity = event.currentTarget.value || 1;
        const unitPrice = this.priceTarget.dataset.unitPrice;

        const calcPrice = Math.round((quantity * unitPrice) * 100) / 100;

        this.priceTarget.innerText = `$${calcPrice}`;
    }
}