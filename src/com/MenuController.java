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
import service.MenuJpaService;


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
	
	public MenuController(MenuJpaService menuService){
		this.menuService=menuService;
	}
	
	public MenuController(){}

	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public ModelAndView pay() {
		
		ModelAndView modelAndView= new ModelAndView();
		
		List<MenuItems> menuList = menuService.fetchMenuItems();
		
		modelAndView.setViewName("menu");
		modelAndView.addObject("menuList",menuList);
		return modelAndView;
	}
	/*public ModelAndView pay(@RequestParam(value = "key") String key, @RequestBody MenuRequest request) {*/
}
