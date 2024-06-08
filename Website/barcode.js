const codeReader = new ZXing.BrowserBarcodeReader();
const video = document.getElementById('video');
const barcodeInput = document.getElementById('barcode');
const addMoreButton = document.getElementById('add-more');
const itemList = document.getElementById('item-list');
const dateTimeElement = document.getElementById('date-time');

let scanning = false;

function startScanner() {
    codeReader
        .getVideoInputDevices()
        .then(videoInputDevices => {
            if (videoInputDevices.length > 0) {
                const firstDeviceId = videoInputDevices[0].deviceId;
                codeReader
                    .decodeFromVideoDevice(firstDeviceId, 'video', (result, err) => {
                        if (result) {
                            barcodeInput.value = result.text;
                            addItemToList(result.text);
                            stopScanner();
                        }
                        if (err && !(err instanceof ZXing.NotFoundException)) {
                            console.error(err);
                        }
                    })
                    .catch(err => console.error(err));
            } else {
                console.error('No video devices found');
            }
        })
        .catch(err => console.error(err));
}

function stopScanner() {
    codeReader.reset();
    video.style.display = 'none';
    scanning = false;
}

function addItemToList(barcode) {
    const listItem = document.createElement('li');
    listItem.textContent = barcode;
    itemList.appendChild(listItem);
}

function updateDateTime() {
    const now = new Date();
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    const date = now.toLocaleDateString(undefined, options);
    const time = now.toLocaleTimeString();

    dateTimeElement.textContent = ` ${date} ${'\xa0'.repeat(80)} ${time}`;
}

addMoreButton.addEventListener('click', () => {
    if (!scanning) {
        video.style.display = 'block';
        startScanner();
        scanning = true;
    }
});

document.addEventListener('DOMContentLoaded', (event) => {
    updateDateTime();
    setInterval(updateDateTime, 1000); // Update the date and time every second
});
