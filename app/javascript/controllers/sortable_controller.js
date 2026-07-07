import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".handle",
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    const moveUrl = event.item.dataset.moveUrl
    if (!moveUrl) return

    fetch(moveUrl, {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ position: event.newIndex })
    })
  }
}