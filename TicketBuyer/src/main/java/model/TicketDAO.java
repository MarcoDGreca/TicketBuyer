package model;

import util.DataSource;
import java.sql.*;
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
                    return new Ticket(
                        resultSet.getInt("codiceBiglietto"),
                        resultSet.getInt("codiceEvento"),
                        resultSet.getString("tipo"),
                        resultSet.getString("descrizione"),
                        resultSet.getDouble("prezzoUnitario")
                    );
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
                    resultSet.getDouble("prezzoUnitario")
                );
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public void addTicket(Ticket ticket) {
        String query = "INSERT INTO Biglietto (codiceEvento, tipo, descrizione, prezzoUnitario) VALUES (?, ?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, ticket.getCodiceEvento());
            statement.setString(2, ticket.getTipo());
            statement.setString(3, ticket.getDescrizione());
            statement.setDouble(4, ticket.getPrezzoUnitario());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateTicket(Ticket ticket) {
        String query = "UPDATE Biglietto SET codiceEvento = ?, tipo = ?, descrizione = ?, prezzoUnitario = ? WHERE codiceBiglietto = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, ticket.getCodiceEvento());
            statement.setString(2, ticket.getTipo());
            statement.setString(3, ticket.getDescrizione());
            statement.setDouble(4, ticket.getPrezzoUnitario());
            statement.setInt(5, ticket.getCodiceBiglietto());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTicket(int ticketId) {
        String query = "UPDATE Biglietto SET deleted = true WHERE codiceBiglietto = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, ticketId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
