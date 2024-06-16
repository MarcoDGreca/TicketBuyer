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

    public synchronized void addEvent(Event event) {
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

    public synchronized Event getEventById(int eventId) {
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
                        TipoEvento.fromString(resultSet.getString("tipo")),
                        resultSet.getInt("disponibilita")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public synchronized List<Event> getEventByLocation(String eventLoc) {
        String query = "SELECT * FROM Evento WHERE dataEvento = ?";
        List<Event> list = new ArrayList<>();
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, eventLoc);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    list.add(new Event(
                    		resultSet.getInt("codiceEvento"),
                            resultSet.getString("nome"),
                            resultSet.getString("luogo"),
                            resultSet.getDate("dataEvento"),
                            resultSet.getString("orario"),
                            TipoEvento.fromString(resultSet.getString("tipo")),
                            resultSet.getInt("disponibilita")
                    ));
                }
                if(list.isEmpty())
                	return null;
                else return list;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public synchronized List<Event> getAllEvents() {
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
                        TipoEvento.fromString(resultSet.getString("tipo")),
                        resultSet.getInt("disponibilita")
                );
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public synchronized void updateEvent(Event event) {
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

    public synchronized void deleteEvent(int eventId) {
        String query = "DELETE FROM Evento WHERE codiceEvento = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, eventId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Event> searchEvents(String nome, String tipo, Date dataInizio, Date dataFine, Integer disponibilita, Double prezzoMax) {
        List<Event> events = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT e.* FROM Evento e " +
            "JOIN Biglietto b ON e.codiceEvento = b.codiceEvento " +
            "WHERE 1=1");

        if (nome != null && !nome.isEmpty()) {
            query.append(" AND e.nome LIKE ?");
        }
        if (tipo != null && !tipo.isEmpty()) {
            query.append(" AND e.tipo = ?");
        }
        if (dataInizio != null) {
            query.append(" AND e.dataEvento >= ?");
        }
        if (dataFine != null) {
            query.append(" AND e.dataEvento <= ?");
        }
        if (disponibilita != null) {
            query.append(" AND e.disponibilita >= ?");
        }
        if (prezzoMax != null) {
            query.append(" AND b.prezzoUnitario <= ?");
        }

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query.toString())) {

            int index = 1;
            if (nome != null && !nome.isEmpty()) {
                statement.setString(index++, "%" + nome + "%");
            }
            if (tipo != null && !tipo.isEmpty()) {
                statement.setString(index++, tipo);
            }
            if (dataInizio != null) {
                statement.setDate(index++, dataInizio);
            }
            if (dataFine != null) {
                statement.setDate(index++, dataFine);
            }
            if (disponibilita != null) {
                statement.setInt(index++, disponibilita);
            }
            if (prezzoMax != null) {
                statement.setDouble(index++, prezzoMax);
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Event event = new Event();
                    event.setCodiceEvento(resultSet.getInt("codiceEvento"));
                    event.setNome(resultSet.getString("nome"));
                    event.setLuogo(resultSet.getString("luogo"));
                    event.setDataEvento(resultSet.getDate("dataEvento"));
                    event.setOrario(resultSet.getString("orario"));
                    event.setTipo(TipoEvento.fromString(resultSet.getString("tipo")));
                    event.setDisponibilita(resultSet.getInt("disponibilita"));
                    events.add(event);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
   
}

