package fr.afpa.pompey.meteoapi3.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import fr.afpa.pompey.meteoapi3.data.MeteoData;

@WebServlet("/MeteoServlet")
public class MeteoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simuler des données météorologiques pour l'exemple
        MeteoData meteoData = new MeteoData("Bristol", "25°C", "Sunny", "50%", "10 km/h");

        // Convertir l'objet MeteoData en format JSON
        Gson gson = new Gson();
        String jsonMeteoData = gson.toJson(meteoData);

        // Écrire la réponse JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonMeteoData);
        out.flush();
    }
}
