
function showToast(message) {
    let toastElement = document.getElementById('successToast');
    toastElement.querySelector('.toast-body').innerHTML = message;
    let toast = new bootstrap.Toast(toastElement);
    toast.show();
}

window.addEventListener("load", () => {
    const element = document.querySelector("#locations");

    element.addEventListener("ajax:success", (event) => {
        const [_data, _status, xhr] = event.detail;
        let body = document.getElementById('locationsModalBody');
        body.innerHTML = _data.html;
        let modal = bootstrap.Modal.getInstance(document.getElementById('locationsModal'))
        modal.toggle();
        showToast("Successfully saved!")
    });
});