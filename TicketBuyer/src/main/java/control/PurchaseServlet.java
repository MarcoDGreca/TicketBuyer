package control;

import model.Order;
import model.OrderDAO;
import model.Stato;
import model.Utente;
import model.Cart;
import util.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/purchase")
public class PurchaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente user = (Utente) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("login");
            return;
        }

        Order order = new Order();
        order.setCodiceOrdine((int) Math.random());
        order.setEmailCliente(user.getEmail());
        order.setPrezzoTotale(cart.getTotalPrice());
        order.setDataAcquisto(new Date(0));
        order.setStato(Stato.IN_LAVORAZIONE);

        orderDAO.addOrder(order);
        session.removeAttribute("cart");

        response.sendRedirect("orders");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        if ("refund".equals(action)) {
            orderDAO.requestRefund(orderId);
        }

        response.sendRedirect("orders");
    }
}
