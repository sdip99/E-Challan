package org.echallan.filter;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.echallan.Common;
import org.echallan.valueObject.User;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter("/*")
public class AuthenticationFilter implements Filter {
	String[] adminPages = {
		"add_catagory.jsp",
		"add_officer.jsp",
		"add_rule.jsp",
		"admin_dashboard.jsp",
		"annual_report.jsp",
		"history_income.jsp",
		"history_income.jsp",
		"insert_area.jsp",
		"insert_checkpost.jsp",
		"insert_city.jsp",
		"manage_area.jsp",
		"manage_catagory.jsp",
		"manage_challan.jsp",
		"manage_checkpost.jsp",
		"manage_city.jsp",
		"manage_complaint.jsp",
		"manage_officer.jsp",
		"manage_rule.jsp",
		"stat_area.jsp",
		"stat_city.jsp",
		"stat_generic_line.jsp",
		"stat_generic_pie.jsp",
		"stub_admin_sidebar.jsp",
		"system_setting.jsp",
		"update_area.jsp",
		"update_catagory.jsp",
		"update_checkpost.jsp",
		"update_city.jsp",
		"update_rule.jsp",
		"view_complaint.jsp",
		"view_user.jsp"
	};
	String[] userPages = {
		"change_pass.jsp",
		"generate_challan_get_license_no.jsp",
		"generate_challan_new.jsp",
		"generate_challan_view_result.jsp",
		"generate_challan.jsp",
		"manage_challan_police.jsp",
		"police_dashboard.jsp",
		"profile.jsp",
		"stub_police_sidebar.jsp"
	};
	String[] commonPages = {
		"stub_header.jsp",
		"view_challan.jsp"
	};
	String[] nofilterPages = {
		"forgot_pass.jsp",
		"index.jsp",
		"login.jsp",
		"stub_sidebar.jsp",
		"stub_header.jsp",
		"Controller"
	};

    public AuthenticationFilter() {
    	
    }

	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpSession session =((HttpServletRequest) request).getSession();
		HttpServletResponse hres = (HttpServletResponse) response;
		User user = null;
		String str = "login.jsp";
		String uri = ((HttpServletRequest)request).getRequestURI();
		Object obj = session.getAttribute("user_info");
		System.out.println("Do filter" + uri);
		if(uri.contains("/images") || uri.contains("/js") || uri.contains("/lib") || uri.contains("/stylesheets") || allowAccess(uri, nofilterPages)) {
			chain.doFilter(request, response);
			return;
		}
		if(obj != null) {
			user = (User) obj;
			if(allowAccess(uri, commonPages)) {
				chain.doFilter(request, response);
				return;
			}
			if(user.getUserType() == Common.USER_TYPE_ADMIN) {
				if(allowAccess(uri, adminPages)) {
					chain.doFilter(request, response);
					return;
				} else {
					str = "admin_dashboard.jsp";
					session.setAttribute("unAuthAccess", uri);
				}
			} else {
				if(allowAccess(uri, userPages)) {
					chain.doFilter(request, response);
					return;
				} else {
					str = "police_dashboard.jsp";
					session.setAttribute("unAuthAccess", uri);
				}
			}
		}
		hres.sendRedirect(str);
	}
	
	public void init(FilterConfig fConfig) throws ServletException {
		
	}
	
	private boolean allowAccess(String uri, String[] allowed) {
		for(String str : allowed)
			if(uri.contains(str))
				return true;
		return false;
	}

}
