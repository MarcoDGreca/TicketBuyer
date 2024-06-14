package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<Ticket> tickets;

    public Cart() {
        tickets = new ArrayList<>();
    }

    public List<Ticket> getTickets() {
        return tickets;
    }

    public void addTicket(Ticket ticket) {
        tickets.add(ticket);
    }

    public void removeTicket(int ticketId) {
        tickets.removeIf(ticket -> ticket.getCodiceBiglietto() == ticketId);
    }

    public double getTotalPrice() {
        return tickets.stream().mapToDouble(Ticket::getPrezzoUnitario).sum();
    }

    public void clear() {
        tickets.clear();
    }
}

