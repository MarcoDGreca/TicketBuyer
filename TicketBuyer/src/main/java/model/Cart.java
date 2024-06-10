package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<Ticket> tickets;

    public Cart() {
        this.tickets = new ArrayList<>();
    }

    public void addTicket(Ticket ticket) {
        this.tickets.add(ticket);
    }

    public void removeTicket(int ticketId) {
        this.tickets.removeIf(ticket -> ticket.getCodiceBiglietto() == ticketId);
    }

    public List<Ticket> getTickets() {
        return tickets;
    }

    public double getTotalPrice() {
        return tickets.stream().mapToDouble(Ticket::getPrezzoUnitario).sum();
    }

	public boolean isEmpty() {
		if (tickets.isEmpty())
			return true;
		else return false;
	}
}
