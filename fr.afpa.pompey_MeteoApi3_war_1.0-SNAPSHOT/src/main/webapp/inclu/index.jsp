<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styles.css">
    <title>Météo App</title>
</head>
<body>
    <h1>Météo App</h1>
   <%@ include file="template/header.html" %>
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
    <%@ include file="template/footer.html" %>

    <script src="js/main.js"></script>
</body>
</html>


