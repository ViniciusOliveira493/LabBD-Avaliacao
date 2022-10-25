package br.edu.fateczl.avaliacao.persistence;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface IDao<T> {	
	public int create() throws SQLException;
	public T read(T obj)  throws SQLException;
	public int update(T obj)  throws SQLException;
	public int delete(T obj)  throws SQLException;
	public List<T> listAll()  throws SQLException;
	List<T> listAll2() throws SQLException;
}
