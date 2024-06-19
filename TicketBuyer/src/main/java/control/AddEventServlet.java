package control;

import model.Event;
import model.EventDAO;
import model.Ticket;
import model.TicketDAO;
import model.TipoEvento;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;

@WebServlet("/admin/addEvent")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddEventServlet extends HttpServlet {
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
        request.getRequestDispatcher("/admin/addEvent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String luogo = request.getParameter("luogo");
        Date dataEvento = Date.valueOf(request.getParameter("dataEvento"));
        String orario = request.getParameter("orario");
        String tipo = request.getParameter("tipo");
        int disponibilita = Integer.parseInt(request.getParameter("disponibilita"));

        String fileName = uploadImage(request);

        Event newEvent = new Event();
        newEvent.setNome(nome);
        newEvent.setLuogo(luogo);
        newEvent.setDataEvento(dataEvento);
        newEvent.setOrario(orario);
        newEvent.setTipo(TipoEvento.fromString(tipo));
        newEvent.setDisponibilita(disponibilita);
        newEvent.setImage(fileName);

        int eventId = eventDAO.addEvent(newEvent);
        System.out.println("Lol.");

        String[] tipiBiglietto = {"Standard", "VIP"};
        double[] prezzi = {50.0, 100.0};

        for (int i = 0; i < tipiBiglietto.length; i++) {
            Ticket ticket = new Ticket();
            ticket.setCodiceEvento(eventId);
            ticket.setTipo(tipiBiglietto[i]);
            ticket.setDescrizione("Biglietto " + tipiBiglietto[i] + " per l'evento " + eventId);
            ticket.setPrezzoUnitario(prezzi[i]);
            ticketDAO.addTicket(ticket);
        }

        response.sendRedirect("manageEvents");
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("") + File.separator + "img";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            filePart.write(uploadDir + File.separator + fileName);
            return fileName;
        }
        return null;
    }
}
