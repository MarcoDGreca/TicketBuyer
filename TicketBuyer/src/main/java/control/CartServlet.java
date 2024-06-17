package control;

import model.Cart;
import model.Ticket;
import model.TicketDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
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
                case "update":
                    updateCart(request, response, cart);
                    break;
                default:
                    viewCart(request, response, cart);
                    break;
            }
        } else {
            viewCart(request, response, cart);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, Cart cart) throws ServletException, IOException {
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        Ticket ticket = ticketDAO.getTicketById(ticketId);
        if (ticket != null) {
            cart.addItem(ticket);
        }
        HttpSession session = request.getSession();
        session.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, Cart cart) throws ServletException, IOException {
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        Ticket ticket = ticketDAO.getTicketById(ticketId);
        if (ticket != null) {
            cart.removeItem(ticket);
        }
        HttpSession session = request.getSession();
        session.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response, Cart cart) throws ServletException, IOException {
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Ticket ticket = ticketDAO.getTicketById(ticketId);
        if (ticket != null) {
            cart.updateItem(ticket, quantity);
        }
        HttpSession session = request.getSession();
        session.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response, Cart cart) throws ServletException, IOException {
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

