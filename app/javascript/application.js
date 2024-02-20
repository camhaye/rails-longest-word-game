// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const letters = document.querySelectorAll('li a')
const input = document.getElementById("inpt")

letters.forEach(letter => {
  letter.addEventListener("click", (event) => {
    event.preventDefault()
    const ltr = letter.innerText
    input.value += ltr
    letter.classList.add("disabled")
  });
});
