package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.avaliacao.model.Jogo;
import br.edu.fateczl.avaliacao.model.JogoParam;
import br.edu.fateczl.avaliacao.persistence.Conexao;
import br.edu.fateczl.avaliacao.persistence.JogosDAO;
import jakarta.servlet.ServletException;

@Controller
public class JogosServlet{
	private String erro = "";
	private String msg = "";
	private String data = "";
	private List<Jogo> jogos = new ArrayList<>();
	private Jogo jogo;
	
    public JogosServlet() {
        super();
    }
    
    
    @RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.GET)
    public ModelAndView doGet(ModelMap model) throws ServletException, IOException {
    	limparAtributos();
    	jogos = listarAllJogos();
    	return retorno(model,"jogos");
	}
    
    //
    @RequestMapping(name = "jogos", value = "jogos", method = RequestMethod.POST)
	public ModelAndView doPost(@RequestParam Map<String, String> params,ModelMap model) throws ServletException, IOException {
    	limparAtributos();
    	jogos = listarAllJogos();			
		String btn = params.get("btn");
		if(btn!=null) {
			if(btn.equals("Criar Jogos")) {
				if(createJogos()==1) {
					msg = "Jogos criados com sucesso";
					jogos = listarAllJogos();
					return retorno(model,"jogos");
				}else {
					msg = "Algo deu errado";
					jogos = listarAllJogos();
					return retorno(model,"jogos");
				}
			}else {
				String data = params.get("txtData");
				if(!data.equals("") && data != null) {
					jogos = listarJogos(LocalDate.parse(data));
				}			
				return retorno(model,"jogos");
			}
		}
		return retorno(model,"jogos");
	}
    
    @RequestMapping(name = "jogos", value = "jogos", method = RequestMethod.PUT)
	public ModelAndView doPostJogo(@RequestBody JogoParam jogo,ModelMap model) throws ServletException, IOException {
    	limparAtributos();
    	jogos = listarAllJogos();	
		System.out.println("btn "+jogo.toString());	

		return retorno(model,"jogos");
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
	
	protected void limparAtributos() {
		erro = "";
		msg = "";
		data = "";
		jogos = new ArrayList<>();
	}
	
	protected ModelAndView retorno(ModelMap model,String pagina) throws ServletException, IOException {
		model.addAttribute("erro", erro);
		model.addAttribute("res", msg);
		model.addAttribute("jogos", jogos);
		model.addAttribute("data", data);
		return new ModelAndView(pagina);
	}
}
