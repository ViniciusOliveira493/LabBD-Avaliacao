package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import dao.Conexao;
import dao.JogosDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Jogo;

@WebServlet("/jogos")
public class JogosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String erro = "";
	private String msg = "";
	private String data = "";
	private List<Jogo> jogos = new ArrayList<>();
	RequestDispatcher rd;
	
    public JogosServlet() {
        super();
    }
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	jogos = listarAllJogos();
    	iniciarRD(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String btn = request.getParameter("btn");	
		
		if(btn.equals("Criar Jogos")) {
			if(createJogos()==1) {
				msg = "Jogos criados com sucesso";
				jogos = listarAllJogos();
				iniciarRD(request,response);
			}else {
				msg = "Algo deu errado";
				jogos = listarAllJogos();
				iniciarRD(request,response);
			}
		}else {
			String data = request.getParameter("txtData");
			if(!data.equals("") && data != null) {
				jogos = listarJogos(LocalDate.parse(data));
			}			
			iniciarRD(request,response);
		}
	}
	
	private int createJogos() {
		Conexao conn = new Conexao();
		Connection cn = conn.getConexao();
		try {
			cn = conn.getConexao();
			JogosDAO d = new JogosDAO(cn);
			return d.create();
		} catch (SQLException e) {
			erro = e.getMessage();
		} finally {
			conn.close(cn);
		}
		return -1;
	}
	
	private List<Jogo> listarJogos(LocalDate dt) {
		List<Jogo> jogos = null;
		this.data = dt.toString();
		
		if(data.equals("")) {
			return jogos;
		}
		
		Conexao conn = new Conexao();
		Connection cn = conn.getConexao();
		try {
			JogosDAO d = new JogosDAO(cn);
			jogos = d.list(dt);
		} catch (Exception e) {
			erro = e.getMessage();
		} finally {
			conn.close(cn);
		}		
		return jogos;
	}
	
	private List<Jogo> listarAllJogos() {
		List<Jogo> jogos = null;
		Conexao conn = new Conexao();
		Connection cn = conn.getConexao();	
		try {
			JogosDAO d = new JogosDAO(cn);
			jogos = d.listAll();
		} catch (Exception e) {
			erro = e.getMessage();
		} finally {
			conn.close(cn);
		}		
		return jogos;
	}
	
	private void iniciarRD(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		rd = request.getRequestDispatcher("jogos.jsp");
		request.setAttribute("erro", erro);
		request.setAttribute("res", msg);
		request.setAttribute("jogos", jogos);
		request.setAttribute("data", data);
		rd.forward(request, response);
	}
}
