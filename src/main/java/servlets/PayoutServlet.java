package servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import entities.Payout;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "payoutServlet", value = {"/payout-post", "/payout-get", "/payout-delete"})
public class PayoutServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Session session = sf.openSession();
        String start_date;
        String end_date;

        try{

            boolean isSDNull = req.getParameter("start_date") == null;
            boolean isEDNull = req.getParameter("end_date") == null;

            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");

            if(isSDNull){
                start_date = "0000-00-00";
            }else{
                start_date = req.getParameter("start_date");
            }
            if(isEDNull){
                end_date = "9999-99-99";
            }else{
                end_date = req.getParameter("end_date");
            }

            Date parsedStart = format.parse(start_date);
            java.sql.Date start_date_sql = new java.sql.Date(parsedStart.getTime());

            Date parsedEnd = format.parse(end_date);
            java.sql.Date end_date_sql = new java.sql.Date(parsedEnd.getTime());

            List<Payout> ls = session.createQuery("from Payout where payout_date between :start_date AND :end_date ")
                    .setParameter("start_date", start_date_sql)
                    .setParameter("end_date", end_date_sql)
                    .getResultList();
            String strJson = gson.toJson(ls);
            resp.setContentType("application/json");
            resp.getWriter().write(strJson);

        }catch (Exception e)
        {
            System.err.println("Payout get error : " + e);
        }finally {
            session.close();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int pid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson =  new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
            Payout payout = gson.fromJson(obj, Payout.class);
            sesi.saveOrUpdate(payout);
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
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Session session = sf.openSession();
        Transaction tr = session.beginTransaction();
        int return_id = 0;
        try {
            int p_id = Integer.parseInt(req.getParameter("payout_id"));
            Payout payout = session.load(Payout.class, p_id);
            session.delete(payout);
            tr.commit();
            return_id = payout.getPayout_id();
        } catch (HibernateException e) {
            System.err.println("Customer delete error : " + e);
        }finally {
            session.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write(return_id);

    }
}
