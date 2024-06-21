package control;

import model.Event;
import model.EventDAO;
import model.Ticket;
import model.TicketDAO;
import util.InputSanitizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageEvents")
public class AdminEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;
    private TicketDAO ticketDAO;
    private Ticket ticket;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Event> events = eventDAO.getAllEvents();
        request.setAttribute("events", events);
        request.getRequestDispatcher("/admin/manageEvents.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = InputSanitizer.sanitize(request.getParameter("action"));
        if (action != null && action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("eventID"));
            List<Ticket> tickets = ticketDAO.getTicketsByEventId(id);
            for(Ticket ticket : tickets) {
            	ticketDAO.deleteTicket(ticket.getCodiceBiglietto());
            }
            eventDAO.deleteEvent(id);
        }
        response.sendRedirect("manageEvents");
    }
}

