package br.edu.fateczl.avaliacao.persistence;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.avaliacao.model.Grupo;
import br.edu.fateczl.avaliacao.model.Time;

@Repository
public class GrupoDAO extends DAO<Grupo> {
	@Autowired	
	Conexao conn = new Conexao();	
	
	public GrupoDAO() {
		
	}
	
	@Override
	public List<Grupo> listAll2() throws SQLException {
		this.cn = conn.getConexao();
		List<Grupo> grupos = new ArrayList<Grupo>();
		StringBuffer query = new StringBuffer();
		query.append("SELECT gr.Grupo AS Grupo,tm.CodigoTime AS codigoTime,tm.NomeTime AS nomeTime,tm.Cidade AS cidade"
				+ ",tm.Estadio as estadio ");
		query.append("FROM Times tm INNER JOIN Grupos gr ");
		query.append("ON gr.CodigoTime = tm.CodigoTime ");
		query.append("ORDER BY gr.Grupo ");
	
		PreparedStatement ps = cn.prepareStatement(query.toString());
	
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time(); 
			t.setCodigoTime(rs.getInt("codigoTime"));
			t.setNomeTime(rs.getString("nomeTime"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			
			Grupo g = new Grupo();
			g.setGrupo(rs.getString("Grupo"));
			g.setTime(t);
			grupos.add(g);
		}	
		ps.close();
		rs.close();
		this.cn.close();
		return grupos;
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
		this.cn = conn.getConexao();
		List<Grupo> grupos = new ArrayList<Grupo>();
		JogosDAO d = new JogosDAO();
		d.delete();
		String sql = "{CALL sp_inseretime } ";
		CallableStatement cs = cn.prepareCall(sql);
		cs.execute();
		cs.close();	
		StringBuffer query = new StringBuffer();
		query.append("SELECT gr.Grupo AS Grupo,tm.CodigoTime AS codigoTime,tm.NomeTime AS nomeTime,tm.Cidade AS cidade"
				+ ",tm.Estadio as estadio ");
		query.append("FROM Times tm INNER JOIN Grupos gr ");
		query.append("ON gr.CodigoTime = tm.CodigoTime ");
		query.append("ORDER BY gr.Grupo ");
	
		PreparedStatement ps = cn.prepareStatement(query.toString());
	
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time(); 
			t.setCodigoTime(rs.getInt("codigoTime"));
			t.setNomeTime(rs.getString("nomeTime"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			
			Grupo g = new Grupo();
			g.setGrupo(rs.getString("Grupo"));
			g.setTime(t);
			grupos.add(g);
		}	
		ps.close();
		rs.close();
		this.cn.close();
		return grupos;
	}

	@Override
	public int create() throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


}
