package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.avaliacao.controller.abstractClasses.AbstractServlet;
import br.edu.fateczl.avaliacao.model.Time;
import br.edu.fateczl.avaliacao.persistence.Conexao;
import br.edu.fateczl.avaliacao.persistence.TimeDAO;
import jakarta.servlet.ServletException;


@Controller
public class TimeServlet  extends AbstractServlet {
	List<Time> times = new ArrayList<>();
	String erro = "";
	
    public TimeServlet() {
        super();
    }
	
    @Override
    @RequestMapping(name = "times", value = "/times", method = RequestMethod.GET)
    public ModelAndView doGet(ModelMap model) throws ServletException, IOException {		
		try {
			times = getTimes();
		} catch (SQLException e) {
			e.printStackTrace();
			erro = e.getMessage();
		}
		return retorno(model);
	}
	
    @Override
    @RequestMapping(name = "times", value = "/times", method = RequestMethod.POST)
    public ModelAndView doPost(ModelMap model) throws ServletException, IOException {
		try {
			times = getTimes();
		} catch (SQLException e) {
			e.printStackTrace();
			erro = e.getMessage();
		} 
		return retorno(model);
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
	
	@Override
	protected void limparAtributos() {
		times = new ArrayList<>();
		erro = "";
	}
	
	@Override
	protected ModelAndView retorno(ModelMap model) throws ServletException, IOException {
		model.addAttribute("times", times);
		model.addAttribute("erro", erro);
		return new ModelAndView("index");
	}
	
}
