# BookHeaven – Online Bookstore

**BookHeaven** is a modern online bookstore built with **C# ASP.NET MVC**.  
It offers a smooth shopping experience with browsing, detailed book views, cart management, and secure payment handling.  
Credit card data is protected with **AES encryption**, and transactions are processed through **Stripe’s trusted payment gateway**.  
The project features a clean **MVC architecture** for data access and a simple, responsive user interface.

## Features

- **Book Catalog:** Browse a collection of books with titles, authors, pricing, and descriptions.
- **Book Details Page:** View in-depth information for each book.
- **Shopping Cart:** Add items, update quantities, and simulate a full checkout flow.
- **AES encryption:** Protects credit card data with strong, secure encryption.
- **Stripe integration:** Enables safe, real-world payment processing.
- **MVC Architecture:** Organized Models, Views, and Controllers for clean scalability.
- **Simple & Responsive UI:** Clean layout for smooth browsing and purchasing.

## Clone Repository

To get started, clone the repository:

```shell
git clone https://github.com/Shayhha/BookHeaven
```

## Configuration

Before running the project, create appsettings.json file with your database and Stripe configuration:

```shell
{
  "Stripe": {
    "SecretKey": "your_stripe_secret_key",
    "PublishableKey": "your_stripe_publishable_key"
  },
  "ConnectionStrings": {
    "myConnection": "your_database_connection_string"
  }
}
```

## Usage

1. **Run the project** in your preferred development environment.
2. Navigate to the home page to browse available books.
3. Use the book details and cart functionality to simulate purchases.

## Requirements

Ensure your environment includes:

- **.NET Framework / ASP.NET MVC**
- **SQL Server or LocalDB**

## Contact

- **Shay Hahiashvili**
  - Email: [shayhha@gmail.com](mailto:shayhha@gmail.com)
  - GitHub: [https://github.com/Shayhha](https://github.com/Shayhha)

- **Maxim Subotin**
  - Email: [maxim.sub21@gmail.com](mailto:maxim.sub21@gmail.com)
  - GitHub: [https://github.com/MaxSubotin](https://github.com/MaxSubotin)

## License

 BookHeaven website is released under the [MIT License](LICENSE.txt).
