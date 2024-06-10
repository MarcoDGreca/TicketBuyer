package control;

import model.Event;
import model.EventDAO;
import model.Utente;
import util.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/feed")
public class FeedServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente user = (Utente) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        List<Event> events = eventDAO.getEventByLocation(user.getIndirizzo());
        request.setAttribute("events", events);
        request.getRequestDispatcher("/WEB-INF/view/feed.jsp").forward(request, response);
    }
}

