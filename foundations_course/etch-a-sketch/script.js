const defaultGridSize = 16

function createGrid(size) {
  const grid = document.getElementById('grid')
  grid.innerHTML = ''
  grid.style.setProperty('--grid-size', size)

  for (let i = 0; i < size * size; i += 1) {
    const cell = document.createElement('div')
    cell.className = 'cell'
    cell.style.opacity = 0.1

    cell.addEventListener('mouseover', () => {
      cell.style.opacity = Number(cell.style.opacity) + 0.1
    })

    grid.appendChild(cell)
  }
}

function promptForSize() {
  const gridSizeInput = document.getElementById('gridSizeInput')

  if (!gridSizeInput) {
    alert('Grid size input not found.')
    return
  }

  const size = Number(gridSizeInput.value)

  if (!Number.isInteger(size) || size < 4 || size > 100) {
    alert('Please enter a whole number between 4 and 100.')
    return
  }

  createGrid(size)
}

function clearGrid() {
  const cells = document.querySelectorAll('.cell')
  cells.forEach(cell => {
    cell.style.opacity = 0.1
  })
}

document.addEventListener('DOMContentLoaded', () => {
  const resizeButton = document.getElementById('resizeButton')
  resizeButton.addEventListener('click', promptForSize)
  const clearButton = document.getElementById('clearButton')
  clearButton.addEventListener('click', clearGrid)
  createGrid(defaultGridSize)
})
