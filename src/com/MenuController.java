package com;

import java.util.List;

import javax.ws.rs.QueryParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.ImportResource;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import entities.MenuItems;
import entities.TableInfo;
import service.MenuJpaService;
import utils.CommonUtils;

@RestController
@RequestMapping("/v1")
@ImportResource(value = { "classpath:applicationContext-dao-jpa-configuration.xml" })
public class MenuController {

	@Autowired
	@Qualifier("menuservice")
	private MenuJpaService menuService;

	public MenuJpaService getMenuService() {
		return menuService;
	}

	public void setMenuService(MenuJpaService menuService) {
		this.menuService = menuService;
	}

	public MenuController(MenuJpaService menuService) {
		this.menuService = menuService;
	}

	public MenuController() {
	}

	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public ModelAndView getMenuDetails(@QueryParam("tableNumber") String tableNumber) {

		ModelAndView modelAndView = new ModelAndView();

		// fetch menu list from db
		List<MenuItems> menuList = menuService.fetchMenuItems();
		String tableNo = tableNumber==null? "1" : tableNumber;
		
		TableInfo tableInfo = menuService.fetchTableInfo(tableNo);

		modelAndView.setViewName("menu");
		modelAndView.addObject("menuList", menuList);
		
		modelAndView.addObject("tableNumber", tableNumber);
		if (tableInfo != null){
			modelAndView.addObject("orderList", tableInfo.getOrders());
		}
		return modelAndView;
	}

	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public void addOrderDetails(@RequestBody String body) {

		try {

			TableInfo tableInfo = CommonUtils.jsonStringToObject(body, TableInfo.class);
			// add table, order, customer and bill info
			menuService.addOrder(tableInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/removeOrder", method = RequestMethod.POST)
	public void removeOrderDetails(@RequestBody String body) {

		try {
			TableInfo tableInfo = CommonUtils.jsonStringToObject(body, TableInfo.class);
			// remove table, order, customer and bill info
			menuService.removeOrder(tableInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/modifyOrderQuatity", method = RequestMethod.POST)
	public void modifyOrderQuantity(@RequestBody String body) {

		try {
			TableInfo tableInfo = CommonUtils.jsonStringToObject(body, TableInfo.class);
			// remove table, order, customer and bill info
			menuService.modifOrderQuantity(tableInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
