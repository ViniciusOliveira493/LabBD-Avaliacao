package br.edu.fateczl.avaliacao.controller.abstractClasses;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.avaliacao.controller.interfaces.IServlet;
import jakarta.servlet.ServletException;

@Component
public abstract class AbstractServlet implements IServlet{
	
	protected void limparAtributos() {
		
	}
	
	protected ModelAndView retorno(ModelMap model) throws ServletException, IOException {
		return new ModelAndView();
	}
	
}
