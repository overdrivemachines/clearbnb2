import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // this gets executed when there is a html element that has attribute
    // data-controller="address"
    // app/views/host/listings/new.html.erb
    console.log("Address controller is connected");
  }

  // The following function gets executed only when function initMap() in my_script.js is executed
  // and
  // there is a div on the page that has attribute: data-action="mapLoadedEvent@window->address#initGoogle"
  initGoogle(event) {
    // setup autocomplete
    console.log("Google Maps is initialized and address controller knows about it");

    // let addressField = document.querySelector("#listing_address");
    // console.log(addressField);
  }

  placeSelected() {
    // use values from autocomplete
  }
}
