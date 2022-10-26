package br.edu.fateczl.avaliacao.model;

import java.time.LocalDate;

import org.springframework.stereotype.Service;
@Service
public class JogoParam {
	String timeA;
	String timeB;
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
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	
	@Override
	public String toString() {
		return "Time A = " + timeA + " VS Time B = " + timeB + "Dia: "+ data;
	}
	
}
