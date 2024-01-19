<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500&family=Oxygen+Mono&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="css/styles.css" />
        <title>Weather App</title>
    </head>
    <body>
        <main>
            <!-- search bar and city name -->
            <section class="container">
                <div class="row">
                    <form class="col" id="search-form">
                        <input
                            type="text"
                            id="search-input"
                            aria-describedby="searchCity"
                            placeholder="Search city..."
                            class="search-form"
                            autocomplete="off"
                            />
                        <button type="submit">Search</button>
                    </form>
                    <h1
                        class="col d-flex justify-content-center align-items-center city-title"
                        id="searched-city"
                        >
                        <%= (request.getAttribute("weatherData") != null) ?
                            ((Map<String, String>) request.getAttribute("weatherData")).get("location") :
                            "Bristol"
                        %>
                    </h1>
                </div>
                <span class="measurements">
                    <a href="#" id="celcius-link">C°</a> |
                    <a href="#" id="fahrenheit-link">F°</a>
                </span>
            </section>

            <!-- temp and day info -->
            <section class="current-weather">
                <div class="container">
                    <div class="row">
                        <h1 class="col temp-title" id="current-temperature">
                            <%= (request.getAttribute("weatherData") != null) ?
                                ((Map<String, String>) request.getAttribute("weatherData")).get("temperature") + "°C" :
                                "4°"
                            %>
                        </h1>
                        <div class="col todays-info">
                            <p id="current-time">
                                <%= (request.getAttribute("weatherData") != null) ?
                                    formatTime(new java.util.Date()) :
                                    "12:00"
                                %>
                            </p>
                            <h2 id="current-day">
                                <%= (request.getAttribute("weatherData") != null) ?
                                    formatDay(new java.util.Date()) :
                                    "Monday"
                                %>
                            </h2>
                            <p id="weather-type">
                                <%= (request.getAttribute("weatherData") != null) ?
                                    ((Map<String, String>) request.getAttribute("weatherData")).get("weather_type") :
                                    "Sunny"
                                %>
                            </p>
                        </div>
                        <div class="col d-flex align-items-center side-info">
                            <ul>
                                <li>Humidity: <span id="humidity">
                                        <%= (request.getAttribute("weatherData") != null) ?
                                            ((Map<String, String>) request.getAttribute("weatherData")).get("humidity") :
                                            "50%"
                                        %>
                                    </span></li>
                                <li>Wind: <span id="wind">
                                        <%= (request.getAttribute("weatherData") != null) ?
                                            ((Map<String, String>) request.getAttribute("weatherData")).get("wind_speed") + "km/h" :
                                            "10km/h"
                                        %>
                                    </span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <hr />
            </section>

            <!-- 5 day forecast -->
            <section class="container">
                <div class="row week-forecast">
                    <!-- Add your 5-day forecast HTML here -->
                </div>
            </section>

            <footer class="bg-primary text-light py-3">
                <div class="container text-center">
                    <p>&copy; 2024 Your Météo App</p>
                </div>
            </footer>

