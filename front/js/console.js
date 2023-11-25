// script.js
// コンソールに表示
document
  .getElementById("fetchDataButton")
  .addEventListener("click", consoleFetchTest);

function consoleFetchTest() {
  // サーバーからデータを取得
  axios
    .get("http://localhost:3000/console")
    .then((response) => {
      console.log(response);
    })
    .catch((error) => {
      console.error("Error fetching data:", error.message);
    });
}
