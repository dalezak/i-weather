import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["form", "latitude", "longitude", "error", "info"];

  locate(event) {
    event.preventDefault();
    if (navigator.geolocation) {
      this.infoTarget.textContent = "Detecting your location...";
      this.errorTarget.textContent = "";
      navigator.geolocation.getCurrentPosition(
        this.handleSuccess.bind(this),
        this.handleError.bind(this)
      )
    } 
    else {
      this.infoTarget.textContent = "";
      this.errorTarget.textContent = "Geolocation is not supported by this browser.";
    }
  }
  
  handleSuccess(position) {
    this.infoTarget.textContent = "";
    this.errorTarget.textContent = "";
    this.latitudeTarget.value = position.coords.latitude;
    this.longitudeTarget.value = position.coords.longitude;
    this.formTarget.requestSubmit();
  }

  handleError(error) {
    this.infoTarget.textContent = "";
    this.errorTarget.textContent = `There was a problem detecting your location: ${error.message}`;
  }

}
