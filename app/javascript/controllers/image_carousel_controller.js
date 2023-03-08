import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="image-carousel"
export default class extends Controller {
  static targets = ['slide', 'counter'];
  static values = { index: { type: Number, default: 0 } };

  next() {
    if (this.indexValue < this.slideTargets.length - 1) {
      this.indexValue++;
    } else {
      this.indexValue = 0;
    }
    this.counterTarget.innerHTML = `${this.indexValue + 1} / ${
      this.slideTargets.length
    }`;
  }

  previous() {
    if (this.indexValue == 0) {
      this.indexValue = this.slideTargets.length - 1;
    } else {
      this.indexValue--;
    }
    this.counterTarget.innerHTML = `${this.indexValue + 1} / ${
      this.slideTargets.length
    }`;
  }

  indexValueChanged() {
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue;
    });
  }
}
