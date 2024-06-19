package control;

import model.Event;
import model.EventDAO;
import model.Ticket;
import model.TicketDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/event")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;
    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        Event event = eventDAO.getEventById(eventId);
        List<Ticket> tickets = ticketDAO.getTicketsByEventId(eventId);

        request.setAttribute("event", event);
        request.setAttribute("tickets", tickets);

        request.getRequestDispatcher("/event.jsp").forward(request, response);
    }
}
