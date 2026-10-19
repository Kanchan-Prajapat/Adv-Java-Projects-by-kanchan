# Pacelet — E-commerce Web Application

Pacelet is a Java-based e-commerce web application. The current project includes customer shopping and checkout workflows.

## Features and Workflows

Based on the current project structure and implementation work:

- Customer registration and login
- Session-based authentication state
- Profile information and address editing
- Product browsing and shopping cart
- Coupon and discount handling
- Shipping address and checkout steps
- Payment and order review pages
- Order-related pages, including order history/details

Some workflows may still be under development or require further database integration; verify each feature in the running application before describing it as complete.

## Technology Stack

- Java
- JSP
- Jakarta Servlets
- Apache Tomcat 11
- Maven
- MySQL
- HTML and CSS

## Requirements

- A compatible JDK (the current local environment uses JDK 24)
- Maven
- Apache Tomcat 11
- MySQL Server and optionally MySQL Workbench
- Visual Studio Code or another Java IDE

## Database Setup

The configured database name is `pacelet`.

1. Start MySQL Server.
2. Create the `pacelet` database if it does not already exist.
3. Create the required tables using the project's SQL schema.
4. Configure the database URL, username, and password in the database connection class or local configuration.
5. Never commit real database credentials to version control.

The application currently uses a local MySQL connection at `localhost:3306/pacelet`. Adjust it for your environment if necessary.

## Build

From the Pacelet Maven project root:

```bash
mvn clean package
```

If Java environment variables are not configured in a Windows terminal, set them to match your installed JDK and Maven locations before building.

## Deployment

1. Build the project.
2. Deploy the generated WAR file to the configured Tomcat 11 instance.
3. Start Tomcat.
4. Open the configured application URL. The current local context path is:

   ```text
   http://localhost:8080/pacelet/
   ```

Your actual URL may differ depending on the deployment configuration.

## Project Structure

The project follows a Java web application structure with source code under `src/main/java` and JSP/assets under `src/main/webapp`. Main code packages include controllers, DAO classes, data access, and models.

## Security Notes

- Store password hashes, not plaintext passwords.
- Keep database credentials private.
- Validate all submitted form data on the server.
- Use authorization checks when displaying profile and order data.

## Future Improvements

- Finish and verify database-backed order persistence.
- Ensure checkout always uses the authenticated user's saved profile/address.
- Add project screenshots and a demonstration.
- Document database schema setup and tested deployment steps.

## Author

Add your name here.
