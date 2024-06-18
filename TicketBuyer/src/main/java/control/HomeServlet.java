package control;

import model.Event;
import model.EventDAO;
import model.Order;
import model.OrderDAO;
import model.Review;
import model.ReviewDAO;
import model.Ticket;
import model.TicketDAO;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;
    private ReviewDAO reviewDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        reviewDAO = new ReviewDAO();
        orderDAO = new OrderDAO();
        System.out.println("HomeServlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("HomeServlet doGet called.");
        List<Event> events = eventDAO.getAllEvents();
        List<Review> reviews = reviewDAO.getAllReviews();
        
        request.setAttribute("reviews", reviews);
        request.setAttribute("events", events);

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}


