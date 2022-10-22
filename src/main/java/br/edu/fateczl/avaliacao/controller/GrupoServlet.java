package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.fateczl.avaliacao.model.Grupo;
import br.edu.fateczl.avaliacao.persistence.Conexao;
import br.edu.fateczl.avaliacao.persistence.GrupoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/grupos")
public class GrupoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String erro = "";   
    public GrupoServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Grupo> grupos = new ArrayList<>();
		String erro = "";
		try {
			grupos = createGrupos();
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
    
	public List<Grupo> createGrupos() throws SQLException {
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
    
	public List<Grupo> getGrupos() throws SQLException {
		Conexao conn = new Conexao();
		Connection cn = null;
		try {
			cn = conn.getConexao();
			GrupoDAO d = new GrupoDAO(cn);
			return d.listAll2();
		} finally {
			conn.close(cn);
		}
	}
	
}