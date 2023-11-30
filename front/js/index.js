document.getElementById("level_1").addEventListener("click", function () {
  fetchLevelData(1);
});

document.getElementById("level_2").addEventListener("click", function () {
  fetchLevelData(2);
});

document.getElementById("level_3").addEventListener("click", function () {
  fetchLevelData(3);
});
document.addEventListener()

function fetchLevelData(level) {
  axios
    .get(`http://localhost:3000/create_quiz/?quiz_level=${level}`)
    .then((res) => {
      // レスポンスデータを使って何かしらの処理を行う
      window.location.href = "http://localhost:5050/HTML/quiz.html";
    })
    .catch((error) => {
      console.error("Error fetching data:", error.message);
    });
}
