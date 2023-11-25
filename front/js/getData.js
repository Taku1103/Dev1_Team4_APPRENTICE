
// DBからデータを取得 
document.getElementById("DBDataButton").addEventListener("click", fetchData);

function fetchData() {
  // サーバーからデータを取得
  axios
    .get("http://localhost:3000/get_db_data")
    .then((response) => {
      // 指定したIDにレスポンスデータを入れて表示
      const dataContainer = document.getElementById("dataContainer");
      dataContainer.innerText = `Data from server: ${JSON.stringify(
        response.data
      )}`;
    })
    .catch((error) => {
      console.error("Error fetching data:", error.message);
    });
}