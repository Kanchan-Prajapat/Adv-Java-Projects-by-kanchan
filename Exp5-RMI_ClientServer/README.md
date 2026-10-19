# Java RMI Client-Server Architecture

A Java project for exploring Remote Method Invocation (RMI).

## Overview

Java RMI allows an object in one Java Virtual Machine to invoke methods on an object in another Java Virtual Machine. A typical RMI setup includes a remote interface, a remote implementation, an RMI registry, a server, and a client.

The exact classes and startup commands should match this project's source code.

## Architecture

1. **Remote interface** — declares methods that can be called remotely.
2. **Remote implementation** — implements the remote methods.
3. **RMI registry** — allows the client to look up a remote object by name.
4. **Server** — registers or binds the remote object.
5. **Client** — looks up the remote object and invokes its methods.

> Verify which of these components are present in your implementation before using this as a complete description.

## Technologies

- Java
- Java RMI APIs

## Prerequisites

- A compatible JDK
- An IDE or terminal

## How to Run

1. Open the `Exp5-RMI_ClientServer` folder.
2. Identify the remote interface, implementation, server, and client classes.
3. Compile all required Java source files.
4. Start the RMI registry if your implementation requires a separately started registry.
5. Start the server.
6. Start the client in another terminal.

Use the actual class names and package structure from the project. If you use `rmiregistry`, run it with the required classpath and port for your setup.

## Troubleshooting

- Ensure client and server use the same registry host, port, and binding name.
- Check package names and classpaths.
- Confirm the registry and server are running before the client performs lookup.

## Author

Add your name here.
