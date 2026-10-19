# Java Servlet Project

A Java web application experiment for learning server-side request handling with Servlets.

## Overview

A Servlet runs on a servlet container and handles HTTP requests and responses. This project is intended for practicing Servlet concepts; its exact functionality depends on the source code.

## Concepts

- Servlet classes and URL mappings
- HTTP request and response handling
- GET and POST methods, if implemented
- Forwarding or redirecting requests, if implemented

## Technologies

- Java
- Jakarta/Java Servlet API, depending on the project's configuration
- Apache Tomcat, if configured for this project

## Prerequisites

- A compatible JDK
- Apache Tomcat or another compatible servlet container
- Maven or the project's configured build process, if applicable

## How to Run

1. Open the `Exp6-servlet` folder.
2. Check the project's build file and servlet API version.
3. Build the project using its configured build process.
4. Deploy the generated web application to the configured servlet container.
5. Start the server and open the mapped URL in a browser.

For a Maven project, the build command may be:

```bash
mvn clean package
```

Use the actual context path and servlet URL mapping configured in this project.

## Troubleshooting

- Check the server logs for deployment or compilation errors.
- Confirm the servlet URL mapping.
- Ensure the Servlet API dependency matches the container version.

## Author

Add your name here.
