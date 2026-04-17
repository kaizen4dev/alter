import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link"
export default class extends Controller {
  static targets = ["copyBtn"]
  static values = { url: String }

  copyURL() {
    navigator.clipboard.writeText(this.urlValue)
    this.copyBtnTarget.textContent = "Copied"
    setTimeout(() => { this.copyBtnTarget.textContent = "Copy" }, 2000)
  }
}
