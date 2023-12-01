window.onload = function() {
    axios.get("http://localhost:3000/response_answer")
    .then((response) => {
        console.log(response)
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});
};

o_img = document.getElementById("o_img")
x_img = document.getElementById("x_img")

// 正誤情報からstyle.display = "none"とか"block"に切り替える