package model;

import util.DataSource;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private DataSource dataSource;

    public OrderDAO() {
        this.dataSource = DataSource.getInstance();
    }

    public synchronized void addOrder(Order order) {
        String query = "INSERT INTO Ordine (emailCliente, prezzoTotale, dataAcquisto, stato) VALUES (?, ?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, order.getEmailCliente());
            statement.setDouble(2, order.getPrezzoTotale());
            statement.setDate(3, order.getDataAcquisto());
            statement.setString(4, order.getStato().getStato());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public synchronized Order getOrderById(int orderId) {
        String query = "SELECT * FROM Ordine WHERE codiceOrdine = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Order(
                        resultSet.getInt("codiceOrdine"),
                        resultSet.getString("emailCliente"),
                        resultSet.getDouble("prezzoTotale"),
                        resultSet.getDate("dataAcquisto"),
                        Stato.fromString(resultSet.getString("stato"))
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public synchronized List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM Ordine";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Order order = new Order(
                    resultSet.getInt("codiceOrdine"),
                    resultSet.getString("emailCliente"),
                    resultSet.getDouble("prezzoTotale"),
                    resultSet.getDate("dataAcquisto"),
                    Stato.fromString(resultSet.getString("stato"))
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public synchronized void updateOrder(Order order) {
        String query = "UPDATE Ordine SET emailCliente = ?, prezzoTotale = ?, dataAcquisto = ?, stato = ? WHERE codiceOrdine = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, order.getEmailCliente());
            statement.setDouble(2, order.getPrezzoTotale());
            statement.setDate(3, order.getDataAcquisto());
            statement.setString(4, order.getStato().getStato());
            statement.setInt(5, order.getCodiceOrdine());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public synchronized void deleteOrder(int orderId) {
        String query = "DELETE FROM Ordine WHERE codiceOrdine = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public synchronized List<Order> getOrdersByEmail(String emailCliente) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM Ordine WHERE emailCliente = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, emailCliente);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Order order = new Order();
                    order.setCodiceOrdine(resultSet.getInt("codiceOrdine"));
                    order.setEmailCliente(resultSet.getString("emailCliente"));
                    order.setPrezzoTotale(resultSet.getDouble("prezzoTotale"));
                    order.setDataAcquisto(resultSet.getDate("dataAcquisto"));
                    order.setStato(Stato.valueOf(resultSet.getString("stato")));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public synchronized void requestRefund(int orderId) {
        String query = "UPDATE Ordine SET stato = ? WHERE codiceOrdine = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "Richiesto Rimborso");
            statement.setInt(2, orderId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public synchronized void addOrderDetail(int orderId, int ticketId, int quantity) {
        String query = "INSERT INTO DettaglioOrdine (codiceOrdine, codiceBiglietto, quantita) VALUES (?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            statement.setInt(2, ticketId);
            statement.setInt(3, quantity);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

