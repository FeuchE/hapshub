// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


document.addEventListener("turbo:click", function (e) {
  const link = e.target.closest("a[data-method='delete'][data-confirm]");
  if (link) {
    const confirmMessage = link.dataset.confirm;
    if (!window.confirm(confirmMessage)) {
      e.preventDefault();
    }
  }
});
