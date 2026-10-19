# Java Development Projects

A collection of Java projects and practical exercises covering core Java, server-side development, networking, RMI, JDBC, and web applications.

## Projects

| Project | Overview |
|---|---|
| **Exp1-StudentRegistration** | Student registration project. Add exact features and technologies after checking the source code. |
| **Exp2-BasicCalculator** | Basic calculator project for arithmetic operations. |
| **Exp4-ServerClient** | Java server-client networking experiment. |
| **Exp5-RMI_ClientServer** | Java Remote Method Invocation (RMI) client-server experiment. |
| **Exp6-servlet** | Java Servlet experiment for web request and response handling. |
| **Pacelet** | E-commerce web application using Java web technologies, with shopping and checkout workflows. |
| **StudentRegistrationWithJDBC** | Student registration project using JDBC for database connectivity. |

## Technologies

Technologies represented by the project names and current Pacelet setup include:

- Java
- Java Servlets and JSP
- Apache Tomcat
- Maven
- JDBC
- MySQL
- Java RMI
- HTML and CSS

Confirm each project's actual technologies from its source files and dependencies before treating this list as exhaustive.

## Repository Structure

```text
Java-Development-Projects/
├── Exp1-StudentRegistration/
├── Exp2-BasicCalculator/
├── Exp4-ServerClient/
├── Exp5-RMI_ClientServer/
├── Exp6-servlet/
├── Pacelet/
└── StudentRegistrationWithJDBC/
```

The directory names reflect the projects shown in the workspace. The repository may also contain folders such as `.git`.

## Getting Started

### Prerequisites

Depending on the project, you may need:

- A compatible JDK
- An IDE such as Visual Studio Code, IntelliJ IDEA, or Eclipse
- Apache Tomcat for Servlet/JSP applications
- Maven for Maven-based projects
- MySQL Server and MySQL Workbench for projects using MySQL

### Run a Project

1. Clone or download this repository.
2. Open the folder for the project you want to run.
3. Review that project's configuration and source files.
4. Configure any required database connection or server settings.
5. Build and run it using the instructions appropriate for that project.

Setup requirements may differ between projects. Add project-specific commands after verifying them.

## Project Details

### 1. Exp1-StudentRegistration

**Purpose:** Student registration experiment.

- **Language:** Confirm from source files.
- **Features:** Document the registration features implemented.
- **How to run:** Add verified steps.

### 2. Exp2-BasicCalculator

**Purpose:** Basic calculator application.

- **Language:** Confirm from source files.
- **Features:** Document the arithmetic operations supported by the implementation.
- **How to run:** Add verified steps.

### 3. Exp4-ServerClient

**Purpose:** Server-client communication experiment.

- **Language:** Confirm from source files.
- **Concepts:** Document the networking concepts implemented.
- **How to run:** Document the server/client startup order and required ports.

### 4. Exp5-RMI_ClientServer

**Purpose:** Java RMI client-server experiment.

- **Language:** Confirm from source files.
- **Concepts:** Remote interfaces, remote method calls, and registry setup, if implemented.
- **How to run:** Document the registry, server, and client startup steps for this implementation.

### 5. Exp6-servlet

**Purpose:** Servlet-based web application experiment.

- **Technologies:** Java Servlets; add JSP, Tomcat, or build-tool details if used.
- **Concepts:** Document request handling, responses, and servlet mapping as implemented.
- **How to run:** Document the configured server and deployment steps.

### 6. Pacelet

**Purpose:** E-commerce web application.

- **Technologies:** Java, JSP, Servlets, Apache Tomcat, Maven, and MySQL.
- **Workflows:** Customer registration and login, profile details, shopping cart, shipping address, payment/review steps, and order-related pages.
- **Database:** MySQL database named `pacelet`.
- **Context path:** `/pacelet` in the current local setup.

**Local setup notes**

1. Install a compatible JDK, Maven, Apache Tomcat, and MySQL.
2. Create/configure the `pacelet` database using the project's SQL schema.
3. Set database credentials in the database connection configuration. Never commit real passwords.
4. Build from the Maven project root:

   ```bash
   mvn clean package
   ```

5. Deploy the generated WAR to the configured Tomcat server.
6. Open the application at the configured local URL, for example:

   ```text
   http://localhost:8080/pacelet/
   ```

Adjust the URL, database settings, and deployment steps to match your environment.

### 7. StudentRegistrationWithJDBC

**Purpose:** Student registration with JDBC database connectivity.

- **Language:** Confirm from source files.
- **Database:** Confirm the database and table names from source/configuration.
- **Features:** Document implemented create, read, update, or delete operations, if present.
- **How to run:** Document the JDBC driver and database setup.

## Security and Configuration

- Never commit database passwords, API keys, or other secrets.
- Use environment variables or a local, untracked configuration file for credentials.
- Avoid including real user data in screenshots or sample database exports.

## Future Improvements

- Add screenshots and a short demo for each project.
- Document exact dependencies and versions.
- Add verified build/run commands for every project.
- Add a separate README inside larger projects if they need their own setup instructions.

## Author

**Your Name**

Replace this placeholder with your preferred name and optionally add links to your GitHub profile or portfolio.
