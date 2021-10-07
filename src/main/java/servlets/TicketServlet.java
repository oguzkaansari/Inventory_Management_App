package servlets;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import entities.Indent;
import entities.Product;
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

@WebServlet(name = "ticketServlet", value = {"/ticket-post", "/ticket-get", "/ticket-order-delete"})
public class TicketServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Session session = sf.openSession();
        int cu_id = 0;
        String start_date = "";
        String end_date = "";


        try {
            cu_id = Integer.parseInt(req.getParameter("cu_id"));
            List<Ticket> ls = session.createQuery("from Ticket where customer.cu_id = :cu_id")
                    .setParameter("cu_id", cu_id)
                    .getResultList();
            String strJson = gson.toJson(ls);
            resp.setContentType("application/json");
            resp.getWriter().write(strJson);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int tid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson =  new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

            Ticket ticket = gson.fromJson(obj, Ticket.class);
            System.out.println(ticket);

            //ticket.getIndents().forEach(sesi::save);

            sesi.saveOrUpdate(ticket);
            tr.commit();
            sesi.close();
            tid = 1;
        }catch ( Exception ex) {
            System.err.println("Save OR Update Error : " + ex);
        }finally {
            sesi.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write( "" +tid );

    }


    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Session session = sf.openSession();
        Transaction tr = session.beginTransaction();
        int return_id = 0;
        try {
            int t_id = Integer.parseInt(req.getParameter("t_id"));
            int i_id = Integer.parseInt(req.getParameter("i_id"));

            Ticket ticket = session.find(Ticket.class, t_id);
            Indent indent = session.find(Indent.class, i_id);

            ticket.getIndents().remove(indent);

            tr.commit();
            return_id = ticket.getT_id();
        } catch (HibernateException e) {
            System.err.println("Customer delete error : " + e);
        }finally {
            session.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write(return_id);

    }
}
