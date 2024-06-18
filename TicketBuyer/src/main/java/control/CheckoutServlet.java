package control;

import model.Cart;
import model.Order;
import model.OrderDAO;
import model.Stato;
import model.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Il carrello è vuoto.");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        double totalPrice = cart.getTotalPrice();
        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        String emailCliente = ((model.Utente) session.getAttribute("user")).getEmail();

        if (cart != null && !cart.isEmpty()) {
            Order order = new Order();
            order.setEmailCliente(emailCliente);
            order.setPrezzoTotale(cart.getTotalPrice());
            order.setDataAcquisto(new java.sql.Date(System.currentTimeMillis()));
            order.setStato(Stato.IN_LAVORAZIONE);

            try {
                int orderId = orderDAO.addOrder(order);

                for (Ticket ticket : cart.getItems().keySet()) {
                    int quantity = cart.getItems().get(ticket);
                    orderDAO.addOrderDetail(orderId, ticket.getCodiceBiglietto(), quantity);
                }

                cart.clear();
                session.setAttribute("cart", cart);
                response.sendRedirect(request.getContextPath() + "/orderConfirmation.jsp");
            } catch (SQLException e) {
                throw new ServletException("Errore nella creazione dell'ordine", e);
            }
        } else {
            request.setAttribute("errorMessage", "Il carrello è vuoto.");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
}


