package br.edu.fateczl.avaliacao.persistence;

import java.sql.Connection;

public abstract class DAO<T> implements IDao<T>{
	Connection cn = null;
}
