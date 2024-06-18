package control;

import model.Event;
import model.EventDAO;
import model.Review;
import model.ReviewDAO;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/event")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        Event event = eventDAO.getEventById(eventId);
        List<Review> reviews = reviewDAO.getReviewsByEventId(eventId);

        HttpSession session = request.getSession();
        Utente user = (Utente) session.getAttribute("user");

        if (event != null) {
            request.setAttribute("event", event);
            request.setAttribute("reviews", reviews);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/event.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Evento non trovato");
        }
    }
}

