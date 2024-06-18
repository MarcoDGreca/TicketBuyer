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
        StringBuilder sql = new StringBuilder("SELECT DISTINCT e.* FROM Evento e JOIN Biglietto b ON e.codiceEvento = b.codiceEvento WHERE 1=1");

        if (nome != null && !nome.isEmpty()) {
            sql.append(" AND e.nome LIKE ?");
        }
        if (tipo != null && !tipo.isEmpty()) {
            sql.append(" AND e.tipo = ?");
        }
        if (dataInizio != null) {
            sql.append(" AND e.dataEvento >= ?");
        }
        if (dataFine != null) {
            sql.append(" AND e.dataEvento <= ?");
        }
        if (disponibilita != null) {
            sql.append(" AND e.disponibilita >= ?");
        }
        if (prezzoMax != null) {
            sql.append(" AND b.prezzoUnitario <= ?");
        }

        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (nome != null && !nome.isEmpty()) {
                ps.setString(paramIndex++, "%" + nome + "%");
            }
            if (tipo != null && !tipo.isEmpty()) {
                ps.setString(paramIndex++, tipo);
            }
            if (dataInizio != null) {
                ps.setDate(paramIndex++, dataInizio);
            }
            if (dataFine != null) {
                ps.setDate(paramIndex++, dataFine);
            }
            if (disponibilita != null) {
                ps.setInt(paramIndex++, disponibilita);
            }
            if (prezzoMax != null) {
                ps.setDouble(paramIndex++, prezzoMax);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Event event = new Event();
                    event.setCodiceEvento(rs.getInt("codiceEvento"));
                    event.setNome(rs.getString("nome"));
                    event.setOrario(rs.getString("orario"));
                    event.setLuogo(rs.getString("luogo"));
                    event.setDataEvento(rs.getDate("dataEvento"));
                    event.setTipo(TipoEvento.fromString(rs.getString("tipo")));
                    event.setDisponibilita(rs.getInt("disponibilita"));
                    events.add(event);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

   
}

