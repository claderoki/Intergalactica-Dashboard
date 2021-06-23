
function showToast(message) {
    let toastElement = document.getElementById('successToast');
    toastElement.querySelector('.toast-body').innerHTML = message;
    let toast = new bootstrap.Toast(toastElement);
    toast.show();
}

window.addEventListener("load", () => {
    const element = document.querySelector("#scenarios");

    element.addEventListener("ajax:success", (event) => {
        const [_data, _status, xhr] = event.detail;
        for (const [key, value] of Object.entries(_data.references)) {
            document.getElementById(key).setAttribute('value', value);
        }

        showToast("Successfully saved!")
    });
});