package br.edu.fateczl.avaliacao.model;

import org.springframework.stereotype.Service;

@Service
public class Grupo {
	private String grupo;
	private Time time;
	
	
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}	
}
