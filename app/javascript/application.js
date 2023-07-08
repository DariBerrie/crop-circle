// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "chartkick"
import "Chart.bundle"

document.addEventListener("click", function(event) {
    if (event.target.matches('[data-toggle="custom-collapse"]')) {
        const target = document.querySelector(event.target.getAttribute("data-target"));
        target.classList.toggle("full-length");
        event.target.innerHTML = target.classList.contains("full-length") ? "Show Less" : "Show More";
    }
});