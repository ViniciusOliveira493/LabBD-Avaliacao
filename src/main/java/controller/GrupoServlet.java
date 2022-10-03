package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.Conexao;
import dao.GrupoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Grupo;

@WebServlet("/grupos")
public class GrupoServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
	    public GrupoServlet() {
	        super();
	    }
	    
	    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    	//TODO
	    }
	    
	    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			List<Grupo> grupos = new ArrayList<>();
			String erro = "";
			try {
				grupos = getGrupos();
			} catch (SQLException e) {
				e.printStackTrace();
				erro = e.getMessage();
			} finally {
				RequestDispatcher rd = req.getRequestDispatcher("grupos.jsp");
				req.setAttribute("grupos", grupos);
				req.setAttribute("erro", erro);
				rd.forward(req, resp);
			}
		}
	    
		public List<Grupo> getGrupos() throws SQLException {
			Conexao conn = new Conexao();
			Connection cn = null;
			try {
				cn = conn.getConexao();
				GrupoDAO d = new GrupoDAO(cn);
				return d.listAll();
			} finally {
				conn.close(cn);
			}
		}
	    
		}

