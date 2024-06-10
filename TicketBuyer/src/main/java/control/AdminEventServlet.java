package control;

import model.*;
import util.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/events")
public class AdminEventServlet extends HttpServlet {
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

        if (user == null || !user.getRuolo().equals("Admin")) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "delete":
                    deleteEvent(request, response);
                    break;
                case "edit":
                    editEvent(request, response);
                    break;
                case "add":
                    showNewForm(request, response);
                    break;
                default:
                    listEvents(request, response);
                    break;
            }
        } else {
            listEvents(request, response);
        }
    }

    private void listEvents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("events", eventDAO.getAllEvents());
        request.getRequestDispatcher("/WEB-INF/view/admin/eventList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/admin/eventForm.jsp").forward(request, response);
    }

    private void editEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int codiceEvento = Integer.parseInt(request.getParameter("codiceEvento"));
        Event existingEvent = eventDAO.getEventById(codiceEvento);
        request.setAttribute("event", existingEvent);
        request.getRequestDispatcher("/WEB-INF/view/admin/eventForm.jsp").forward(request, response);
    }

    private void deleteEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int codiceEvento = Integer.parseInt(request.getParameter("codiceEvento"));
        eventDAO.deleteEvent(codiceEvento);
        response.sendRedirect("events");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String luogo = request.getParameter("luogo");
        String dataEvento = request.getParameter("dataEvento");
        String orario = request.getParameter("orario");
        String tipo = request.getParameter("tipo");
        String disponibilita = request.getParameter("disponibilita");

        Event event = new Event();
        event.setNome(nome);
        event.setLuogo(luogo);
        event.setDataEvento(java.sql.Date.valueOf(dataEvento));
        event.setOrario(orario);
        event.setTipo(TipoEvento.fromString(tipo));
        event.setDisponibilita(Integer.parseInt(disponibilita));

        String codiceEvento = request.getParameter("codiceEvento");
        if (codiceEvento == null || codiceEvento.isEmpty()) {
            eventDAO.addEvent(event);
        } else {
            event.setCodiceEvento(Integer.parseInt(codiceEvento));
            eventDAO.updateEvent(event);
        }

        response.sendRedirect("events");
    }
}

