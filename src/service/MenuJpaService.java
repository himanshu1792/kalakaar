package service;

import java.util.List;

import entities.MenuItems;

public interface MenuJpaService {
	
	public List<MenuItems> fetchMenuItems();

}
