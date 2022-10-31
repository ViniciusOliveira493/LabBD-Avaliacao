package src.main.java.br.edu.fateczl.avaliacao.persistence;

import src.main.java.br.edu.fateczl.avaliacao.model.Classificacaogr;

@Repository
public class ClassificacaogrDAO {


	@Override
	public int delete(Classificacaogr obj) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Classificacaogr> list(int it) throws SQLException {
		this.cn = conn.getConexao();
		List<Classificacao> lista = new ArrayList<>();
		String query = "select * from fn_grupos(?)"
				+ "order by pontos desc, vitorias desc, golsmarcados desc, saldogols desc"
		PreparedStatement pstm = cn.prepareStatement(query);
		pstm.setString(1, it);
		ResultSet rs = pstm.executeQuery();
		while(rs.next()) {
			Classificacao obj = new Classificacao();
			obj.setNomeTime(rs.getString("nomeTime"));
			obj.setNumeroJogosDisputados(rs.getInt("numJogosDisputados"));
			obj.setVitorias(rs.getInt("vitorias"));
			obj.setEmpates(rs.getInt("empates"));
			obj.setDerrotas(rs.getInt("derrotas"));
			obj.setGolsMarcados(rs.getInt("golsMarcados"));
			obj.setGolsSofridos(rs.getInt("golsSofridos"));
			obj.setSaldoGols(rs.getInt("saldoGols"));
			obj.setPontos(rs.getInt("pontos"));
			lista.add(obj);
		}
		rs.close();
		pstm.close();
		this.cn.close();
		return lista;
	}


}
