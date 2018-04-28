package dao;

import java.util.List;

import entities.TableInfo;

public interface TableInfoDao {
	
	public void addOrderToTable(TableInfo tableInfo);
	public TableInfo fetchTableInfo(String tableNumber);
	public void deleteOrder(TableInfo tableInfo, String orderId);

}
