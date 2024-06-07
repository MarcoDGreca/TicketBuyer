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
        this.dataSource = DataSource.getInstance();;
    }

    public void addOrder(Order order) {
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

    public Order getOrderById(int orderId) {
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

    public List<Order> getAllOrders() {
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

    public void updateOrder(Order order) {
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

    public void deleteOrder(int orderId) {
        String query = "DELETE FROM Ordine WHERE codiceOrdine = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

