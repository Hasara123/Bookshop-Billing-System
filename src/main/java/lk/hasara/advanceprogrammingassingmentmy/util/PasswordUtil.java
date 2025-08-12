package lk.hasara.advanceprogrammingassingmentmy.util;

public class PasswordUtil {
    public static String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hashed = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashed) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        System.out.println("admin123 hash: " + hashPassword("admin123"));
        System.out.println("cashier123 hash: " + hashPassword("cashier123"));
    }
}
