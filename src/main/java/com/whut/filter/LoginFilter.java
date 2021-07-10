package com.whut.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null && request.getRequestURI().indexOf("/login/doLogin.do") == -1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
