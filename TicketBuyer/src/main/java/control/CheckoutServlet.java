package control;

import model.Cart;
import model.Order;
import model.OrderDAO;
import model.Stato;
import model.Ticket;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

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
        if (cart == null || cart.getItems().isEmpty()) {
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
        Utente user = (Utente) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cart != null && !cart.getItems().isEmpty()) {
            Order order = new Order();
            order.setEmailCliente(user.getEmail());
            order.setPrezzoTotale(cart.getTotalPrice());
            order.setDataAcquisto(new java.sql.Date(System.currentTimeMillis()));
            order.setStato(Stato.IN_LAVORAZIONE);

            orderDAO.addOrder(order);
            int orderId = order.getCodiceOrdine();

            for (Map.Entry<Ticket, Integer> entry : cart.getItems().entrySet()) {
                orderDAO.addOrderDetail(orderId, entry.getKey().getCodiceBiglietto(), entry.getValue());
            }

            cart.clear();
            session.setAttribute("cart", cart);
            response.sendRedirect("orderConfirmation.jsp");
        } else {
            request.setAttribute("errorMessage", "Il carrello è vuoto.");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
}

