package servlets;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entities.Admin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import utils.AuthUtil;
import utils.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "adminServlet", value ={"/admin-login", "/admin-logout"})
public class AdminServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Session session = sf.openSession();
        try{
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            Admin admin = gson.fromJson(obj, Admin.class);
            List<Object[]> ls = session.createSQLQuery("select a_id, email, password from admin where email = ? and password = ?")
                    .setParameter(1, admin.getEmail())
                    .setParameter(2, AuthUtil.createMD5Password(admin.getPassword(), 3))
                    .list();
            session.close();
            JsonObject jsonObject = new JsonObject();
            if(ls.size() != 0){
                AuthUtil.createSession(ls.get(0), admin.isRemember_me(), req, resp);
                jsonObject.addProperty("loginResult", true);
            }else{
                jsonObject.addProperty("error", "Kullanýcý adý ya da þifre hatalý!");

            }
            String strJson = gson.toJson(jsonObject);
            resp.setContentType("application/json");
            resp.getWriter().write(strJson);

        }catch (Exception e) {
            System.err.println("Login error : " + e);

        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getSession().invalidate();
        Cookie cookie = new Cookie("user", "");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);

        resp.sendRedirect(AuthUtil.base_url + "index.jsp");

    }
}
