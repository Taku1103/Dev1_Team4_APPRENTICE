const answer = document.getElementById("answer");
const answerButton = document.getElementById("answerButton");
const clearButton = document.getElementById("clearButton");

let keyInput = document.getElementById("keyInput");
let ctrlCheckbox = document.getElementById("ctrlCheckbox");
let shiftCheckbox = document.getElementById("shiftCheckbox");
let altCheckbox = document.getElementById("altCheckbox");
let ctrlKCheckbox = document.getElementById("ctrlKCheckbox");

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

// clearButton.addEventListener("click", function (event) {
//   ctrlInput.value = "";
//   shiftInput.value = "";
//   altInput.value = "";
//   keyInput.value = "";
//   ctrlKCheckbox.value = "";
// });

// 回答ボタン押したらAPI叩いてユーザー入力を送信、answer.htmlに画面遷移
answerButton.addEventListener("click", function submitData() {
  let reqData = {
    CtrlK: ctrlKCheckbox.checked,
    Ctrl: ctrlCheckbox.checked,
    Shift: shiftCheckbox.checked,
    Alt: altCheckbox.checked,
    Key: keyInput.value,
  };
  console.log(reqData);
  axios
    .get(
      `http://localhost:3000/user_answer/?ctrl_k=${reqData.CtrlK}&ctrl=${reqData.Ctrl}&shift=${reqData.Shift}&alt=${reqData.Alt}&key=${reqData.Key}`
    )
    .then((response) => {
      console.log(response);
      window.location.href = "http://127.0.0.1:5050/HTML/answer.html";
    })
    .catch((error) => {
      console.error("Error submitting reqData:", error.message);
    });
});
