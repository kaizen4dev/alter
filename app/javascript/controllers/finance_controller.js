import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="finance"
export default class extends Controller {
  static values = { sourceAccount: String, destinationAccount: String };

  toggleSourceAccount(e) {
    e.preventDefault()

    // remove styles for previously selected account of same type
    if (this.sourceAccountValue && (this.sourceAccountValue != e.target.id)) {
      let prev = document.getElementById(this.sourceAccountValue)
      prev.classList.remove("has-text-danger")
    }

    // remove another type styles
    e.target.classList.remove("has-text-success")

    // toggle current type styles
    e.target.classList.toggle("has-text-danger")

    // toggle values
    this.sourceAccountValue = this.sourceAccountValue == e.target.id ? "" : e.target.id
    this.destinationAccountValue = this.destinationAccountValue == e.target.id ? "" : this.destinationAccountValue
  }

  toggleDestinationAccount(e) {
    e.preventDefault()

    // remove styles for previously selected account of same type
    if (this.destinationAccountValue && (this.destinationAccountValue != e.target.id)) {
      let prev = document.getElementById(this.destinationAccountValue)
      prev.classList.remove("has-text-success")
    }

    // remove another type styles
    e.target.classList.remove("has-text-danger")

    // toggle current type styles
    e.target.classList.toggle("has-text-success")

    // toggle values
    this.destinationAccountValue = this.destinationAccountValue == e.target.id ? "" : e.target.id
    this.sourceAccountValue = this.sourceAccountValue == e.target.id ? "" : this.sourceAccountValue

  }

  newTransaction(e) {
    e.preventDefault()

    let button = e.target
    let srcParam = "?source=" + this.sourceAccountValue.slice(this.sourceAccountValue.indexOf("_") + 1)
    let destParam = "&destination=" + this.destinationAccountValue.slice(this.destinationAccountValue.indexOf("_") + 1)

    Turbo.visit(button.attributes.href.textContent + srcParam + destParam)
  }

  editAccount(e) {
    e.preventDefault()

    if(e.button == 1) {
      let accountId = e.target.id.slice(e.target.id.indexOf("_") + 1)
      Turbo.visit(window.location.href + `/accounts/${accountId}/edit`)
    }
  }
}
