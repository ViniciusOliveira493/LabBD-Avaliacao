package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.avaliacao.model.Time;
import br.edu.fateczl.avaliacao.persistence.TimeDAO;
import jakarta.servlet.ServletException;


@Controller
public class TimeServlet {
	List<Time> times = new ArrayList<>();
	String erro = "";
	
    public TimeServlet() {
        super();
    }
	
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
		try {
			TimeDAO d = new TimeDAO();
			return d.listAll();
		} catch (Exception e) {
			erro = e.getMessage();
		}
		return null;
	}
	
	protected void limparAtributos() {
		times = new ArrayList<>();
		erro = "";
	}

	protected ModelAndView retorno(ModelMap model) throws ServletException, IOException {
		model.addAttribute("times", times);
		model.addAttribute("erro", erro);
		return new ModelAndView("index");
	}
	
}
