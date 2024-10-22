// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails"
import "controllers"
import 'select2'
import 'select2/dist/css/select2.css'

$(window).load(function() {
  $('.country-select').select2();
});
