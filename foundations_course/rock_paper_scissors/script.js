let humanScore = 0;
let computerScore = 0;

const roundResult = document.getElementById('round-result');
const scoreDisplay = document.getElementById('score');
const gameWinner = document.getElementById('game-winner');
const choiceButtons = document.querySelectorAll('[data-choice]');

function getComputerChoice() {
  const choices = ['rock', 'paper', 'scissors'];
  const randomIndex = Math.floor(Math.random() * choices.length);
  return choices[randomIndex];
}

function playRound(humanChoice, computerChoice) {
  humanChoice = humanChoice.toLowerCase();
  computerChoice = computerChoice.toLowerCase();

  if (humanChoice === computerChoice) {
    return "It's a tie!";
  } else if (
    (humanChoice === 'rock' && computerChoice === 'scissors') ||
    (humanChoice === 'paper' && computerChoice === 'rock') ||
    (humanChoice === 'scissors' && computerChoice === 'paper')
  ) {
    humanScore++;
    return `You win! ${humanChoice} beats ${computerChoice}`;
  } else {
    computerScore++;
    return `You lose! ${computerChoice} beats ${humanChoice}`;
  }
}

function updateDisplay(message) {
  roundResult.textContent = message;
  scoreDisplay.textContent = `Score: You ${humanScore} - Computer ${computerScore}`;
}

function announceWinner() {
  const winnerMessage = humanScore >= 5
    ? 'Congratulations! You won the game!'
    : 'Game over! The computer won the game!';

  gameWinner.textContent = winnerMessage;
  console.log(winnerMessage);
  choiceButtons.forEach(button => button.disabled = true);
}

function handleChoice(humanChoice) {
  if (humanScore >= 5 || computerScore >= 5) {
    return;
  }

  const computerChoice = getComputerChoice();
  const result = playRound(humanChoice, computerChoice);

  updateDisplay(result);
  console.log(result);
  console.log(`Score: You ${humanScore} - Computer ${computerScore}`);

  if (humanScore >= 5 || computerScore >= 5) {
    announceWinner();
  }
}

choiceButtons.forEach(button => {
  button.addEventListener('click', () => {
    handleChoice(button.dataset.choice);
  });
});