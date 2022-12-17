import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // this gets executed when there is a html element that has attribute
    // data-controller="address"
    // app/views/host/listings/new.html.erb
    console.log("Address controller is connected");
  }

  initGoogle() {
    // setup autocomplete
  }

  placeSelected() {
    // use values from autocomplete
  }
}
