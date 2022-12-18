// https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete-addressform
// the following function executes when script from Places library, Maps JavaScript API is loaded
// the script is called with parameter callback=initMap to specify the callback function name
window.initMap = () => {
  console.log("Map Initialized. Dispatching event mapLoadedEvent...");

  const mapLoadedEvent = new Event("mapLoadedEvent");
  // Depreciated
  // mapLoadedEvent.initEvent("map-loaded", true, true);
  window.dispatchEvent(mapLoadedEvent);

  setTimeout(function () {
    // the above event is dispatched before the event listener is created
    // so I am delaying dispatching the event:
    window.dispatchEvent(mapLoadedEvent);
  }, 2000);
};
