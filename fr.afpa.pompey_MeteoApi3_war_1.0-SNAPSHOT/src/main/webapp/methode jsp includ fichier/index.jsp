<%-- 
    Document   : index.jsp
    Created on : 19 janv. 2024, 06:18:40
    Author     : bulen
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Météo App</title>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h1 {
            color: #333;
        }

        #row1, #row2 {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            width: 80%;
            margin: 20px 0;
        }

        #row1 div, #row2 div {
            width: 48%;
            padding: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            margin-bottom: 20px;
        }

        #map-container {
            display: flex;
            justify-content: center;
            width: 100%;
        }

        #map {
            width: 50%;
            height: 300px;
        }

        #weatherContainer {
            display: flex;
            align-items: center;
        }

        #weatherIconContainer {
            background-color: #cccccc;
            padding: 10px;
            border-radius: 5px;
        }

        #weatherIcon {
            width: 50px;
            height: 50px;
        }

        #villeName {
            margin-left: 10px;
            font-weight: bold;
        }

        #currentDateTime {
            margin-left: 10px;
        }

        #hourlyForecast {
            display: flex;
            flex-wrap: wrap;
        }

        .hourly-forecast-item {
            width: 80%;
            margin-left: 0;
            margin-right: auto;
            text-align: center;
        }
    </style>

</head>
<body>
    <h1>Météo App</h1>

    <div id="row1">
        <div>
            <label for="ville">Entrez le nom de la ville : </label>
            <input type="text" id="ville" placeholder="Nom de la ville">
        </div>
        <div>
            <button onclick="afficherInformations()">Obtenir les informations météo</button>
        </div>
    </div>

    <div id="row2"></div>

    <div id="weatherContainer">
        <div id="weatherIconContainer">
            <img id="weatherIcon" src="" alt="Weather Icon">
        </div>
        <div>
            <div id="villeName"></div>
            <div id="currentDateTime"></div>
        </div>
    </div>

    <div id="map-container">
        <div id="map"></div>
    </div>

    <div id="hourlyForecast"></div>

    <script>
        const apiKey = "044fe62dd2d1435e9ec33614231412";

        async function recupererDonneesMeteo(ville) {
            try {
                const response = await fetch(
                    `https://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${ville}&aqi=no`
                );

                if (!response.ok) {
                    throw new Error(`Erreur de requête: ${response.status}`);
                }

                const data = await response.json();
                return data;
            } catch (error) {
                console.error(error.message);
            }
        }

        async function recupererPrevisionsHoraires(ville) {
            try {
                const response = await fetch(
                    `https://api.weatherapi.com/v1/forecast.json?key=${apiKey}&q=${ville}&days=1&aqi=no&hour=24`
                );

                if (!response.ok) {
                    throw new Error(`Erreur de requête: ${response.status}`);
                }

                const data = await response.json();
                return data.forecast.forecastday[0].hour;
            } catch (error) {
                console.error(error.message);
            }
        }

        function afficherInformations() {
            const villeInput = document.getElementById("ville");
            const villeName = document.getElementById("villeName");
            const currentDateTime = document.getElementById("currentDateTime");
            const row2Div = document.getElementById("row2");
            const mapDiv = document.getElementById("map");
            const weatherIcon = document.getElementById("weatherIcon");
            const hourlyForecastDiv = document.getElementById("hourlyForecast");

            // Réinitialiser le contenu des résultats
            row2Div.innerHTML = "";
            mapDiv.innerHTML = "";
            weatherIcon.src = "";
            hourlyForecastDiv.innerHTML = "";

            const ville = villeInput.value;
            villeName.textContent = ville; // Afficher le nom de la ville

            const now = new Date();
            const formattedDateTime = `${now.toLocaleDateString()} ${now.toLocaleTimeString()}`;
            currentDateTime.textContent = formattedDateTime; // Afficher la date et l'heure actuelles

            Promise.all([recupererDonneesMeteo(ville), recupererPrevisionsHoraires(ville)])
                .then(([currentData, hourlyData]) => {
                    row2Div.innerHTML += `<div>**Données météo pour ${currentData.location.name}**</div>`;
                    row2Div.innerHTML += `<div>Température : ${currentData.current.temp_c}°C</div>`;
                    row2Div.innerHTML += `<div>Température de la ville : ${currentData.location.temp_c}°C</div>`;
                    row2Div.innerHTML += `<div>Nom de la région : ${currentData.location.region}</div>`;
                    row2Div.innerHTML += `<div>Nom du pays : ${currentData.location.country}</div>`;
                    row2Div.innerHTML += `<div>Latitude : ${currentData.location.lat}</div>`;
                    row2Div.innerHTML += `<div>Longitude : ${currentData.location.lon}</div>`;
                    row2Div.innerHTML += `<div>ID du fuseau horaire : ${currentData.location.tz_id}</div>`;
                    row2Div.innerHTML += `<div>Heure locale (epoch) : ${currentData.location.localtime_epoch}</div>`;
                    row2Div.innerHTML += `<div>Heure locale : ${currentData.location.localtime}</div>`;

                    // Afficher la carte météo
                    mapDiv.innerHTML = `<iframe width="100%" height="300" frameborder="0" style="border:0" src="https://www.openstreetmap.org/export/embed.html?bbox=${currentData.location.lon},${currentData.location.lat},${currentData.location.lon},${currentData.location.lat}&layer=mapnik" allowfullscreen></iframe>`;

                    // Afficher l'icône météo
                    const iconUrl = `https:${currentData.current.condition.icon}`;
                    weatherIcon.src = iconUrl;

                    // Afficher les prévisions horaires
                    hourlyData.forEach(hour => {
                        const timestamp = new Date(hour.time_epoch * 1000);
                        const hourString = timestamp.getHours();
                        const temperature = hour.temp_c;
                        const iconUrl = `https:${hour.condition.icon}`;

                        hourlyForecastDiv.innerHTML += `
                            <div class="hourly-forecast-item">
                                <div>${hourString}:00</div>
                                <img src="${iconUrl}" alt="Hourly Weather Icon" width="60" height="60">
                                <div>${temperature}°C</div>
                            </div>`;
                    });
                });
        }
    </script>
</body>
</html>
