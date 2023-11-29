const answer = document.getElementById("answer")

let keyInput = document.getElementById("keyInput");
let ctrlInput = document.getElementById("ctrlInput");
let altInput = document.getElementById("altInput");
let shiftInput = document.getElementById("shiftInput");

const clearButton = document.getElementById("clearButton")

answer.addEventListener("keydown", function(event) {
    const key = event.key;
    const ctrl = event.ctrlKey;
    const shift = event.shiftKey;
    const alt = event.altKey;
    const meta = event.metaKey;

    if (ctrl){
        ctrlInput.value = "Ctrl"
    }
    if (shift){
        shiftInput.value = "Shift"
    }
    if (alt){
        altInput.value = "Alt"
    }

    // keyInput.value = key
})

clearButton.addEventListener("click", function (event) {
    ctrlInput.value = "";
    shiftInput.value = "";
    altInput.value = "";
    keyInput.value = "";
})

// ctrlInput.addEventListener("keyup", function(event){
//         ctrlInput.value = ""
// })
// altInput.addEventListener("keyup", function(event){
//         altInput.value = ""
// })
// shiftInput.addEventListener("keyup", function(event){
//         shiftInput.value = ""
// })