package control;

import model.Order;
import model.OrderDAO;
import model.Ticket;
import model.TicketDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);
        List<Ticket> tickets = ticketDAO.getTicketsByOrderId(orderId);

        request.setAttribute("order", order);
        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher("/orderDetails.jsp").forward(request, response);
    }
}
