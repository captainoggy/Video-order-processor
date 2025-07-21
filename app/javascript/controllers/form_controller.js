import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "total", "modalTotal", "modal", "payButton", "cancelButton", "form"]

  connect() {
    this.updateTotal()
  }

  updateTotal() {
    let total = 0
    this.checkboxTargets.forEach(checkbox => {
      if (checkbox.checked) {
        total += parseFloat(checkbox.dataset.price)
      }
    })
    this.totalTarget.textContent = total.toFixed(2)
    this.modalTotalTarget.textContent = total.toFixed(2)
  }

  showModal(event) {
    event.preventDefault()
    this.modalTarget.classList.remove("hidden")
    this.modalTarget.classList.add("flex")
  }

  closeModal() {
    this.modalTarget.classList.add("hidden")
    this.modalTarget.classList.remove("flex")
  }

  closeOnOutsideClick(event) {
    if (event.target === this.modalTarget) {
      this.closeModal()
    }
  }

  submitForm() {
    this.formTarget.submit()
  }
}
