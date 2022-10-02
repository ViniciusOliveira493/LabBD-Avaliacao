package dao;

import java.sql.Connection;
import java.sql.SQLException;
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
		// TODO Auto-generated method stub
		return null;
	}

}
