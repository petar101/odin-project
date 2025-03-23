document.addEventListener('DOMContentLoaded', function() {
  const display = document.querySelector('.display');
  const buttons = document.querySelectorAll('.cell');

  maxvalue = 12

  buttons.forEach(button => {
      button.addEventListener('click', function() {
          const value = button.innerText;

          if (value === "AC") {
              display.innerText = "";
          } else {
          
          if (display.innerText.length < maxLength) {
            display.innerText += value;
          }
          }
          
      });
  });


  


});

