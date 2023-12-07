package com.icia.web.model;

import java.io.Serializable;

public class User implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String userId;					//사용자 계정 아이디
	private String userPwd;					//사용자 계정 비밀번호
	private String userName;				//사용자 이름
	private String userEmail;				//사용자 이메일
	private String userNickname;			//사용자 닉네임
	private String userPhoneNo;				//사용자 전화번호
	private String userAddress;				//사용자 주소
	private String userStatus;				//사용자 상태(Y:정상이용, N:정지)
	private String userRegDate;				//회원가입 날짜(YYYY-MM-DD HH24:MI:SS)
	
	private int userPostcode;   //우편번호
	private String userDetailAddress;   //상세추소
	private String userExtraAddress;   //참고항목
	
	private long startRow;
	private long endRow;
	
	
	
	
	public User() {							//기본생성자 모든변수 공백처리
		userId = "";
		userPwd = "";
		userName = "";
		userEmail = "";
		userNickname = "";
		userPhoneNo = "";
		userAddress = "";
		userStatus = "Y";
		userRegDate = "";
		
		userPostcode=0;
		userDetailAddress="";
		userExtraAddress="";
		
		startRow=0;
		endRow = 0;
		
		
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getUserPhoneNo() {
		return userPhoneNo;
	}

	public void setUserPhoneNo(String userPhoneNo) {
		this.userPhoneNo = userPhoneNo;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getUserRegDate() {
		return userRegDate;
	}

	public void setUserRegDate(String userRegDate) {
		this.userRegDate = userRegDate;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}

	public int getUserPostcode() {
		return userPostcode;
	}

	public void setUserPostcode(int userPostcode) {
		this.userPostcode = userPostcode;
	}

	public String getUserDetailAddress() {
		return userDetailAddress;
	}

	public void setUserDetailAddress(String userDetailAddress) {
		this.userDetailAddress = userDetailAddress;
	}

	public String getUserExtraAddress() {
		return userExtraAddress;
	}

	public void setUserExtraAddress(String userExtraAddress) {
		this.userExtraAddress = userExtraAddress;
	}

	

	
}
