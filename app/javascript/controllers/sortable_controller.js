import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".handle", // つまみ（ハンドル）となる要素のクラス名
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    // ここでドラッグが終わった後に、新しい並び順を裏側で保存する処理を後ほど追加します
    console.log("並び替えられたよ！", event.oldIndex, "から", event.newIndex)
  }
}