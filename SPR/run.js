document.addEventListener("DOMContentLoaded", function () {
    startGame();
});
function startGame() {
    // Create a result display element
    var resultDiv = document.createElement("div");
    resultDiv.id = "gameResult";
    resultDiv.style.fontSize = "20px";
    resultDiv.style.marginTop = "20px";
    document.body.appendChild(resultDiv);
    playGame();
}
function computerChoice() {
    var choices = ["Rock", "Paper", "Scissors"];
    return choices[Math.floor(Math.random() * choices.length)];
}
function playerChoice() {
    var _a, _b;
    var choice;
    while (true) {
        choice = (_b = (_a = prompt("Rock, Paper, or Scissors?")) === null || _a === void 0 ? void 0 : _a.trim()) !== null && _b !== void 0 ? _b : null;
        if (choice && ["Rock", "Paper", "Scissors"].includes(choice)) {
            return choice;
        }
        alert("Invalid choice. Please enter Rock, Paper, or Scissors.");
    }
}
function playGame() {
    var computer = computerChoice();
    var player = playerChoice();
    var result;
    if (computer === player) {
        result = "DRAW";
    }
    else if ((computer === "Paper" && player === "Rock") ||
        (computer === "Rock" && player === "Scissors") ||
        (computer === "Scissors" && player === "Paper")) {
        result = "You Lose";
    }
    else {
        result = "You Win";
    }
    // Display result in browser
    var resultDiv = document.getElementById("gameResult");
    if (resultDiv) {
        resultDiv.innerHTML =
            "Computer's choice: <b>".concat(computer, "</b><br>\n             Your choice: <b>").concat(player, "</b><br>\n             <strong>Result: ").concat(result, "</strong>");
    }
}
