package control;

import model.Order;
import model.OrderDAO;
import model.Stato;
import model.Cart;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Utente user = (Utente) session.getAttribute("user");

        if (cart != null && user != null) {
            Order order = new Order();
            order.setEmailCliente(user.getEmail());
            order.setPrezzoTotale(cart.getTotalPrice());
            order.setDataAcquisto(Date.valueOf(LocalDate.now()));
            order.setStato(Stato.COMPLETATO);

            orderDAO.addOrder(order);

            cart.clear();
            response.sendRedirect("orders");
        } else {
            response.sendRedirect("cart");
        }
    }
}

