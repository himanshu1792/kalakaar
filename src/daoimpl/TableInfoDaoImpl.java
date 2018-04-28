package daoimpl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.TableInfoDao;
import entities.MenuItems;
import entities.TableInfo;
import enums.TableStatus;

@Repository("tabledao")
public class TableInfoDaoImpl implements TableInfoDao {

	@Autowired
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public TableInfoDaoImpl() {
	}

	public TableInfoDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void addOrderToTable(TableInfo tableInfo) {
		
		Session sess = sessionFactory.getCurrentSession();
		sess.saveOrUpdate(tableInfo);

	}

	@SuppressWarnings("unchecked")
	@Override
	public TableInfo fetchTableInfo(String tableNumber) {

		TableInfo tableDetails = new TableInfo();

		try {
			Session sess = sessionFactory.getCurrentSession();
			Query q = sess
					.createQuery("select t from TableInfo t where t.tableNumber=:tableNumber and t.status=:status");
			q.setParameter("tableNumber", tableNumber);
			q.setParameter("status", TableStatus.A);

			tableDetails = (TableInfo) q.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tableDetails;

	}

	@Override
	public void deleteOrder(TableInfo tableInfo, String orderCode) {
		
		Session sess = sessionFactory.getCurrentSession();
		Query q = sess
				.createQuery("delete from Order o where o.itemCode=:itemCode and o.tableInfo=:tableInfo");
		q.setParameter("itemCode", orderCode);
		q.setParameter("tableInfo", tableInfo);

		q.executeUpdate();

		
	}

}
