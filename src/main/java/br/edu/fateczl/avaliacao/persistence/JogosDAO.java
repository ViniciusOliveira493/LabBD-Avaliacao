package br.edu.fateczl.avaliacao.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import br.edu.fateczl.avaliacao.model.Jogo;
import br.edu.fateczl.avaliacao.model.Time;


public class JogosDAO {
	Connection cn = null;
	List<Time> times = null;
	
	public JogosDAO(Connection cn) throws SQLException {
		this.cn = cn;
		TimeDAO td = new TimeDAO(cn);
		this.times = td.listAll();
	}
	
	public int create() throws SQLException {
		String query = "{CALL sp_criarRodadas}";
		CallableStatement cs = cn.prepareCall(query);
		cs.execute();
		cs.close();		
		return 1;
	}

	public int delete() throws SQLException {
		String query = "DELETE FROM Jogos";
		PreparedStatement pstm = cn.prepareStatement(query);
		pstm.execute();
		pstm.close();		
		return 1;
	}

	public List<Jogo> listAll() throws SQLException {
		List<Jogo> jogos = new ArrayList<Jogo>();
		String query = "SELECT codigoTimeA AS cta, codigoTimeB as ctb"
							  + ", golsTimeA as gta, golsTimeB as gtb"
							  + ", CONVERT(VARCHAR(15),datajogo,103) AS datajogo "
							  + ", datajogo as dt "
				      + " FROM Jogos ORDER BY dt";
		PreparedStatement pstm = cn.prepareStatement(query);
		ResultSet rs = pstm.executeQuery();
		while(rs.next()) {
			Jogo j = new Jogo();
			j.setTimeA(encontrarTimePorCodigo(rs.getInt("cta")));
			j.setTimeB(encontrarTimePorCodigo(rs.getInt("ctb")));
			j.setGolsTimeA(rs.getInt("gta"));
			j.setGolsTimeB(rs.getInt("gtb"));
			j.setDatajogo(rs.getString("datajogo"));
			jogos.add(j);
		}
		return jogos;
	}
	
	public List<Jogo> list(LocalDate dt) throws SQLException {
		List<Jogo> jogos = new ArrayList<Jogo>();
		String query = "SELECT codigoTimeA AS cta, codigoTimeB as ctb"
				  + ", golsTimeA as gta, golsTimeB as gtb"
				  + ", CONVERT(VARCHAR(15),datajogo,103) AS datajogo "
	      + " FROM Jogos WHERE dataJogo = ?";
		PreparedStatement pstm = cn.prepareStatement(query);
		pstm.setString(1, dt.toString());
		ResultSet rs = pstm.executeQuery();
		while(rs.next()) {
			Jogo j = new Jogo();
			j.setTimeA(encontrarTimePorCodigo(rs.getInt("cta")));
			j.setTimeB(encontrarTimePorCodigo(rs.getInt("ctb")));
			j.setGolsTimeA(rs.getInt("gta"));
			j.setGolsTimeB(rs.getInt("gtb"));
			j.setDatajogo(rs.getString("datajogo"));
			jogos.add(j);
		}
		return jogos;
	}
	
	private Time encontrarTimePorCodigo(int cod) {
		for(Time t:times) {
			if(t.getCodigoTime() == cod) {
				return t;
			}
		}
		return new Time();
	}
}
