package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("userController")
public class UserController {
	
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['auth.cookie.admin.name']}")  
	private String AUTH_COOKIE_ADMIN_NAME;
	
	@Autowired
	private UserService userService;
	
	//**********************************
	//로그인 페이지로 이동
	@RequestMapping(value="/user/loginForm")
	public String loginForm(HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId)) {
			return "/main/index";
		}else {
			
			return "/user/loginForm";
		}
		
	}
	
	//**************************
	//로그인
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> login(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId)) {
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			res.setResponse(500, "Ready User");
		}else {
			
			if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)) {
				User user = userService.userSelect(userId);
				
				
				if(user != null) {
					if(StringUtil.equals(user.getUserPwd(), userPwd)) {
						
						//회원정보를 아이디로 가져와 비밀번호가 일치할시
						//쿠키아이디 생성후 로그인 성공
						
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
						
						res.setResponse(0, "Login Success");
					}else {
						
						//패스워드 불일치 로그인 실패
						res.setResponse(-1, "Bad Password");
					}
				}else {
					//회원정보 존재하지않음 로그인 실패
					res.setResponse(404, "Not Found User");
				}
			}else {
				//회원아이디, 비밀번호가 넘어오지않아 로그인실행불가
				res.setResponse(400, "Bad Parameter");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/login response\n" + JsonUtil.toJsonPretty(res));
			}
		}
		
		return res;
	}
	
	
	//************************************
	//로그아웃
	@RequestMapping(value="/user/logout", method=RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response) {
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		
		return "redirect:/";
	}
	
	
	//*********************************
	//로그인페이지에서 회원가입 페이지로 이동
	@RequestMapping(value="/user/regForm")
	public String regForm(HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(StringUtil.isEmpty(cookieUserId)) {
			
			//로그인 하지 않았을때 회원가입페이지로 이동
			return "/user/regForm";
		}else {
			
			//로그인되었을때 회원가입페이지로 이동 X
			return "redirect:/";
		}
	}
	
	//*************************************
	//회원가입 페이지에서 아이디 중복체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		
		if(!StringUtil.isEmpty(userId)) {
			if(userService.userSelect(userId) == null) {
				//동일한 아이디로 존재하는 유저가 없음. 가입가능
				res.setResponse(0, "Reg Ok");
			}else {
				//동일한 아이디의 회원이 있음. 가입 불가
				res.setResponse(-1, "User Duplicate");
			}
			
		}else {
			
			//회원 아이디가 넘어오지 않았을 때 중복체크 실패
			res.setResponse(400, "Bad Request");
		}
		
		return res;
	}
	
	//*******************************
	//회원가입 페이지에서 이메일 중복 체크
	@RequestMapping(value="/user/emailCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> emailCheck(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		String userEmail = HttpUtil.get(request, "userEmail");
		
		if(!StringUtil.isEmpty(userEmail)) {
			
			if(userService.userEmailDuplicateCheck(userEmail) <= 0) {
				res.setResponse(0, "Reg Ok");
				
			}else {
				
				res.setResponse(-1, "Email Duplicate");
			}
		}else {
			//회원 이메일이 넘어오지 않았을 때 중복체크 실패
			res.setResponse(400, "Bad Request");
		}
		 logger.debug("res : " + res);
		return res;
	}
	
	//********************************************
	//회원가입 페이지에서 닉네임으로 중복 체크
	@RequestMapping(value="/user/nicknameCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nicknameCheck(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		String userNickname = HttpUtil.get(request, "userNickname");
		
		if(!StringUtil.isEmpty(userNickname)) {
			
			if(userService.userNicknameDuplicateCheck(userNickname) <= 0) {
				res.setResponse(0, "Reg Ok");
				
			}else {
				
				res.setResponse(-1, "Email Duplicate");
			}
		}else {
			//회원 이메일이 넘어오지 않았을 때 중복체크 실패
			res.setResponse(400, "Bad Request");
		}
		 logger.debug("res : " + res);
		return res;
	}
	
	//회원가입
		@RequestMapping(value="/user/regProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response) {
			Response<Object> res = new Response<Object>();
			String userId = HttpUtil.get(request, "userId", "");
			String userPwd = HttpUtil.get(request, "userPwd1", "");
			String userName = HttpUtil.get(request, "userName", "");
			String userEmail = HttpUtil.get(request, "userEmail", "");
			String userNickname = HttpUtil.get(request, "userNickname", "");
			String userPhoneNo = HttpUtil.get(request, "userPhoneNo", "");
			String userAddress = HttpUtil.get(request, "userAddress", "");
			int userPostcode = HttpUtil.get(request, "userPostcode", 0);
			String userDetailAddress = HttpUtil.get(request, "userDetailAddress", "");
			String userExtraAddress = HttpUtil.get(request, "userExtraAddress", "");
			
			//파라미터값 정상적으로 들어왔는지 체크
			if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userName) 
				&& !StringUtil.isEmpty(userNickname) && !StringUtil.isEmpty(userPhoneNo) && !StringUtil.isEmpty(userAddress) && 
				!StringUtil.isEmpty(userPostcode) &&!StringUtil.isEmpty(userDetailAddress) &&!StringUtil.isEmpty(userExtraAddress)) {
				
				//정상적으로 들어오면 유저 객체에 set하여 Service로 넘겨줌.
				User user = new User();
				
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				user.setUserNickname(userNickname);
				user.setUserPhoneNo(userPhoneNo);
				user.setUserAddress(userAddress);
				user.setUserPostcode(userPostcode);
				user.setUserDetailAddress(userDetailAddress);
				user.setUserExtraAddress(userExtraAddress);
				
				//아이디 중복체크
				if(userService.userSelect(userId) == null) {
					
					//아이디 중복 없음 성공
					if(userService.userEmailDuplicateCheck(userEmail) > 0) {
						//중복된 이메일 가입 실패
						res.setResponse(-3, "Email Duplicate");
					}else {
						//이메일 중복없음 성공
						if(userService.userNicknameDuplicateCheck(userNickname) > 0) {
							//닉네임 중복 가입 실패
							res.setResponse(-4, "UserNickname Duplicate");
						}else {
							
							if(userService.userReg(user) > 0) {
								//회원등록 성공
								res.setResponse(0, "Reg Success");
							}else {
								//회원등록 실패
								res.setResponse(-1, "Reg Fail");
							}
						}
					}	
				}else {
					//회원 아이디 중복
					res.setResponse(-2, "User Id Duplicate");
				}
			}else {
				//파라미터값 없음
				res.setResponse(400, "Bad Parameter");
			}
			
			return res;
		}
	
}
