import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-event"
export default class extends Controller {
  static targets = ["locationTab", "categoryTab", "dateButton", "locationButton"]
  connect() {
    console.log("connected to new form controller")
  }
  showLocation(e) {
    e.preventDefault()
    console.log(e)
    this.locationTabTarget.click()
  }
  showCategory(e) {
    e.preventDefault()
    console.log(e)
    this.categoryTabTarget.click()
  }
}
