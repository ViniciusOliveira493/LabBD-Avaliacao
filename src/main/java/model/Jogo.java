package model;

import java.time.LocalDate;

public class Jogo {
	private Time timeA;
	private Time timeB;
	private int golsTimeA;
	private int golsTimeB;
	private LocalDate datajogo;
	
	
	public Time getTimeA() {
		return timeA;
	}
	public void setTimeA(Time timeA) {
		this.timeA = timeA;
	}
	public Time getTimeB() {
		return timeB;
	}
	public void setTimeB(Time timeB) {
		this.timeB = timeB;
	}
	public int getGolsTimeA() {
		return golsTimeA;
	}
	public void setGolsTimeA(int golsTimeA) {
		this.golsTimeA = golsTimeA;
	}
	public int getGolsTimeB() {
		return golsTimeB;
	}
	public void setGolsTimeB(int golsTimeB) {
		this.golsTimeB = golsTimeB;
	}
	public LocalDate getDatajogo() {
		return datajogo;
	}
	public void setDatajogo(LocalDate datajogo) {
		this.datajogo = datajogo;
	}
}
