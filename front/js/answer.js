window.onload = function() {
    axios.get("http://localhost:3000/response_answer")
    .then((response) => {
        console.log(response)
    })
    .catch((error) => {
        console.error("Error submitting reqData:", error.message);
});
};