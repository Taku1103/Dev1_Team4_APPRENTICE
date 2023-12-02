let point = document.getElementById("point")
let correct_history = document.getElementById("correct_history")

// WIP API 読み込み時API叩いて情報取得
window.onload = function(){
    axios.get("http://localhost:3000/")
    .then((response) => {
        console.log(response);
        console.log(response.data);
        point.innerText = `${response.data[得点]}/${response.data[最大問題数]}`
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});
}