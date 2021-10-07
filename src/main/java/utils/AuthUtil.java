package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthUtil {

    public static final String base_url = "http://localhost:8080/DepoProject_war_exploded/";

    public static String MD5(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }

    public static String createMD5Password( String data, int count )  {
        String passString = MD5(data);
        for (int i = 0; i < count - 1; i++) {
            passString = MD5(passString);
        }
        return passString;
    }

    public static void createSession(Object [] adm, boolean remember, HttpServletRequest req, HttpServletResponse resp){

        req.getSession().setAttribute("aid", adm[0]);
        req.getSession().setAttribute("email", adm[1]);
        req.getSession().setAttribute("password", adm[2]);

        if(remember){
            String value = adm[0]+"_"+adm[1]+"_"+adm[2];
            value = value.replaceAll( " ", "_");
            Cookie cookie = new Cookie("user", value);
            cookie.setMaxAge(60*60*24); // Oturum 24 saat açýk kalýr.
            resp.addCookie(cookie);
        }

    }

    public static void checkLoggedIn(HttpServletRequest request, HttpServletResponse response, int data){

        if(request.getCookies() != null){

            Cookie[] cookies = request.getCookies();

            for(Cookie cookie : cookies){

                if(cookie.getName().equals("user")){

                    String values = cookie.getValue();
                    System.out.println(values);
                    try {
                        String[] arr = values.split("_");
                        request.getSession().setAttribute("aid", Integer.parseInt(arr[0]));
                        request.getSession().setAttribute("email", arr[1]);
                        request.getSession().setAttribute("password", arr[2]);

                    } catch (NumberFormatException e) {
                        Cookie cookie1 = new Cookie("user", "");
                        cookie1.setMaxAge(0);
                        response.addCookie(cookie1);
                    }
                    break;

                }
            }
        }
        Object sessionObj = request.getSession().getAttribute("aid");
        if(sessionObj == null){

            try {
                response.sendRedirect(base_url + "index.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{

            if(data == 1){
                try {
                    response.sendRedirect(base_url + "dashboard.jsp");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
