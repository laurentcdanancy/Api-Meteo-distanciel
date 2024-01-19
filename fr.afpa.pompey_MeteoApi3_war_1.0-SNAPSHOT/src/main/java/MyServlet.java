import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/WeatherServlet")
public class MyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String apiKey = "044fe62dd2d1435e9ec33614231412";
        String ville = request.getParameter("ville");

        // Call the method to retrieve weather data
        String data = recupererDonneesMeteo(apiKey, ville);

        // Set the data as an attribute in the request
        request.setAttribute("weatherData", data);

        // Forward the request to index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private String recupererDonneesMeteo(String apiKey, String ville) {
        try {
            String apiUrl = "https://api.weatherapi.com/v1/current.json?key=" + apiKey + "&q=" + ville + "&aqi=no";

            java.net.URL url = new java.net.URL(apiUrl);
            java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
            }

            java.util.Scanner scanner = new java.util.Scanner(url.openStream());
            StringBuilder response = new StringBuilder();

            while (scanner.hasNext()) {
                response.append(scanner.nextLine());
            }

            scanner.close();
            conn.disconnect();

            return response.toString();
        } catch (IOException e) {
            return "{\"error\":\"" + e.getMessage() + "\"}";
        }
    }
}
