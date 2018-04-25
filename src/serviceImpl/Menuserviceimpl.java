package serviceImpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.MenuDao;
import entities.MenuItems;
import service.MenuJpaService;

@Service("menuservice")
public class Menuserviceimpl implements MenuJpaService {
	
	@Autowired
	@Qualifier("menudao")
	private MenuDao menuDao;

	public MenuDao getMenuDao() {
		return menuDao;
	}

	public void setMenuDao(MenuDao menuDao) {
		this.menuDao = menuDao;
	}
	public Menuserviceimpl(MenuDao menuDao){
		this.menuDao=menuDao;
	}

	public Menuserviceimpl(){}
	
	
	@Override
	@Transactional(rollbackOn=Exception.class)
	public List<MenuItems> fetchMenuItems() {
		List<MenuItems> menuList = new ArrayList<MenuItems>();
		try{
		
			menuList = menuDao.fetchMenuList();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return menuList;
	}

}
