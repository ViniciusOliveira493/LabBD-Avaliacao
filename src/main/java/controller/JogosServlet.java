package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.Conexao;
import dao.JogosDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/jogos")
public class JogosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JogosServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	private void createJogos() {
		Conexao conn = new Conexao();
		Connection cn = null;
		try {
			cn = conn.getConexao();
			JogosDAO d = new JogosDAO(cn);
			System.out.println(d.create());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.close(cn);
		}
	}
}
