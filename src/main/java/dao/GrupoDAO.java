package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Grupo;
import model.Time;

public class GrupoDAO extends DAO<Grupo> {
	
	public GrupoDAO(Connection cn) {
		this.cn = cn;
	}
	
	@Override
	public int create() throws SQLException {

		return 0;
	}

	@Override
	public Grupo read(Grupo obj) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Grupo obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Grupo obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Grupo> listAll() throws SQLException {
		List<Grupo> grupos = new ArrayList<Grupo>();
		StringBuffer sql = new StringBuffer();
		sql.append("{CALL sp_inseretime } ");
		CallableStatement cs = cn.prepareCall(sql.toString());
		ResultSet rs = cs.executeQuery();
		while (rs.next()) {
			Time t = new Time(); 
			
			Grupo g = new Grupo();
			g.setGrupo(rs.getString("Grupo").charAt(0));
			g.setTime(t);
			grupos.add(g);
		}
		cs.execute();
		cs.close();		
		
		return grupos;
	}

}
