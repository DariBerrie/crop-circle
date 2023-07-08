import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object
  }
  connect() {
    console.log("Map controller is on.")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [this.markerValue.longitude, this.markerValue.latitude],
      zoom: 12
    })

    const marker = new mapboxgl.Marker({ color: "#4C7835" })
        .setLngLat([this.markerValue.longitude, this.markerValue.latitude])
        .addTo(this.map)
  }
}
