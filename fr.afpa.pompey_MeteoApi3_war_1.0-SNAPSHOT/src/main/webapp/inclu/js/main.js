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