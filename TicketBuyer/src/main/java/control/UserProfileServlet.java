package control;

import model.Utente;
import model.UtenteDAO;
import util.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class UserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtenteDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UtenteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente user = (Utente) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente user = (Utente) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String indirizzo = request.getParameter("indirizzo");
        String telefono = request.getParameter("telefono");
        String numero = request.getParameter("numero");

        user.setNome(nome);
        user.setCognome(cognome);
        user.setEmail(email);
        user.setIndirizzo(indirizzo);
        user.setTelefono(telefono);
        user.setNumero(numero);

        userDAO.updateUser(user);
        session.setAttribute("user", user);

        response.sendRedirect("profile");
    }
}
