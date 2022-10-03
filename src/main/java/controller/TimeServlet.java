package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.Conexao;
import dao.TimeDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Time;

@WebServlet("/times")
public class TimeServlet  extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public TimeServlet() {
        super();
    }
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Time> times = new ArrayList<>();
		String erro = "";
		try {
			times = getTimes();
		} catch (SQLException e) {
			e.printStackTrace();
			erro = e.getMessage();
		} finally {
			RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
			req.setAttribute("times", times);
			req.setAttribute("erro", erro);
			rd.forward(req, resp);
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Time> times = new ArrayList<>();
		String erro = "";
		try {
			times = getTimes();
		} catch (SQLException e) {
			e.printStackTrace();
			erro = e.getMessage();
		} finally {
			RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
			req.setAttribute("times", times);
			req.setAttribute("erro", erro);
			rd.forward(req, resp);
		}
	}
	
	public List<Time> getTimes() throws SQLException {
		Conexao conn = new Conexao();
		Connection cn = null;
		try {
			cn = conn.getConexao();
			TimeDAO d = new TimeDAO(cn);
			return d.listAll();
		} finally {
			conn.close(cn);
		}
	}
	
}
