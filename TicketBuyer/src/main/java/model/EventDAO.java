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

    public int addEvent(Event event) {
        String sql = "INSERT INTO Evento (codiceEvento, nome, luogo, dataEvento, orario, tipo, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        	ps.setInt(1, event.getCodiceEvento());
            ps.setString(2, event.getNome());
            ps.setString(3, event.getLuogo());
            ps.setDate(4, new java.sql.Date(event.getDataEvento().getTime()));
            ps.setString(5, event.getOrario());
            ps.setString(6, event.getTipo());
            ps.setString(8, event.getImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return event.getCodiceEvento();	
    }

    public void updateEvent(Event event) {
        String sql = "UPDATE Evento SET nome = ?, luogo = ?, dataEvento = ?, orario = ?, tipo = ?, image = ? WHERE codiceEvento = ?";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, event.getNome());
            ps.setString(2, event.getLuogo());
            ps.setDate(3, new java.sql.Date(event.getDataEvento().getTime()));
            ps.setString(4, event.getOrario());
            ps.setString(5, event.getTipo());
            ps.setString(7, event.getImage());
            ps.setInt(8, event.getCodiceEvento());
            ps.executeUpdate();
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
                        TipoEvento.fromString(resultSet.getString("tipo"))
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
                            TipoEvento.fromString(resultSet.getString("tipo"))
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
                        TipoEvento.fromString(resultSet.getString("tipo"))
                );
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

  
    public void deleteEvent(int id) {
        String sql = "DELETE FROM Evento WHERE codiceEvento = ?";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public String getImage(int eventId) throws SQLException {
        String sql = "SELECT image FROM Evento WHERE codiceEvento = ?";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("image");
                }
            }
        }
        return null;
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
                    events.add(event);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

	public int getID(Event newEvent) throws SQLException {
		String nomeE = newEvent.getNome();
		String sql = "SELECT codiceEvento FROM Evento WHERE nome = ?";
        try (Connection conn = DataSource.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nomeE);
            ResultSet rs = ps.executeQuery();  
        if (rs.next()) {
            return rs.getInt("codiceEvento");
        	}
        }
		return 0;
	}
}

