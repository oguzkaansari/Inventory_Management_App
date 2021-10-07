package servlets;

import com.google.gson.Gson;
import entities.Checkout;
import entities.Dashboard;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import utils.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "dashboardServlet", value ="/dashboard-get")
public class DashboardServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Session session = sf.openSession();
        List<Dashboard> ls = session.createQuery("from Dashboard").getResultList();
        session.close();

        String strJson = gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write(strJson);

    }
}
