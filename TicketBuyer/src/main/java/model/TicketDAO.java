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
    
    public Ticket getTicketByIdDeleted(int ticketId) {
        String query = "SELECT * FROM Biglietto WHERE codiceBiglietto = ? AND (deleted = true OR deleted = false)";
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
                            resultSet.getDouble("prezzoUnitario"))
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

    public void addTicket(Ticket ticket) {
        String sql = "INSERT INTO Biglietto (codiceEvento, tipo, descrizione, prezzoUnitario, deleted) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ticket.getCodiceEvento());
            ps.setString(2, ticket.getTipo());
            ps.setString(3, ticket.getDescrizione());
            ps.setDouble(4, ticket.getPrezzoUnitario());
            ps.setBoolean(5, false);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTicket(int ticketId) {
        String sql = "UPDATE Biglietto SET deleted = true WHERE codiceBiglietto = ?";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Ticket getTicketByEventAndType(int eventId, String type) {
        Ticket ticket = null;
        String sql = "SELECT * FROM Biglietto WHERE codiceEvento = ? AND tipo = ? AND deleted = false";

        try (Connection conn = DataSource.getInstance().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

        	ps.setInt(1, eventId);
        	ps.setString(2, type);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ticket = new Ticket();
                ticket.setCodiceBiglietto(rs.getInt("codiceBiglietto"));
                ticket.setCodiceEvento(rs.getInt("codiceEvento"));
                ticket.setTipo(rs.getString("tipo"));
                ticket.setDescrizione(rs.getString("descrizione"));
                ticket.setPrezzoUnitario(rs.getDouble("prezzoUnitario"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ticket;
    }

    public void updateTicket(Ticket ticket) {
        String sql = "UPDATE Biglietto SET prezzoUnitario = ? WHERE codiceBiglietto = ?";

        try (Connection conn = DataSource.getInstance().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

        	ps.setDouble(1, ticket.getPrezzoUnitario());
        	ps.setInt(2, ticket.getCodiceBiglietto());
        	ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
