package orishop.services;

import java.util.List;


import orishop.DAO.IAccountDAO;
import orishop.DAO.AccountDAOImpl;
import orishop.models.AccountModels;
import orishop.util.Constant;
import orishop.util.PasswordEncryption;

public class AccountServiceImpl implements IAccountService{
	IAccountDAO userDAO = new AccountDAOImpl();
	
	
	@Override
	public List<AccountModels> findAll() {
		return userDAO.findAll();
	}

	@Override
	public AccountModels findOne(int id) {
		return userDAO.findOne(id);
	}

	@Override
	public AccountModels findOne(String username) {
		return userDAO.findOne(username);
	}
	
	@Override
	public void insert(AccountModels model) {
		userDAO.insert(model);
	}

	@Override
	public void insertregister(AccountModels model) {
		userDAO.insertregister(model);
	}

	@Override
	public void update(AccountModels model) {
		AccountModels oldUser = userDAO.findOne(model.getAccountID());
		oldUser.setMail(model.getMail());
		oldUser.setUsername(model.getUsername());
		oldUser.setPassword(model.getPassword());
		oldUser.setRoleID(model.getRoleID());
		oldUser.setStatus(model.getStatus());
		oldUser.setCode(model.getCode());

		userDAO.update(oldUser);
	}

	@Override
	public void updatestatus(AccountModels model) {
		userDAO.updatestatus(model);
	}

	@Override
	public boolean register(String username, String password, String mail, String code) {
		if (userDAO.checkExistEmail(mail))
			return false;
		if (userDAO.checkExistUsername(username))
			return false;
		userDAO.insertregister(new AccountModels(username,password, mail, 1, 0, code));
		return true;
	}

	@Override
    public AccountModels login(String username, String password) {
        // Log thông tin đầu vào
        System.out.println("Login attempt - Username: " + username);
        System.out.println("Input password: " + password);

        AccountModels user = this.findOne(username);
        if (user == null || user.getPassword() == null) {
            System.out.println("User not found or password is null for username: " + username);
            return null;
        }

        // Log mật khẩu mã hóa từ cơ sở dữ liệu
        System.out.println("Encrypted password from database: " + user.getPassword());

        try {
            // Giải mã mật khẩu
            String passwordDecryption = PasswordEncryption.decrypt(user.getPassword(), Constant.SECRETKEY, Constant.SALT);
            
            // Log kết quả giải mã
            if (passwordDecryption != null) {
                System.out.println("Decrypted password: " + passwordDecryption);
            } else {
                System.out.println("Decryption failed: Decrypted password is null");
                return null;
            }

            // So sánh mật khẩu
            if (password.equals(passwordDecryption)) {
                System.out.println("Password match: Login successful for username: " + username);
                return user;
            } else {
                System.out.println("Password does not match: Input password does not match decrypted password");
                return null;
            }
        } catch (Exception e) {
            // Log lỗi chi tiết nếu giải mã thất bại
            System.err.println("Decryption error for username: " + username);
            e.printStackTrace();
            return null;
        }
    }

	@Override
	public boolean checkExistUsername(String username) {
		return userDAO.checkExistUsername(username);
	}

	@Override
	public boolean checkExistEmail(String mail) {
		return userDAO.checkExistEmail(mail);
	}

	@Override
	public void delete(int id) {
		userDAO.delete(id);
	}
}
