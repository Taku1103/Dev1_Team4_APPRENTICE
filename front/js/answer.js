let answer_gif = document.getElementById("answer_gif")
let answer_shortcut_ex = document.getElementById("answer_shortcut_ex")
let answer_shortcut_ans = document.getElementById("answer_shortcut_ans")
let is_correct_img = document.getElementById("is_correct_img")
let explanation = document.getElementById("explanation")

const nextButton = document.getElementById("nextButton")

window.onload = function() {
    axios.get("http://localhost:3000/response_answer")
    .then((response) => {
        console.log(response)
        console.log(response.data)
        answer_gif.src = response.data["解答GIFパス"];
        answer_shortcut_ex.innerText = response.data["ショートカットコマンド"];
        answer_shortcut_ans.innerText = response.data["ショートカットコマンド"];
        explanation.innerText = response.data['解説']

        if (response.data["解答結果"]) {
            is_correct_img.src = "../img/circle.png"
        }else {
            is_correct_img.src = "../img/plus.png"
        }
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});

    axios.get('http://localhost:3000/get_gif', {responseType: 'blob'})
    .then(response => {
    let imageNode = document.getElementById('answer_gif');
    let imgUrl = URL.createObjectURL(response.data)
    imageNode.src = imgUrl
    })
    .catch((error) => {
        console.error("Error submitting imgData:", error.message);
    });
};

nextButton.addEventListener("click", function submit(){
    axios.get(`http://localhost:3000/is_next_question`)
    .then((response) => {
        console.log(response);
        //result画面遷移フラグ trueでresult falseで次の問題
        if(response.data){
        window.location.href = "http://127.0.0.1:5050/HTML/result.html";
        }else {
            window.location.href = "http://127.0.0.1:5050/HTML/quiz.html";
        }
      })
      .catch((error) => {
        console.error("Error submitting Data:", error.message);
      });
})
