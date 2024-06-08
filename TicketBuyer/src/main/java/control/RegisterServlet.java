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
        String password = request.getParameter("password");
        String nome = request.getParameter("name");
        String cognome = request.getParameter("surname");
        String indirizzo = request.getParameter("address");
        String telefono = request.getParameter("phone");
        String numero = request.getParameter("cell");

        Utente newUser = new Utente( email, password, nome, cognome, indirizzo, telefono, numero, Ruolo.UTENTE);

        userDAO.addUser(newUser);

        response.sendRedirect("login");
    }
}

