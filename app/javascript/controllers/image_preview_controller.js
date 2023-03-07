import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "output"]
  readInputs() {
    let input = this.inputTarget;
    let output = this.outputTarget;

    if (output.children.length) {
      let children = [...output.children]
      children.forEach((child) => {
        output.removeChild(child);
      })
    }

    if (input.files) {
      let images = [...input.files];

      images.forEach(async (image) => {
        let imageTag = document.createElement("img");
        imageTag.className = "preview-image";
        imageTag.src = await this.readFile(image);

        output.classList.add("image-active")
        output.appendChild(imageTag);
      })
    }
  }

  async readFile(file) {
    return new Promise((resolve, reject) => {
      let reader = new FileReader();

      reader.onload = () => {
        return resolve(reader.result);
      };

      reader.readAsDataURL(file);
    })
  }

}
