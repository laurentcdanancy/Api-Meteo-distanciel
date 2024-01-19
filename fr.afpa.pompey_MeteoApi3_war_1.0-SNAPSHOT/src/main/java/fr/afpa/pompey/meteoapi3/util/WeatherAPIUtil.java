/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fr.afpa.pompey.meteoapi3.util;

/**
 *
 * @author bulen
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class WeatherAPIUtil {
    private static final String API_KEY = "    const apiKey = \"044fe62dd2d1435e9ec33614231412\";\n" +
""; // Remplacez par votre clé API

    public static String getWeatherData(String city) throws IOException {
        String apiUrl = "https://api.weatherapi.com/v1/current.json";
        String encodedCity = URLEncoder.encode(city, "UTF-8");

        URL url = new URL(apiUrl + "?key=" + API_KEY + "&q=" + encodedCity + "&aqi=no");

        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder response = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            response.append(line);
        }

        reader.close();
        connection.disconnect();

        return response.toString();
    }
}