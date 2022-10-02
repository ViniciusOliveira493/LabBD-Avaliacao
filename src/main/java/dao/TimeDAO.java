package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Time;

public class TimeDAO extends DAO<Time>{
	
	public TimeDAO(Connection cn) {
		this.cn = cn;
	}
	
	@Override
	public int create() throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Time read(Time obj) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Time obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Time obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Time> listAll() throws SQLException {
		String query = "SELECT * FROM Times";
		PreparedStatement ps =  cn.prepareStatement(query);
		ResultSet rs = ps.executeQuery();
		List<Time> times = new ArrayList<Time>();
		while (rs.next()) {
			Time t = new Time();
			t.setCodigoTime(rs.getInt("CodigoTime"));
			t.setNomeTime(rs.getString("Nome"));
			t.setCidade(rs.getString("Cidade"));
			t.setEstadio(rs.getString("Estadio"));
			times.add(t);
		}
		rs.close();
		ps.close();
		return times;
	}

}
