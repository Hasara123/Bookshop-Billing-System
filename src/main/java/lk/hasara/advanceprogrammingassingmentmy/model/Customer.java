package lk.hasara.advanceprogrammingassingmentmy.model;

public class Customer {
    private int id;
    private String name;
    private String accountNo; // add this
    private String address;
    private String phone;

    // Constructor for new customer (without id)
    public Customer(String name, String accountNo, String address, String phone) {
        this.name = name;
        this.accountNo = accountNo;
        this.address = address;
        this.phone = phone;
    }

    // Constructor with id (for update)
    public Customer(int id, String name, String accountNo, String address, String phone) {
        this.id = id;
        this.name = name;
        this.accountNo = accountNo;
        this.address = address;
        this.phone = phone;
    }

    public Customer() {

    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAccountNo() { return accountNo; }
    public void setAccountNo(String accountNo) { this.accountNo = accountNo; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
