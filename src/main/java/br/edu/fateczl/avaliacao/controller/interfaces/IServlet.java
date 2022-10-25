package br.edu.fateczl.avaliacao.controller.interfaces;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.ServletException;

@Component
public interface IServlet {
	public ModelAndView doGet(ModelMap model)  throws ServletException, IOException;
	public ModelAndView doPost(ModelMap model) throws ServletException, IOException;
}
