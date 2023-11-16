package com.acorn.baemin.cart.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.baemin.cart.domain.CartInfoDTO;
import com.acorn.baemin.cart.service.CartServiceImp;
import com.acorn.baemin.domain.MenuDTO;
import com.acorn.baemin.domain.StoreDTO;
import com.acorn.baemin.domain.UserDTO;
import com.acorn.baemin.order.service.UserOrderServiceImp;

@Controller
public class CartController {

	@Autowired
	CartServiceImp cartService;

	@Autowired
	UserOrderServiceImp userOrderService;

	@PostMapping("/cartList")
	public String receiveCartData( CartInfoDTO cartInfoDTO, Model model, @RequestParam int menuCode, HttpServletRequest request) {
		List<StoreDTO> storeInfo = cartService.selectStoreInfo(menuCode);
		List<MenuDTO> menuInfo = cartService.selectMenuInfo(menuCode);
		model.addAttribute("cartInfo", cartInfoDTO);
		model.addAttribute("menuInfo", menuInfo);
		model.addAttribute("storeInfo", storeInfo);
		
		HttpSession session = request.getSession();
		session.setAttribute("cartInfo", cartInfoDTO);
		session.setAttribute("menuInfo", menuInfo);
		session.setAttribute("storeInfo", storeInfo);
	    return "home/cart_list";
	}

	@PostMapping("/order")
	public String placeOrder(@RequestParam int totalPrice, HttpSession session, Model model, CartInfoDTO cartInfoDTO) {
		session.setAttribute("totalPrice", totalPrice);
		Integer userCode = (Integer)session.getAttribute("userCode");
		List<UserDTO> userInfo = userOrderService.getUserByCode(userCode);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("userInfo", userInfo);
		List<StoreDTO> storeInfo = (List<StoreDTO>) session.getAttribute("storeInfo");
	    return "userorder/order";
	}
	
	
	
}
