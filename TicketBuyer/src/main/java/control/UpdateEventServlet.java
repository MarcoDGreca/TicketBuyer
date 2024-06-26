package control;

import model.Event;
import model.EventDAO;
import model.Ticket;
import model.TicketDAO;
import model.TipoEvento;
import util.InputSanitizer;

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
import java.sql.SQLException;

@WebServlet("/admin/updateEvent")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateEventServlet extends HttpServlet {
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
        int id = Integer.parseInt(request.getParameter("id"));
        Event existingEvent = eventDAO.getEventById(id);
        request.setAttribute("event", existingEvent);
        request.getRequestDispatcher("/admin/updateEvent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = InputSanitizer.sanitize(request.getParameter("nome"));
        String luogo = InputSanitizer.sanitize(request.getParameter("luogo"));
        Date dataEvento = Date.valueOf(request.getParameter("dataEvento"));
        String orario = InputSanitizer.sanitize(request.getParameter("orario"));
        String tipo = InputSanitizer.sanitize(request.getParameter("tipo"));

        String fileName = uploadImage(request);
        if (fileName == null) {
            try {
                fileName = eventDAO.getImage(id);
                System.out.println("Retrieved image file name: " + fileName);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        Event updatedEvent = new Event();
        updatedEvent.setCodiceEvento(id);
        updatedEvent.setNome(nome);
        updatedEvent.setLuogo(luogo);
        updatedEvent.setDataEvento(dataEvento);
        updatedEvent.setOrario(orario);
        updatedEvent.setTipo(TipoEvento.fromString(tipo));
        updatedEvent.setImage(fileName);

        try {
            eventDAO.updateEvent(updatedEvent);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        double prezzoStandard = Double.parseDouble(request.getParameter("prezzoStandard"));
        double prezzoVIP = Double.parseDouble(request.getParameter("prezzoVIP"));

        double prezzi[] = {prezzoStandard, prezzoVIP};
        String[] tipiBiglietto = {"Standard", "VIP"};

        for (int i = 0; i < tipiBiglietto.length; i++) {
            Ticket ticket = new Ticket();
            ticket.setCodiceEvento(id);
            ticket.setTipo(tipiBiglietto[i]);
            ticket.setDescrizione("Biglietto " + tipiBiglietto[i] + " per l'evento " + id);
            ticket.setPrezzoUnitario(prezzi[i]);
            ticketDAO.updateTicket(ticket);
        }

        response.sendRedirect("../manageEvents");
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


