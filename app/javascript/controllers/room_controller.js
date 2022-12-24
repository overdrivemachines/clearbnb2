import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="room"
// located in app/views/host/rooms/_form.html.erb
export default class extends Controller {
  // this.bedFieldsTarget, this.bedsTarget
  static targets = ["bedFields", "beds"];
  connect() {
    console.log("room connected");
    this.count = 0;
    // this.el = document.querySelector(".notice");
    // console.log(this.el);
  }

  addBed(e) {
    e.preventDefault();

    // console.log(this.bedFieldsTarget);
    console.log(this.count);

    // Insert the contents of <template data-room-target="bedFields"> ... </template> (this.bedFieldsTarget)
    // to <fieldset data-room-target="beds"> ... </fieldset> (this.bedsTarget)
    this.bedsTarget.insertAdjacentHTML("beforeend", this.bedFieldsTarget.innerHTML);

    // div.select-bed-container
    this.el = document.querySelector(".select-bed-container");

    // label element inside of el
    this.labelEl = this.el.querySelector("label");
    // select element inside of el
    this.selectEl = this.el.querySelector("select");

    // Change the for attribute for the label to for=room_beds_attributes_123_bed_size
    this.labelEl.setAttribute("for", "room_beds_attributes_" + this.count + "_bed_size");
    // Change the name attribute for the select to name=room[beds_attributes][123][bed_size]
    this.selectEl.setAttribute("name", "room[beds_attributes][" + this.count + "][bed_size]");
    // Change the id attribute for the select to id=room_beds_attributes_123_bed_size
    this.selectEl.setAttribute("id", "room_beds_attributes_" + this.count + "_bed_size");

    // console.log(this.labelEl);
    // console.log(this.selectEl);

    // change classname from div.select-bed-container to div.select-bed-container-123
    this.el.classList.add("select-bed-container-" + this.count);
    this.el.classList.remove("select-bed-container");

    // increament the counter
    this.count++;
  }
}
