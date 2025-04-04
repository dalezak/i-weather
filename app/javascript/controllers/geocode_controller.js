import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["form", "latitude", "longitude", "address", "error"];

  locate(event) {
    event.preventDefault();
    this.errorTarget.textContent = "";
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        this.handleSuccess.bind(this),
        this.handleError.bind(this)
      )
    } 
    else {
      this.errorTarget.textContent = "Geolocation is not supported by this browser.";
    }
  }
  
  handleSuccess(position) {
    this.latitudeTarget.value = position.coords.latitude;
    this.longitudeTarget.value = position.coords.longitude;
    this.formTarget.submit();
  }

  handleError(error) {
    this.errorTarget.textContent = `There was a problem detecting your location: ${error.message}`;
  }

}
