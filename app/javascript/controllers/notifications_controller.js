import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  delete(e){
    e.target.parentNode.remove()
  }
}
