/*package control;

import model.Event;
import model.EventDAO;
import model.Ticket;
import model.TicketDAO;
import util.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
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

        String eventName = request.getParameter("eventName");
        String sortBy = "prezzo"; // Specifica il criterio di ordinamento per il prezzo del biglietto


        List<Event> events = eventDAO.searchEventsByName(eventName);


        List<Ticket> tickets = new ArrayList<>();
        for (Event event : events) {
            List<Ticket> eventTickets = ticketDAO.getTicketsByEventId(event.getId());
            tickets.addAll(eventTickets);
        }


        List<Object> searchResults = new ArrayList<>();
        searchResults.addAll(events);
        searchResults.addAll(tickets);


        Collections.sort(searchResults, new Comparator<Object>() {
            @Override
            public int compare(Object o1, Object o2) {
                double price1 = (o1 instanceof Event) ? ((Event) o1).getTicketPrice() : ((Ticket) o1).getPrice();
                double price2 = (o2 instanceof Event) ? ((Event) o2).getTicketPrice() : ((Ticket) o2).getPrice();
                return Double.compare(price1, price2);
            }
        });

        request.setAttribute("searchResults", searchResults);
        request.getRequestDispatcher("/WEB-INF/view/searchResults.jsp").forward(request, response);
    }
}
*/
