package servlets;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import entities.Customer;
import entities.Ticket;
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

@WebServlet(name = "customerServlet", value = {"/customer-post", "/customer-get", "/customer-delete"})
public class CustomerServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int cid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            Customer customer = gson.fromJson(obj, Customer.class);
            sesi.saveOrUpdate(customer);
            tr.commit();
            sesi.close();
            cid = 1;
        }catch ( Exception ex) {
            System.err.println("Save OR Update Error : " + ex);
        }finally {
            sesi.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write( "" +cid );
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Session session = sf.openSession();
        List<Customer> ls = session.createQuery("from Customer").getResultList();
        session.close();

        String strJson = gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write(strJson);
    }

    //customer-delete
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Session session = sf.openSession();
        Transaction tr = session.beginTransaction();
        int return_id = 0;
        try {
            int cu_id = Integer.parseInt(req.getParameter("cu_id"));
            Customer customer = session.load(Customer.class, cu_id);
            session.delete(customer);
            tr.commit();
            return_id = customer.getCu_id();
        } catch (HibernateException e) {
            System.err.println("Customer delete error : " + e);
        }finally {
            session.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write(return_id);

    }


}
