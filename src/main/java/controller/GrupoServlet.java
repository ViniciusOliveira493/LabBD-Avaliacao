package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.Conexao;
import dao.GrupoDAO;
import dao.JogosDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Grupo")
public class GrupoServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
	    public GrupoServlet() {
	        super();
	    }
	    
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	Conexao conn = new Conexao();
			Connection cn = null;
			try {
				cn = conn.getConexao();
				GrupoDAO g = new GrupoDAO(cn);
				System.out.println(g.listAll());
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conn.close(cn);
			}
		}
}
