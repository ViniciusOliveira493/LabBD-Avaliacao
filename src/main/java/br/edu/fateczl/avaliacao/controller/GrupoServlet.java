package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.avaliacao.controller.abstractClasses.AbstractServlet;
import br.edu.fateczl.avaliacao.model.Grupo;
import br.edu.fateczl.avaliacao.persistence.Conexao;
import br.edu.fateczl.avaliacao.persistence.GrupoDAO;
import jakarta.servlet.ServletException;

@Controller
public class GrupoServlet extends AbstractServlet{	
	@Autowired
	
	Conexao conn;
	List<Grupo> grupos = new ArrayList<>();
	String erro = "";
    public GrupoServlet(){
        super();
    }
    @Override
    @RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.GET)
    public ModelAndView doGet(ModelMap model) throws ServletException, IOException {		
    	limparAtributos();
		try {
			grupos = getGrupos();
		} catch (SQLException e) {
			e.printStackTrace();
			erro = e.getMessage();
		}
		return retorno(model);		
    }
    @Override
	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.POST)
    public ModelAndView doPost(ModelMap model) throws ServletException, IOException {
		try {
			grupos = createGrupos();
		} catch (SQLException e) {
			e.printStackTrace();
			erro = e.getMessage();
		}
		return retorno(model);
	}
    
	public List<Grupo> createGrupos() throws SQLException {
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
	
	@Override
	protected ModelAndView retorno(ModelMap mdmap) {
		mdmap.addAttribute("grupos", grupos);
		mdmap.addAttribute("erro", erro);
		return new ModelAndView("grupos");
	}
	
	@Override
	protected void limparAtributos() {
			grupos = new ArrayList<>();
			erro = "";		
		}
}