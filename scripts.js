// Function to append the clicked button to the display
function appendToDisplay(value) {
    document.getElementById('display').value += value;
}

// Function to clear the display
function clearDisplay() {
    document.getElementById('display').value = '';
}

// Function to calculate the result
function calculate() {
    const display = document.getElementById('display');
    try {
        display.value = eval(display.value); // Evaluates the expression in the display
    } catch (error) {
        display.value = 'Error'; // Shows 'Error' if the calculation fails
    }
}
