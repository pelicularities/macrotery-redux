import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['totalprice'];

    connect() {
        this.amount = parseFloat(this.data.get("amount"));
    }

    handleUpdate(e) {
        console.log(e.detail);
        const unitPrice = e.detail.unitPrice;
        const quantity = e.detail.quantity;
        const prevPrice = e.detail.prevPrice;

        this.amount += unitPrice * quantity;
        if (prevPrice < 0) {
            this.amount += prevPrice
        }

        this.data.set('amount', this.amount);
        this.totalpriceTarget.innerText = `$${this.amount}`;
    }
}