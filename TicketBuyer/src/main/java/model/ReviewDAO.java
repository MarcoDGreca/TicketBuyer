package model;

import util.DataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private DataSource dataSource;

    public ReviewDAO() {
        this.dataSource = DataSource.getInstance();;
    }

    public Review getReviewById(int reviewId) {
        String query = "SELECT * FROM Recensione WHERE codiceRecensione = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, reviewId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Review(
                        resultSet.getInt("codiceRecensione"),
                        resultSet.getInt("codiceProdotto"),
                        resultSet.getString("emailCliente"),
                        resultSet.getInt("votazione"),
                        resultSet.getString("testo"),
                        resultSet.getDate("dataRecensione")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addReview(Review review) {
        String query = "INSERT INTO Recensione (codiceEvento, emailCliente, votazione, testo, dataRecensione) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, review.getCodiceProdotto());
            statement.setString(2, review.getemailCliente());
            statement.setInt(3, review.getVotazione());
            statement.setString(4, review.gettesto());
            statement.setDate(5, review.getdataRecensione());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateReview(Review review) {
        String query = "UPDATE Recensione SET codiceEvento = ?, emailCliente = ?, votazione = ?, testo = ?, dataRecensione = ? WHERE codiceRecensione = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, review.getCodiceProdotto());
            statement.setString(2, review.getemailCliente());
            statement.setInt(3, review.getVotazione());
            statement.setString(4, review.gettesto());
            statement.setDate(5, review.getdataRecensione());
            statement.setInt(6, review.getCodiceRecensione());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteReview(int reviewId) {
        String query = "DELETE FROM Recensione WHERE codiceRecensione = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, reviewId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM Recensione";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Review review = new Review(
                    resultSet.getInt("codiceRecensione"),
                    resultSet.getInt("codiceProdotto"),
                    resultSet.getString("emailCliente"),
                    resultSet.getInt("votazione"),
                    resultSet.getString("testo"),
                    resultSet.getDate("dataRecensione")
                );
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}
