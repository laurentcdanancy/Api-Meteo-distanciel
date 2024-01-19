/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fr.afpa.pompey.meteoapi3.data;

/**
 *
 * @author bulen
 */
public class MeteoData {
    private String location;
    private String temperature;
    private String weatherType;
    private String humidity;
    private String windSpeed;

    // Constructeur avec tous les champs
    public MeteoData(String location, String temperature, String weatherType, String humidity, String windSpeed) {
        this.location = location;
        this.temperature = temperature;
        this.weatherType = weatherType;
        this.humidity = humidity;
        this.windSpeed = windSpeed;
    }

    // Getters et Setters

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getWeatherType() {
        return weatherType;
    }

    public void setWeatherType(String weatherType) {
        this.weatherType = weatherType;
    }

    public String getHumidity() {
        return humidity;
    }

    public void setHumidity(String humidity) {
        this.humidity = humidity;
    }

    public String getWindSpeed() {
        return windSpeed;
    }

    public void setWindSpeed(String windSpeed) {
        this.windSpeed = windSpeed;
    }
}
