package control;

import model.Ticket;
import model.TicketDAO;
import util.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Ticket> cart = (List<Ticket>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addToCart(request, response, cart);
                    break;
                case "remove":
                    removeFromCart(request, response, cart);
                    break;
                case "view":
                default:
                    viewCart(request, response, cart);
                    break;
            }
        } else {
            viewCart(request, response, cart);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, List<Ticket> cart) throws ServletException, IOException {
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        Ticket ticket = ticketDAO.getTicketById(ticketId);
        if (ticket != null) {
            cart.add(ticket);
        }
        response.sendRedirect("cart?action=view");
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, List<Ticket> cart) throws ServletException, IOException {
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        cart.removeIf(ticket -> ticket.getCodiceBiglietto() == ticketId);
        response.sendRedirect("cart?action=view");
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response, List<Ticket> cart) throws ServletException, IOException {
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/WEB-INF/view/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}


