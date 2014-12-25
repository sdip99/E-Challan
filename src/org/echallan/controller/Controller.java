package org.echallan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.echallan.Common;
import org.echallan.dataAccessObject.UserDAO;
import org.echallan.valueObject.User;
import org.echallan.valueObject.UserDetail;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("submit").equals("Sign In")) {
			HttpSession session = request.getSession();
			String pass = request.getParameter("password");
			User vo = new User();
			vo.setUserID(request.getParameter("username"));
			vo.setPassword(pass);
			UserDAO dao = new UserDAO();
			vo = dao.search(vo);
			if(vo == null) {
				// Username doesn't exist, don't match password just redirect 
				session.setAttribute("invalidLogin", true);
				response.sendRedirect("login.jsp");
				return;
			} else {
				if(pass.equals(vo.getPassword())) {
					// Everything ok send to homepage & store user info into session
					session.setAttribute("user_info", vo);
					if(vo.getUserType() == Common.USER_TYPE_NORMAL) {
						// user is an officer so load his addition information also
						response.sendRedirect("index.jsp");
					} else {
						response.sendRedirect("admin_dashboard.jsp");
					}
				} else {
					// password doesn't match
					session.setAttribute("invalidLogin", true);
					response.sendRedirect("login.jsp");
				}
			}
		} else if(request.getParameter("submit").equals("Insert Officer")) {
			HttpSession session = request.getSession();
			String fname = request.getParameter("first_name");
			String lname = request.getParameter("last_name");
			String mobileNo = request.getParameter("mobile_no");
			String street = request.getParameter("street");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			String pass = request.getParameter("password");
			int pincode = Integer.parseInt(request.getParameter("pincode"));
			String cityAssign = request.getParameter("city_drop");
			String areaAssign = request.getParameter("area_drop");
			int subAreaAssign = Integer.parseInt(request.getParameter("subarea_drop"));
			System.out.println(fname + "|" + lname +"|"+mobileNo+"|" +street+"|" +city+"|"+pincode+"|"+cityAssign+"|"+areaAssign+"|"+subAreaAssign);
			UserDetail userDetail = new UserDetail(fname, lname, mobileNo);
			User user = new User(email, pass, 0);
			user.setUserDetail(userDetail);
			userDetail.setUser(user);
			UserDAO dao = new UserDAO();
			dao.insert(user);
			session.setAttribute("success", true);
			response.sendRedirect("add_officer.jsp");
		}
	}

}
