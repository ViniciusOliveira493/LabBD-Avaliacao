package dao;

import java.sql.Connection;

public abstract class DAO<T> implements IDao<T>{
	Connection cn = null;
}
