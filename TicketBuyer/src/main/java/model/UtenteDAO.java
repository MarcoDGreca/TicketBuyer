package model;

import util.DataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UtenteDAO {
    private DataSource dataSource;

    public UtenteDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Utente getUserByEmail(String email) {
        String query = "SELECT * FROM UserAccount WHERE email = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Utente(
                        resultSet.getString("email"),
                        resultSet.getString("passwordUser"),
                        resultSet.getString("nome"),
                        resultSet.getString("cognome"),
                        resultSet.getString("indirizzo"),
                        resultSet.getString("telefono"),
                        resultSet.getString("numero"),
                        resultSet.getString("ruolo")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addUser(Utente utente) {
        String query = "INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, ruolo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, utente.getEmail());
            statement.setString(2, utente.getPasswordUser());
            statement.setString(3, utente.getNome());
            statement.setString(4, utente.getCognome());
            statement.setString(5, utente.getIndirizzo());
            statement.setString(6, utente.getTelefono());
            statement.setString(7, utente.getNumero());
            statement.setString(8, utente.getRuolo());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(Utente utente) {
        String query = "UPDATE UserAccount SET passwordUser = ?, nome = ?, cognome = ?, indirizzo = ?, telefono = ?, numero = ?, ruolo = ? WHERE email = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, utente.getPasswordUser());
            statement.setString(2, utente.getNome());
            statement.setString(3, utente.getCognome());
            statement.setString(4, utente.getIndirizzo());
            statement.setString(5, utente.getTelefono());
            statement.setString(6, utente.getNumero());
            statement.setString(7, utente.getRuolo());
            statement.setString(8, utente.getEmail());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(String email) {
        String query = "DELETE FROM UserAccount WHERE email = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Utente> getAllUsers() {
        List<Utente> users = new ArrayList<>();
        String query = "SELECT * FROM UserAccount";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Utente utente = new Utente(
                    resultSet.getString("email"),
                    resultSet.getString("passwordUser"),
                    resultSet.getString("nome"),
                    resultSet.getString("cognome"),
                    resultSet.getString("indirizzo"),
                    resultSet.getString("telefono"),
                    resultSet.getString("numero"),
                    resultSet.getString("ruolo")
                );
                users.add(utente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
