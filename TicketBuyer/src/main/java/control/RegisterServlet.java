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
        String nome = request.getParameter("name");
        String password = request.getParameter("password");
        String cognome = request.getParameter("surname");
        String via = request.getParameter("address");
        String numero = request.getParameter("number");
        String provincia = request.getParameter("province");
        String citta = request.getParameter("city");
        String telefono = request.getParameter("phone");
        String numeroT = request.getParameter("cell");
        
        String hashedPassword = hashPassword(password);
        String indirizzo = via + ", " + numero + ", " + citta + ", " + provincia;

        Utente newUser = new Utente( email, hashedPassword, nome, cognome, indirizzo, telefono, numeroT, Ruolo.UTENTE);

        userDAO.addUser(newUser);

        response.sendRedirect("/login.jsp");
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

