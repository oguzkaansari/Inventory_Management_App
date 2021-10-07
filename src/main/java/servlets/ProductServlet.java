package servlets;

import com.google.gson.Gson;
import entities.Product;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import utils.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "productServlet", value = {"/product-post", "/product-get", "/product-delete"})
public class ProductServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int pid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            Product product = gson.fromJson(obj, Product.class);
            sesi.saveOrUpdate(product);
            tr.commit();
            sesi.close();
            pid = 1;
        }catch ( Exception ex) {
            System.err.println("Save OR Update Error : " + ex);
        }finally {
            sesi.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write( "" +pid );

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Session session = sf.openSession();
        List<Product> ls = session.createQuery("from Product ").getResultList();
        session.close();

        String strJson = gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write(strJson);

    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Session session = sf.openSession();
        Transaction tr = session.beginTransaction();
        int return_id = 0;
        try {
            int p_id = Integer.parseInt(req.getParameter("p_id"));
            Product product = session.load(Product.class, p_id);
            session.delete(product);
            tr.commit();
            return_id = product.getP_id();
        } catch (HibernateException e) {
            System.err.println("Customer delete error : " + e);
        }finally {
            session.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write(return_id);

    }

}
