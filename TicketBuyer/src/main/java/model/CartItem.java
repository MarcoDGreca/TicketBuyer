package model;

public class CartItem {
    private Ticket ticket;
    private int quantity;

    public CartItem(Ticket ticket, int quantity) {
        this.ticket = ticket;
        this.quantity = quantity;
    }

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return ticket.getPrezzoUnitario() * quantity;
    }
}

