package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import model.Jogo;

public class JogosDAO extends DAO<Jogo> {
	
	public JogosDAO(Connection cn) {
		this.cn = cn;
	}
	
	@Override
	public int create() throws SQLException {
		String query = "{CALL sp_criarRodadas(?)}";
		CallableStatement cs = cn.prepareCall(query);
		cs.registerOutParameter(1, Types.BIT);
		cs.execute();
		int retorno = cs.getInt(1);
		cs.close();		
		return retorno;
	}

	@Override
	public Jogo read(Jogo obj) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Jogo obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Jogo obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Jogo> listAll() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
