package br.edu.fateczl.avaliacao.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.avaliacao.model.Time;

@Repository
public class TimeDAO{
	Conexao conn = new Conexao();
	
	Connection cn = null;
	public TimeDAO() {
	
	}
	
	public Time read(Time obj) throws SQLException {
		this.cn = conn.getConexao();
		String query = "SELECT codigoTime, nomeTime, cidade, estadio "
						+ "FROM Times WHERE codigoTime = ?";
		PreparedStatement pstm = cn.prepareStatement(query);
		pstm.setInt(1, obj.getCodigoTime());
		ResultSet rs = pstm.executeQuery();
		while(rs.next()) {
			obj.setCodigoTime(rs.getInt("codigoTime"));
			obj.setNomeTime(rs.getString("nomeTime"));
			obj.setCidade(rs.getString("cidade"));
			obj.setEstadio(rs.getString("estadio"));
		}
		rs.close();
		pstm.close();
		this.cn.close();
		return obj;
	}
	
	public List<Time> listAll() throws SQLException {
		this.cn = conn.getConexao();
		List<Time> lista = new ArrayList<>();
		String query = "SELECT codigoTime, nomeTime, cidade, estadio "
				+ "FROM Times";
		PreparedStatement pstm = cn.prepareStatement(query);
		ResultSet rs = pstm.executeQuery();
		while(rs.next()) {
			Time obj = new Time();
			obj.setCodigoTime(rs.getInt("codigoTime"));
			obj.setNomeTime(rs.getString("nomeTime"));
			obj.setCidade(rs.getString("cidade"));
			obj.setEstadio(rs.getString("estadio"));
			lista.add(obj);
		}
		rs.close();
		pstm.close();
		this.cn.close();
		return lista;
	}
	
}
