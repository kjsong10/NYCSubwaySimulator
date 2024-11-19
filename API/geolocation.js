// geolocation.js
function getPlayerLocation() {
    return new Promise((resolve, reject) => {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                position => {
                    resolve({
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    });
                },
                error => reject(error),
                { enableHighAccuracy: true }
            );
        } else {
            reject("Geolocation is not supported by this browser.");
        }
    });
}
