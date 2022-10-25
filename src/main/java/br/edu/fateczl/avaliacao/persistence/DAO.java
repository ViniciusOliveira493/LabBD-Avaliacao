package br.edu.fateczl.avaliacao.persistence;

import java.sql.Connection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public abstract class DAO<T> implements IDao<T>{
	Connection cn;
}
