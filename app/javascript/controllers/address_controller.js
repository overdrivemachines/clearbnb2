import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "address_line1", "address_line2", "city", "state", "postal_code", "country", "latitude", "longitude"];
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

    // this.inputTarget refers to the html element having attribute: data-address-target="input"
    this.autocomplete = new google.maps.places.Autocomplete(this.inputTarget, {
      componentRestrictions: { country: ["us", "ca"] },
      fields: ["address_components", "geometry"],
      types: ["address"],
    });

    // When the user selects an address from the drop-down, call placeSelected()
    // which populates the fields in the form like address_line1, address_line2, etc.
    this.autocomplete.addListener("place_changed", this.placeSelected.bind(this));
  }

  placeSelected() {
    // https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete-addressform
    // Get the place details from the autocomplete object.
    const place = this.autocomplete.getPlace();
    let address1 = "";
    let postcode = "";
    console.log(place);

    // Get each component of the address from the place details,
    // and then fill-in the corresponding field on the form.
    // place.address_components are google.maps.GeocoderAddressComponent objects
    // which are documented at http://goo.gle/3l5i5Mr
    for (const component of place.address_components) {
      // string: "street_number" or "route" etc.
      const componentType = component.types[0];

      switch (componentType) {
        case "street_number": {
          address1 = `${component.long_name} ${address1}`;
          break;
        }

        case "route": {
          address1 += component.short_name;
          break;
        }

        case "postal_code": {
          postcode = `${component.long_name}${postcode}`;
          break;
        }

        case "postal_code_suffix": {
          postcode = `${postcode}-${component.long_name}`;
          break;
        }
        case "locality":
          // document.querySelector("#listing_city").value = component.long_name;
          this.cityTarget.value = component.long_name;
          break;
        case "administrative_area_level_1": {
          // document.querySelector("#listing_state").value = component.short_name;
          this.stateTarget.value = component.short_name;
          break;
        }
        case "country":
          // document.querySelector("#listing_country").value = component.long_name;
          this.countryTarget.value = component.long_name;
          break;
      }
    }

    // Updating Address Line 1 and Postal Code in the form
    // document.querySelector("#listing_address_line1").value = address1;
    this.address_line1Target.value = address1;
    // document.querySelector("#listing_postal_code").value = postcode;
    this.postal_codeTarget.value = postcode;

    // Updating Latitude and Longitude in the form
    // document.querySelector("#listing_latitude").value = place.geometry.location.lat();
    this.latitudeTarget.value = place.geometry.location.lat();
    // document.querySelector("#listing_longitude").value = place.geometry.location.lng();
    this.longitudeTarget.value = place.geometry.location.lng();
  }
}
