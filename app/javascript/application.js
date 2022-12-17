// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "my_script";

// https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete-addressform
// the following function executes when script from Places library, Maps JavaScript API is loaded
// the script is called with parameter callback=initMap to specify the callback function name
window.initMap = () => {
  console.log("map initialized");
};
