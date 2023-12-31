let mondai = document.getElementById("mondai");
let mondai_level = document.getElementById("mondai_level");
let genre = document.getElementById("genre");
let mondai_img = document.getElementById("mondai_img");
let mondai_text = document.getElementById("mondai_text");

// ページ読み込み時に問題データ受信
window.onload = function () {
  axios
    .get("http://localhost:3000/get_quiz")
    .then((response) => {
      console.log(response);
      console.log(response.data);
      mondai.innerText = `問題数:${response.data["問題数"]}`;
      mondai_level.innerText = `問題レベル:${response.data["問題レベル"]}`;
      genre.innerText = `ジャンル:${response.data["ショートカットジャンル名"]}`;
      mondai_text.innerText = response.data["問題文"];
      return axios.get("http://localhost:3000/get_png", {
        responseType: "blob",
      });
    })
    .then((response) => {
      let imageNode = document.getElementById("mondai_img");
      let imgUrl = URL.createObjectURL(response.data);
      imageNode.src = imgUrl;
    })
    .catch((error) => {
      console.error("Error submitting reqData:", error.message);
    });
};
