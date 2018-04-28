package com;

import java.util.List;

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
	public ModelAndView getMenuDetails() {

		ModelAndView modelAndView = new ModelAndView();

		//fetch menu list from db
		List<MenuItems> menuList = menuService.fetchMenuItems();

		modelAndView.setViewName("menu");
		modelAndView.addObject("menuList", menuList);
		return modelAndView;
	}

	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public void addOrderDetails(@RequestBody String body) {

		try {
			
			TableInfo tableInfo = CommonUtils.jsonStringToObject(body,TableInfo.class);
			//add table, order, customer and bill info 
			menuService.addOrder(tableInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping(value = "/removeOrder", method = RequestMethod.POST)
	public void removeOrderDetails(@RequestBody String body) {

		try {
			TableInfo tableInfo = CommonUtils.jsonStringToObject(body,TableInfo.class);
			//remove table, order, customer and bill info 
			menuService.removeOrder(tableInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	/*
	 * public ModelAndView pay(@RequestParam(value = "key") String
	 * key, @RequestBody MenuRequest request) {
	 */
}
