package control;

import model.Order;
import model.OrderDAO;
import model.Ticket;
import model.TicketDAO;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/orderDetails")
public class OrderDetailsServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        Utente user = (Utente) session.getAttribute("user");

        if (user != null) {
            List<Order> orders = orderDAO.getOrdersByEmail(user.getEmail());
            request.setAttribute("orders", orders);
        }
        request.getRequestDispatcher("/orderDetails.jsp").forward(request, response);
    }
}
