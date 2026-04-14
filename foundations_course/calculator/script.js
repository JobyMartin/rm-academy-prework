
document.addEventListener("DOMContentLoaded", () => {
  const display = document.getElementById("display")
  const equalsButton = document.getElementById("equals")
  const clearButton = document.getElementById("clear")
  const buttons = document.querySelectorAll(".btn")
  const operators = document.querySelectorAll(".operator")

  let firstNumber = ""
  let operator = ""
  let secondNumber = ""
  let shouldResetDisplay = false

  equalsButton.addEventListener("click", calculate)

  buttons.forEach(btn => {
    const value = btn.dataset.value

    if (btn.classList.contains("operator")) {
      btn.addEventListener("click", () => handleOperator(value, btn))
    } else if (btn.id !== "equals") {
      btn.addEventListener("click", () => handleNumber(value))
    }
  })

  function handleNumber(value) {
    operators.forEach(op => op.style.backgroundColor = "#F3A71B")

    if (shouldResetDisplay) {
      display.value = ""
      shouldResetDisplay = false
    }

    display.value += value

    if (!operator) {
      firstNumber += value
    } else {
      secondNumber += value
    }
  }

  function handleOperator(value, btn) {
    btn.style.backgroundColor = "#C78915"

    if (firstNumber === "") return

    if (secondNumber !== "") {
      calculate()
    }

    operator = value
    shouldResetDisplay = true
  }

  function calculate() {
    if (!firstNumber || !operator || !secondNumber) return

    const a = Number(firstNumber)
    const b = Number(secondNumber)

    let result

    switch (operator) {
      case "+":
        result = add(a, b)
        break
      case "-":
        result = subtract(a, b)
        break
      case "*":
        result = multiply(a, b)
        break
      case "/":
        result = divide(a, b)
        if (result === null) {
          display.value = "Error"
          firstNumber = ""
          operator = ""
          secondNumber = ""
          return
        }
        break
    }

    display.value = result
    firstNumber = result.toString()
    operator = ""
    secondNumber = ""
  }

  clearButton.addEventListener("click", clear)
  
  function clear() {
    firstNumber = ""
    operator = ""
    secondNumber = ""
    shouldResetDisplay = false
    display.value = ""
  }
})

function add(a, b) {
  return a + b
}

function subtract(a, b) {
  return a - b
}

function multiply(a, b) {
  return a * b
}

function divide(a, b) {
  if (b === 0) return null
  return a / b
}
