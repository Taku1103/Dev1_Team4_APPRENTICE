let point = document.getElementById("point")
let correct_history = document.getElementById("correct_history")
let answerButton = document.getElementById("answerButton")

// WIP API 読み込み時API叩いて情報取得
window.onload = function(){
    axios.get("http://localhost:3000/result")
    .then((response) => {
        console.log(response);
        console.log(response.data);
        point.innerText = `${response.data["得点"]}問/${response.data["最大問題数"]}問中 正解！`
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});
}

answerButton.addEventListener("click", function(){
    axios.get("http://localhost:3000/result_init")
    .then((response) => {
        console.log(response);
        console.log(response.data);
        window.location.href = "http://127.0.0.1:5050/index.html";
    })
    .catch((error) => {
        console.error("Error submitting :", error.message);
});
})