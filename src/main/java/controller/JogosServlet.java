package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import dao.Conexao;
import dao.JogosDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Jogo;

@WebServlet("/jogos")
public class JogosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JogosServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	private int createJogos() {
		Conexao conn = new Conexao();
		Connection cn = null;
		try {
			cn = conn.getConexao();
			JogosDAO d = new JogosDAO(cn);
			return d.create();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.close(cn);
		}
		return -1;
	}
	
	private List<Jogo> listarJogos(LocalDate dt) {
		List<Jogo> jogos = null;
		Conexao conn = new Conexao();
		Connection cn = null;		
		try {
			JogosDAO d = new JogosDAO(cn);
			jogos = d.list(dt);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close(cn);
		}		
		return jogos;
	}
	
	private List<Jogo> listarTdsJogos() {
		List<Jogo> jogos = null;
		Conexao conn = new Conexao();
		Connection cn = null;		
		try {
			JogosDAO d = new JogosDAO(cn);
			jogos = d.listAll();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close(cn);
		}		
		return jogos;
	}
}
