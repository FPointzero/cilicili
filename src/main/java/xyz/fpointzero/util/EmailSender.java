package xyz.fpointzero.util;

import org.apache.ibatis.session.SqlSession;
import xyz.fpointzero.mapper.UserMapper;
import xyz.fpointzero.model.User;
import xyz.fpointzero.Setting.*;

import javax.mail.*;
import javax.mail.internet.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.Random;

import static xyz.fpointzero.Setting.*;

public class EmailSender {
    // 验证码范围
    private static int min = 100000; // 最小值
    private static int max = 999999; // 最大值

    public static void sendEmail(String email) {
        // 收件人信息
        String recipientEmail = email;

        // 创建随机数生成器
        Random random = new Random();
        // 生成6位验证码
        int randomNumber = random.nextInt(max - min + 1) + min;

        // 邮件主题和内容
        String emailSubject = "验证码";
        String emailContent = String.valueOf(randomNumber);

        try {
            // 设置邮件服务器属性
            Properties props = new Properties();
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.port", smtpPort);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // 其他 QQ 邮箱特定配置
            props.put("mail.smtp.ssl.trust", smtpHost);  // 添加信任的主机

            // 创建Session对象
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            // 创建邮件消息
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(emailSubject);
            message.setText(emailContent);

            try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
                UserMapper mapper = sqlSession.getMapper(UserMapper.class);
                // 调用数据访问接口的方法进行数据操作
                try{
                    mapper.setEmail(email);
                } catch (Exception e) {
//                    e.printStackTrace();
                    mapper.setVery(String.valueOf(randomNumber), email);
                    // 发送邮件
                    Transport.send(message);
                }
                sqlSession.commit();

            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
