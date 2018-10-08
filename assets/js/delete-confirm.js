class DeleteAlbumConfirm {
  constructor() {
    this.deleteBtn = document.querySelector('[data-delete-link]')
    this.deleteUrl = this.deleteBtn.getAttribute('data-delete-link')
    this.message = this.deleteBtn.getAttribute('data-delete-link-message')

    this.bindEvents()
  }

  bindEvents () {
    if (this.deleteBtn && this.deleteUrl && this.message) {
      this.deleteBtn.addEventListener('click', () => {
        if (window.confirm(this.message)) {
          window.location.href = this.deleteUrl
        }
      })
    }
  }
}

new DeleteAlbumConfirm
