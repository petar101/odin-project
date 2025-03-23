document.addEventListener("DOMContentLoaded", () => {
    duplicateCell(16, 16); // Default grid size
    setupHoverEffect();
});

function duplicateCell(across, down) {
    const container = document.querySelector(".container");
    container.innerHTML = ""; // Clear previous grid before creating a new one

    for (let i = 0; i < down; i++) {
        for (let j = 0; j < across; j++) {
            const cell = document.createElement("div");
            cell.classList.add("cell");
            container.appendChild(cell);
            container.style.gridTemplateColumns = `repeat(${across}, 1fr)`;
            container.style.gridTemplateRows = `repeat(${down}, 1fr)`;

            if (i === 0 && j === Math.floor(across/2)) {
                const button = document.createElement("button");
                button.classList.add("button");
                button.textContent = "Click Me";
                cell.appendChild(button);

                // Attach event listener to the button
                button.addEventListener("click", changeGrid);
            }
        }
    }

    setupHoverEffect(); // Reapply hover effect after grid update
}

function setupHoverEffect() {
    const cells = document.querySelectorAll(".cell");

    cells.forEach(cell => {
        cell.addEventListener("mouseenter", () => {
            cell.style.backgroundColor = "#ffffff";
        });

        cell.addEventListener("mouseleave", () => {
            cell.style.backgroundColor = "#0c2623";
        });
    });
}

function changeGrid() {
    let gridacross = Number(prompt("How many across?"));
    let griddown = Number(prompt("How many down?"));

    if (gridacross > 100 || griddown > 100) {
        alert("Please enter a number less than 100");
    } else if (gridacross > 0 && griddown > 0) {
        duplicateCell(gridacross, griddown); // Update grid with new size
    } else {
        alert("Please enter a valid number greater than 0.");
    }
}
