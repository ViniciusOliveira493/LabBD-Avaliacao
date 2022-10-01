package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Grupo;
import persistence.IGrupoDAO;

@WebServlet("/Grupo")
public class GrupoServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
	    public GrupoServlet() {
	        super();
	    }

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String botao = request.getParameter("botao");
			
			Grupo g = new Grupo();
			
			GenericDAO gDao = new GenericDAO();
			IGrupoDAO mDao = new GrupoDao(gDao);
			String erro = "";
			String saida = "";
			List<Grupo> marcas = new ArrayList<Grupo>();
			
			try {
				if (botao.equals("Listar")) {
					marcas = mDao.consultaMarcas();
				}
				if (botao.equals("Inserir")) {
					g = valido(id, nome, botao);
					saida = mDao.insereMarca(g);
					g = new Grupo();
				}
				if (botao.equals("Atualizar")) {
					g = valido(id, nome, botao);
					saida = mDao.atualizaMarca(g);
					g = new Grupo();
				}
				if (botao.equals("Excluir")) {
					g = valido(id, nome, botao);
					saida = mDao.excluiMarca(g);
					g = new Grupo();
				}
				if (botao.equals("Buscar")) {
					g = valido(id, nome, botao);
					g = mDao.consultaMarca(g);
				}
			} catch(SQLException | ClassNotFoundException | IOException e) {
				erro = e.getMessage();
			} finally {
				RequestDispatcher rd = request.getRequestDispatcher("grupo.jsp");
				request.setAttribute("grupo", g);
				request.setAttribute("marcas", marcas);
				request.setAttribute("erro", erro);
				request.setAttribute("saida", saida);
				rd.forward(request, response);
			}
		}
		
		private Grupo valido(String id, String nome, String botao) throws IOException {
			Grupo g = new Grupo();
			
			if (botao.equals("Inserir")) {
				if (id.equals("") || nome.equals("")) {
					throw new IOException("Preencher ID e Nome");
				} else {
					g.setId(Integer.parseInt(id));
					g.setNome(nome);
				}
			}
			if (botao.equals("Atualizar")) {
				if (id.equals("") || nome.equals("")) {
					throw new IOException("Preencher ID e Nome");
				} else {
					g.setId(Integer.parseInt(id));
					g.setNome(nome);
				}
			}
			if (botao.equals("Excluir")) {
				if (id.equals("")) {
					throw new IOException("Preencher ID");
				} else {
					g.setId(Integer.parseInt(id));
				}
			}
			if (botao.equals("Buscar")) {
				if (id.equals("")) {
					throw new IOException("Preencher ID");
				} else {
					g.setId(Integer.parseInt(id));
				}
			}

			return g;
		}

	}
}
