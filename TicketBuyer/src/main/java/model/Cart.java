package model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Ticket, Integer> items;

    public Cart() {
        items = new HashMap<>();
    }

    public void addItem(Ticket ticket) {
        items.put(ticket, items.getOrDefault(ticket, 0) + 1);
    }

    public void removeItem(Ticket ticket) {
        items.remove(ticket);
    }

    public void updateItem(Ticket ticket, int quantity) {
        if (quantity > 0) {
            items.replace(ticket, quantity);
        } else {
            items.remove(ticket);
        }
    }

    public Map<Ticket, Integer> getItems() {
        return items;
    }

    public double getTotalPrice() {
        double total = 0;
        for (Map.Entry<Ticket, Integer> entry : items.entrySet()) {
            total += entry.getKey().getPrezzoUnitario() * entry.getValue();
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    public void clear() {
    	items.clear();
    }
}
