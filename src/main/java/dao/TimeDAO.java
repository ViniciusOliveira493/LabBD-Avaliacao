package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Time;

public class TimeDAO{
	Connection cn = null;
	public TimeDAO(Connection cn) {
		this.cn = cn;
	}
	
	public Time read(Time obj) throws SQLException {
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
		return obj;
	}
	
	public List<Time> listAll() throws SQLException {
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
		return lista;
	}
}
