import { Controller } from "stimulus";

const isOverlapping = (e1, e2) => {
    if (e1.length && e1.length > 1) {
        e1 = e1[0];
    }
    if (e2.length && e2.length > 1) {
        e2 = e2[0];
    }
    const rect1 = e1 instanceof Element ? e1.getBoundingClientRect() : false;
    const rect2 = e2 instanceof Element ? e2.getBoundingClientRect() : false;

    window.console ? console.log(rect1, rect2) : null;
    let overlap = null;
    if (rect1 && rect2) {
        overlap = !(
            rect1.right < rect2.left ||
            rect1.left > rect2.right ||
            rect1.bottom < rect2.top ||
            rect1.top > rect2.bottom
        )
        return overlap;
    } else {
        window.console ? console.warn('Please pass native Element object') : null;
        return overlap;
    }
}

export default class extends Controller {
    static targets = ['checkbox', 'price', 'quantity', 'protein', 'carbs', 'fats', 'quantitylabel', 'addlabel', 'minuslabel', 'add', 'minus', 'dis', 'tick', 'btn']

    connect() {
        this.quantity = this.data.get('quantity');
        this.price = this.data.get('price');
    }

    handleClick(event) {
        const totalBox = document.querySelector('.total');
        if (!isOverlapping(this.btnTarget, totalBox)) {
            this.checkboxTarget.checked = !this.checkboxTarget.checked;
            let checkbox = false;
            // const position = this.btnTarget.position();
            // console.log(position.left);

            if (this.checkboxTarget.checked) {
                this.quantitylabelTarget.classList.remove('d-none');
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
                this.quantitylabelTarget.classList.add('d-none');
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