package xyz.fpointzero.model;

import org.apache.ibatis.session.SqlSession;
import xyz.fpointzero.mapper.UserMapper;
import xyz.fpointzero.util.DateUtil;
import xyz.fpointzero.util.MyBatisUtil;

import java.time.Duration;

public class User {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String phoneNumber;
    private String avatar;
    private String verification;
    private String verificationTime;

    public static User loginByCode(String email, String code) {
        User result = null;
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            User user = mapper.getByEmail(email);
            if (user.verify(code)) {
                user.setUser(user);
                result = user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean login() {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            // 调用数据访问接口的方法进行数据操作
//            User entity = mapper.getById(1);
            User user = null;
            if (username == null)
                user = mapper.getByEmail(email);
            else
                user = mapper.getByUsername(username);

//            System.out.println(user.password + "-" + password);
            if (user.getPassword().equals(password)) {
//                this.username = user.username;
//                this.phoneNumber = user.phoneNumber;
//                this.email = user.email;
//                this.avatar = user.avatar;
//                this.password = null;
                setUser(user);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    /**
     * 验证码验证，验证过就失效
     *
     * @return
     */
    public boolean verify(String code) {
        boolean result = false;
        Duration duration = DateUtil.getDurationTime(this.verificationTime);
        if (!this.verification.equals("null")) {
            result = duration.toMinutes() < 5 && code.equals(this.verification);
            if (result) {
                try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
                    sqlSession.getMapper(UserMapper.class).setVery("null", this.email);
                    sqlSession.commit();
                }
            }
        }
        return result;
    }

    public String signIn(String code) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);

            User user = mapper.getByEmail(email);
            String very = user.getVerification();
            String time = user.getVerificationTime();

            Duration duration = DateUtil.getDurationTime(time);

            if (!very.equals("null")) {
                if (duration.toMinutes() < 5) {
                    if (code.equals(very)) {
                        mapper.setUsername(username, email);
                        mapper.setPassword(password, email);
                        mapper.setVery("null", email);
                        sqlSession.commit();
                        setUser(user);
                        return "注册成功";
                    } else {
                        return "验证码错误";
                    }
                } else {
                    return "验证码失效";
                }
            } else {
                return "请先申请验证码";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "MyBatisUtil加载错误";
        }
    }

    public boolean changePassword(String code, String password) {
        boolean ret = false;
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
            User user = userMapper.getByEmail(email);

            if (user.verify(code)) {
                userMapper.setPassword(password, email);
                ret = true;
            }

            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    public boolean updateAvatar(String avatar) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            mapper.setAvatar(avatar, username);
            sqlSession.commit();
            setAvatar(avatar);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAll(User user) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            this.setUser(user);
            mapper.setAll(this);
            sqlSession.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void setUser(User user) {
        if (user.id != null)
            this.id = user.id;
        if (user.username != null)
            this.username = user.username;
        if (user.phoneNumber != null)
            this.phoneNumber = user.phoneNumber;
        if (user.email != null)
            this.email = user.email;
        if (user.avatar != null)
            this.avatar = user.avatar;
        this.password = null;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getUsername() {
        return username;
    }

    public String getVerification() {
        return verification;
    }

    public String getVerificationTime() {
        return verificationTime;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAvatar() {
        return avatar;
    }
}
