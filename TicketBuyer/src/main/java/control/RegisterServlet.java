package control;

import model.Ruolo;
import model.Utente;
import model.UtenteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UtenteDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UtenteDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String nome = request.getParameter("nome");
        String password = request.getParameter("password");
        String cognome = request.getParameter("cognome");
        String via = request.getParameter("via");
        String cap = request.getParameter("cap");
        String numero = request.getParameter("numero");
        String provincia = request.getParameter("provincia");
        String citta = request.getParameter("citta");
        String telefono = request.getParameter("telefono");
        String numeroT = request.getParameter("numeroT");
        
        String indirizzo = via + ", " + numero + ", " + cap + ", " + citta + ", " + provincia;

        String hashedPassword = hashPassword(password);

        Utente newUser = new Utente(email, hashedPassword, nome, cognome, indirizzo, telefono, numeroT, Ruolo.UTENTE);

        userDAO.addUser(newUser);

        response.sendRedirect(request.getContextPath() + "/home");
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
