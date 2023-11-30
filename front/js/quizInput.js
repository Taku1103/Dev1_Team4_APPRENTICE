const answer = document.getElementById("answer");

let keyInput = document.getElementById("keyInput");
let ctrlCheckbox = document.getElementById("ctrlCheckbox");
let shiftCheckbox = document.getElementById("shiftCheckbox");
let altCheckbox = document.getElementById("altCheckbox");

const clearButton = document.getElementById("clearButton");

answer.addEventListener("keydown", function (event) {
  const key = event.key;
  const ctrl = event.ctrlKey;
  const shift = event.shiftKey;
  const alt = event.altKey;
  const meta = event.metaKey;

  if (ctrl) {
    ctrlCheckbox.checked = ctrl;
  }
  if (shift) {
    shiftCheckbox.checked = shift;
  }
  if (alt) {
    altCheckbox.checked = alt;
  }
});

clearButton.addEventListener("click", function (event) {
  ctrlInput.value = "";
  shiftInput.value = "";
  altInput.value = "";
  keyInput.value = "";
});

// ctrlInput.addEventListener("keyup", function(event){
//         ctrlInput.value = ""
// })
// altInput.addEventListener("keyup", function(event){
//         altInput.value = ""
// })
// shiftInput.addEventListener("keyup", function(event){
//         shiftInput.value = ""
// })




window.onload = function(){
    axios.get("http://localhost:3000/get_quiz")
    .then((response) => {
        console.log(response)
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});
}


const answerButton = document.getElementById("answerButton")

answerButton.addEventListener("click", function submitData() {
  let reqData = {
    Ctrl: ctrlCheckbox.checked,
    Shift: shiftCheckbox.checked,
    Alt: altCheckbox.checked,
    Key: keyInput.value,
  };
  console.log(reqData);
  axios
    .get(
      `http://localhost:3000/user_answer/?ctrl=${reqData.Ctrl}&shiht=${reqData.Shift}&alt=${reqData.Alt}&key=${reqData.Key}`
    )
    .then((response) => {
      console.log(response);
    })
    .catch((error) => {
      console.error("Error submitting reqData:", error.message);
    });
});
