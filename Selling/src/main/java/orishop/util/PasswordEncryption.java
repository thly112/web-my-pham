package orishop.util;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

public class PasswordEncryption {

  private static final int KEY_LENGTH = 256;
  private static final int ITERATION_COUNT = 65536;

  public static String encrypt(String strToEncrypt, String secretKey, String salt) {

    try {

        SecureRandom secureRandom = new SecureRandom();
        byte[] iv = new byte[16];
        secureRandom.nextBytes(iv);
        IvParameterSpec ivspec = new IvParameterSpec(iv);

        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        KeySpec spec = new PBEKeySpec(secretKey.toCharArray(), salt.getBytes(), ITERATION_COUNT, KEY_LENGTH);
        SecretKey tmp = factory.generateSecret(spec);
        SecretKeySpec secretKeySpec = new SecretKeySpec(tmp.getEncoded(), "AES");

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivspec);

        byte[] cipherText = cipher.doFinal(strToEncrypt.getBytes("UTF-8"));
        byte[] encryptedData = new byte[iv.length + cipherText.length];
        System.arraycopy(iv, 0, encryptedData, 0, iv.length);
        System.arraycopy(cipherText, 0, encryptedData, iv.length, cipherText.length);

        return Base64.getEncoder().encodeToString(encryptedData);
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }
  }

  public static String decrypt(String strToDecrypt, String secretKey, String salt) {

    try {

        byte[] encryptedData = Base64.getDecoder().decode(strToDecrypt);
        byte[] iv = new byte[16];
        System.arraycopy(encryptedData, 0, iv, 0, iv.length);
        IvParameterSpec ivspec = new IvParameterSpec(iv);

        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        KeySpec spec = new PBEKeySpec(secretKey.toCharArray(), salt.getBytes(), ITERATION_COUNT, KEY_LENGTH);
        SecretKey tmp = factory.generateSecret(spec);
        SecretKeySpec secretKeySpec = new SecretKeySpec(tmp.getEncoded(), "AES");

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivspec);

        byte[] cipherText = new byte[encryptedData.length - 16];
        System.arraycopy(encryptedData, 16, cipherText, 0, cipherText.length);

        byte[] decryptedText = cipher.doFinal(cipherText);
        return new String(decryptedText, "UTF-8");
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }
  }
  public static void main(String[] args) {

	    String secretKey = Constant.SECRETKEY;
	    String salt = Constant.SALT;

	    
	    String originalString = "password";

	    String encryptedString = PasswordEncryption.encrypt(originalString, secretKey, salt);
	    if (encryptedString.equals("tjyAWBgBaaLovSHi26IPkEsv5BzQY12xcC29hyds7Q8=")) {
	        System.out.println("Encrypted: " + encryptedString);
	    } else {
	        System.err.println("Encryption failed.");
	        return;
	    }

	    // Decrypt the string
	    String decryptedString = PasswordEncryption.decrypt(encryptedString, secretKey, salt);
	    if (decryptedString != null) {
	        System.out.println("Decrypted: " + decryptedString);
	    } else {
	        System.err.println("Decryption failed.");
	    }
	  }

}