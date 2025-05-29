package orishop.util;

import java.util.Properties;
import java.util.Random;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import orishop.models.AccountModels;

public class Email {
    private static final Logger LOGGER = Logger.getLogger(Email.class.getName());
    
    // Load these from a configuration file or environment variables in production
    private static final String FROM_EMAIL = "nguyenvuongviet2k4@gmail.com";
    private static final String APP_PASSWORD = "crugyyreaqarftfe"; // Replace with Gmail App Password

    public String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    /**
     * Sends a confirmation code email to the user.
     * @param account The account model containing email and code.
     * @return true if email was sent successfully, false otherwise.
     */
    public boolean sendEmail(AccountModels account) {
        return sendEmailInternal(account.getMail(), "Confirm-Code", "Your code is: " + account.getCode());
    }

    /**
     * Sends a password email to the user.
     * @param user The account model containing email and encrypted password.
     * @return true if email was sent successfully, false otherwise.
     */
    public boolean EmailSend(AccountModels user) {
        try {
            String passwordDecryption = PasswordEncryption.decrypt(user.getPassword(), Constant.SECRETKEY, Constant.SALT);
            return sendEmailInternal(user.getMail(), "Your Password", "Password: " + passwordDecryption);
        } catch (Exception e) {
            LOGGER.severe("Failed to decrypt password: " + e.getMessage());
            return false;
        }
    }

    /**
     * Internal method to send an email with the specified subject and body.
     * @param toEmail The recipient's email address.
     * @param subject The email subject.
     * @param body The email body.
     * @return true if email was sent successfully, false otherwise.
     */
    private boolean sendEmailInternal(String toEmail, String subject, String body) {
        try {
            Properties pr = configEmail(new Properties());
            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            LOGGER.info("Email sent successfully to: " + toEmail);
            return true;
        } catch (Exception e) {
            LOGGER.severe("Failed to send email to " + toEmail + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Configures email properties for Gmail SMTP with TLS.
     * @param pr The Properties object to configure.
     * @return Configured Properties object.
     */
    private Properties configEmail(Properties pr) {
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        return pr;
    }
}