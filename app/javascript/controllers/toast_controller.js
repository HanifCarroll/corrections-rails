import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.showToasts()
  }

  showToasts() {
    this.containerTarget.classList.remove("hidden")
    this.containerTarget.classList.add("animate-fade-in-down")

    setTimeout(() => {
      this.closeToasts()
    }, 5000)
  }

  closeToasts() {
    this.containerTarget.classList.remove("animate-fade-in-down")
    this.containerTarget.classList.add("animate-fade-out-up")

    setTimeout(() => {
      this.containerTarget.remove()
    }, 500)
  }

  closeToast(event) {
    event.preventDefault()
    const toast = event.target.closest(".toast")
    toast.classList.remove("animate-fade-in-down")
    toast.classList.add("animate-fade-out-up")

    setTimeout(() => {
      toast.remove()
      if (this.containerTarget.children.length === 0) {
        this.containerTarget.remove()
      }
    }, 500)
  }
}