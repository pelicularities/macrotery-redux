const testFunction = () => {
    const cardBtn = document.querySelectorAll(".card-btn");

    let index = 0;
    cardBtn.forEach(card => {
        card.addEventListener("click", (event) => {
            let tick = event.currentTarget.parentNode.children[1].classList.toggle("show"); // tick return true when tick, false when hidden
            let plus = event.currentTarget.parentNode.children[2].children[0].classList.toggle("show");
            let num = event.currentTarget.parentNode.children[2].children[1].classList.toggle("show");
            let minus = event.currentTarget.parentNode.children[2].children[2].classList.toggle("show");

            event.currentTarget.parentNode.children[6].classList.toggle("shift"); // btn surface retain within card
            // console.log(event.currentTarget.parentNode.children);

            const add = event.currentTarget.parentNode.children[2].children[0];
            const number = event.currentTarget.parentNode.children[2].children[1];
            const substract = event.currentTarget.parentNode.children[2].children[2];
            let no = 1;
            if (plus === true) {
                add.addEventListener("click", (event) => {
                    number.innerText = no += 1;
                });
            };

            if (minus === true) {
                substract.addEventListener("click", (event) => {
                    if (no - 1 < 1) { number.innerText = 1; }
                    else { number.innerText = no -= 1; }
                });
            };

        });
    });
};

export default testFunction;
