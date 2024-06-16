package model;

import util.DataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO {
    private DataSource dataSource;

    public TicketDAO() {
        this.dataSource = DataSource.getInstance();
    }

    public Ticket getTicketById(int ticketId) {
        String query = "SELECT * FROM Biglietto WHERE codiceBiglietto = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, ticketId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                	if(!resultSet.getBoolean("deleted")) {
                    return new Ticket(
                        resultSet.getInt("codiceBiglietto"),
                        resultSet.getInt("codiceEvento"),
                        resultSet.getString("tipo"),
                        resultSet.getString("descrizione"),
                        resultSet.getDouble("prezzoUnitario")
                    );
                }
              }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        String query = "SELECT * FROM Biglietto";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Ticket ticket = new Ticket(
                        resultSet.getInt("codiceBiglietto"),
                        resultSet.getInt("codiceEvento"),
                        resultSet.getString("tipo"),
                        resultSet.getString("descrizione"),
                        resultSet.getDouble("prezzo")
                    );
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }
    
    public List<Ticket> getTicketsByEventId(int eventId) {
        List<Ticket> tickets = new ArrayList<>();
        String query = "SELECT * FROM Biglietto WHERE codiceEvento = ? AND deleted = false";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, eventId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tickets.add(new Ticket(
                            resultSet.getInt("codiceBiglietto"),
                            resultSet.getInt("codiceEvento"),
                            resultSet.getString("tipo"),
                            resultSet.getString("descrizione"),
                            resultSet.getDouble("prezzo"))
                    );
                       
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }
    
    public synchronized List<Ticket> getTicketsByOrderId(int orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String query = "SELECT b.codiceBiglietto, b.codiceEvento, b.tipo, b.descrizione, b.prezzoUnitario, b.deleted " +
                       "FROM DettaglioOrdine d JOIN Biglietto b ON d.codiceBiglietto = b.codiceBiglietto " +
                       "WHERE d.codiceOrdine = ? AND b.deleted = false";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Ticket ticket = new Ticket(
                        resultSet.getInt("codiceBiglietto"),
                        resultSet.getInt("codiceEvento"),
                        resultSet.getString("tipo"),
                        resultSet.getString("descrizione"),
                        resultSet.getDouble("prezzoUnitario")
                    );
                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

}
