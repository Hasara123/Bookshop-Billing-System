package lk.hasara.advanceprogrammingassingmentmy.model;

public class Item {
    private int id;
    private String title;
    private String author;
    private String isbn;
    private String category;
    private double price;
    private int stock; // New field for stock quantity

    // Constructor without ID
    public Item(String title, String author, String isbn, String category, double price, int stock) {
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    // Constructor with ID
    public Item(int id, String title, String author, String isbn, String category, double price, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}
