package br.edu.fateczl.avaliacao.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import br.edu.fateczl.avaliacao.model.Classificacaogr;
import dao.Conexao;
import dao.JogosDAO;
import model.Grupo;
import model.Jogo;
import src.main.java.br.edu.fateczl.avaliacao.persistence.ClassificacaogrDAO;

@Controller
public class JogosServlet{
	private String erro = "";
	private String msg = "";
	private String data = "";
	private List<classificacaogr> classi = new ArrayList<>();
	
    public JogosServlet() {
        super();
    }
    
    
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

    
    //
    @RequestMapping(name = "classifica", value = "classificagr", method = RequestMethod.POST)
	public ModelAndView doPost(@RequestParam Map<String, String> params,ModelMap model) throws ServletException, IOException {	
		String btn = params.get("btn");
		if(btn!=null) {
			if(btn.equals("Pesquisar")) {
			{
				String gr = params.get("txtGrupo");
				if(!gr.equals("") && gr != null) {
					classi = listarJogos(gr);
				}			
				return retorno(model,"Classifica");
			}
		}
		return retorno(model,"Classifica");
	}
    
	
	private int createClassi() {
		Conexao conn = new Conexao();
		Connection cn = conn.getConexao();
		try {
			cn = conn.getConexao();
			ClassificacaogrDAO c = new ClassificacaogrDAO();
			return c.create();
		} catch (SQLException e) {
			erro = e.getMessage();
		} finally {
			conn.close(cn);
		}
		return -1;
	}
	
	private List<classificacaogr> listarGrupos(int it) {
		List<classificacaogr> classi = null;
		
		if(data.equals("")) {
			return classi;
		}
		
		try {
			ClassificacaogrDAO c = new ClassificacaogrDAO();
			classi = c.list(it);
		} catch (Exception e) {
			erro = e.getMessage();
		} 
		
		return classi;
	}
	

	

	
	protected void limparAtributos() {
		erro = "";
		msg = "";
		data = "";
		classi = new ArrayList<>();
	}
	
	protected ModelAndView retorno(ModelMap model,String pagina) throws ServletException, IOException {
		model.addAttribute("erro", erro);
		model.addAttribute("res", msg);
		model.addAttribute("classificados", classi);
		model.addAttribute("data", data);
		return new ModelAndView(pagina);
	}
}
