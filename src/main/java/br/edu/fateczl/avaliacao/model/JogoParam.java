package br.edu.fateczl.avaliacao.model;

import org.springframework.stereotype.Service;

import br.edu.fateczl.avaliacao.persistence.TimeDAO;
@Service
public class JogoParam {
	String timeA;
	String timeB;
	String golsA;
	String golsB;
	String data;
	
	
	public String getTimeA() {
		return timeA;
	}


	public void setTimeA(String timeA) {
		this.timeA = timeA;
	}


	public String getTimeB() {
		return timeB;
	}


	public void setTimeB(String timeB) {
		this.timeB = timeB;
	}


	public String getGolsA() {
		return golsA;
	}


	public void setGolsA(String golsA) {
		this.golsA = golsA;
	}


	public String getGolsB() {
		return golsB;
	}


	public void setGolsB(String golsB) {
		this.golsB = golsB;
	}


	public String getData() {
		return data;
	}


	public void setData(String data) {
		this.data = data;
	}


	@Override
	public String toString() {
		return "Time A = " + timeA + " "+ golsA + " VS Time B = " + timeB+ " "+ golsB + " Dia: "+ data;
	}
	
	public Jogo toJogo() {
		Jogo jogo = new Jogo();
		try{
			jogo.setGolsTimeA(Integer.parseInt(golsA));
			jogo.setGolsTimeB(Integer.parseInt(golsB));
			jogo.setDatajogo(data);
			TimeDAO dao = new TimeDAO();
			jogo.setTimeA(dao.read(timeA));
			jogo.setTimeB(dao.read(timeB));
		}catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return jogo;
	}
	
}
