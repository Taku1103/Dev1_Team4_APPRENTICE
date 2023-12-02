let mondai = document.getElementById("mondai")
let mondai_level =  document.getElementById("mondai_level")
let genre = document.getElementById("genre")
let mondai_img = document.getElementById("mondai_img")
let mondai_text = document.getElementById("mondai_text")

// ページ読み込み時に問題データ受信
window.onload = function(){
    axios.get("http://localhost:3000/get_quiz")
    .then((response) => {
        console.log(response)
        console.log(response.data)
        mondai.innerText = response.data["問題数"]
        mondai_level.innerText = response.data["問題レベル"]
        genre.innerText = response.data["問題ジャンル"]
        mondai_img.src = response.data["問題画像パス"]
        mondai_text.innerText = response.data["問題文"]
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});
}