package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.avaliacao.controller.abstractClasses.AbstractServlet;
import br.edu.fateczl.avaliacao.model.Jogo;
import br.edu.fateczl.avaliacao.persistence.Conexao;
import br.edu.fateczl.avaliacao.persistence.JogosDAO;
import jakarta.servlet.ServletException;

@Controller
public class JogosServlet extends AbstractServlet{
	private String erro = "";
	private String msg = "";
	private String data = "";
	private List<Jogo> jogos = new ArrayList<>();
	
    public JogosServlet() {
        super();
    }
    
    @Override
    @RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.GET)
    public ModelAndView doGet(ModelMap model) throws ServletException, IOException {
    	limparAtributos();
    	jogos = listarAllJogos();
    	return retorno(model);
	}
    
    @Override
    @RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.POST)
	public ModelAndView doPost(ModelMap model) throws ServletException, IOException {
    	limparAtributos();
    	jogos = listarAllJogos();
    	System.out.println("post capturado");
    	return retorno(model);
    	/*
		String btn = model.getAttribute("btn");	
		System.out.println(request.toString());
		if(btn.equals("Criar Jogos")) {
			if(createJogos()==1) {
				msg = "Jogos criados com sucesso";
				jogos = listarAllJogos();
				return retorno(model);
			}else {
				msg = "Algo deu errado";
				jogos = listarAllJogos();
				return retorno(model);
			}
		}else {
			String data = request.getParameter("txtData");
			if(!data.equals("") && data != null) {
				jogos = listarJogos(LocalDate.parse(data));
			}			
			return retorno(model);
		}
		*/
	}
	
	private int createJogos() {
		Conexao conn = new Conexao();
		Connection cn = conn.getConexao();
		try {
			cn = conn.getConexao();
			JogosDAO d = new JogosDAO();
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
		
		try {
			JogosDAO d = new JogosDAO();
			jogos = d.list(dt);
		} catch (Exception e) {
			erro = e.getMessage();
		} 
		
		return jogos;
	}
	
	private List<Jogo> listarAllJogos() {
		List<Jogo> jogos = null;
		
		try {
			JogosDAO d = new JogosDAO();
			jogos = d.listAll();
		} catch (Exception e) {
			erro = e.getMessage();
		}		
		return jogos;
	}
	
	@Override
	protected void limparAtributos() {
		erro = "";
		msg = "";
		data = "";
		jogos = new ArrayList<>();
	}
	
	@Override
	protected ModelAndView retorno(ModelMap model) throws ServletException, IOException {
		model.addAttribute("erro", erro);
		model.addAttribute("res", msg);
		model.addAttribute("jogos", jogos);
		model.addAttribute("data", data);
		return new ModelAndView("jogos");
	}
}
