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
      System.out.println("Encrypting password: " + strToEncrypt);
      System.out.println("Using SECRETKEY: " + secretKey);
      System.out.println("Using SALT: " + salt);
      
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

          String result = Base64.getEncoder().encodeToString(encryptedData);
          System.out.println("Encrypted result: " + result);
          return result;
      } catch (Exception e) {
          System.err.println("Encryption failed: ");
          e.printStackTrace();
          return null;
      }
  }

  public static String decrypt(String strToDecrypt, String secretKey, String salt) {
      System.out.println("Decrypting password: " + strToDecrypt);
      System.out.println("Using SECRETKEY: " + secretKey);
      System.out.println("Using SALT: " + salt);
      
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
          String result = new String(decryptedText, "UTF-8");
          System.out.println("Decrypted result: " + result);
          return result;
      } catch (Exception e) {
          System.err.println("Decryption failed: ");
          e.printStackTrace();
          return null;
      }
  }
  public static void main(String[] args) {
	    String secretKey = Constant.SECRETKEY;
	    String salt = Constant.SALT;
	    String originalString = "password";

	    String encryptedString = PasswordEncryption.encrypt(originalString, secretKey, salt);
	    if (encryptedString != null) {
	        System.out.println("Encrypted: " + encryptedString);
	        String decryptedString = PasswordEncryption.decrypt(encryptedString, secretKey, salt);
	        if (decryptedString != null && decryptedString.equals(originalString)) {
	            System.out.println("Decrypted: " + decryptedString);
	        } else {
	            System.err.println("Decryption failed.");
	        }
	    } else {
	        System.err.println("Encryption failed.");
	    }
	}

}