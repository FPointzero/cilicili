package xyz.fpointzero.controller;

import xyz.fpointzero.model.User;
import xyz.fpointzero.util.EmailSender;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/sendEmail")
public class EmailSendServlet extends MyHttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        EmailSender.sendEmail(email);
    }
}
