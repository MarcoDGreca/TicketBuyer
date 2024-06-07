package model;

import util.DataSource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    private DataSource dataSource;

    public EventDAO() {
        this.dataSource = DataSource.getInstance();
    }

    public void addEvent(Event event) {
        String query = "INSERT INTO Evento (nome, luogo, dataEvento, orario, disponibilita) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, event.getNome());
            statement.setString(2, event.getLuogo());
            statement.setDate(3, new java.sql.Date(event.getDataEvento().getTime()));
            statement.setString(4, event.getOrario());
            statement.setInt(5, event.getDisponibilita());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Event getEventById(int eventId) {
        String query = "SELECT * FROM Evento WHERE codiceEvento = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, eventId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Event(
                        resultSet.getInt("codiceEvento"),
                        resultSet.getString("nome"),
                        resultSet.getString("luogo"),
                        resultSet.getDate("dataEvento"),
                        resultSet.getString("orario"),
                        resultSet.getInt("disponibilita")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM Evento";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Event event = new Event(
                    resultSet.getInt("codiceEvento"),
                    resultSet.getString("nome"),
                    resultSet.getString("luogo"),
                    resultSet.getDate("dataEvento"),
                    resultSet.getString("orario"),
                    resultSet.getInt("disponibilita")
                );
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public void updateEvent(Event event) {
        String query = "UPDATE Evento SET nome = ?, luogo = ?, dataEvento = ?, orario = ?, disponibilita = ? WHERE codiceEvento = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, event.getNome());
            statement.setString(2, event.getLuogo());
            statement.setDate(3, new java.sql.Date(event.getDataEvento().getTime()));
            statement.setString(4, event.getOrario());
            statement.setInt(5, event.getDisponibilita());
            statement.setInt(6, event.getCodiceEvento());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEvent(int eventId) {
        String query = "DELETE FROM Evento WHERE codiceEvento = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, eventId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

