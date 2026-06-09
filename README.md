# AppointmentManagerApp

A mobile application developed with Flutter that allows users to manage clients and appointments through a local SQLite database.

## Overview

The purpose of this project was to learn mobile application development using Flutter, local data persistence with SQLite, and relational database design using foreign keys.

The application enables users to register clients, schedule appointments, update records, and maintain data relationships between entities.

## Features

* Client registration and management.
* Appointment scheduling.
* Update existing records.
* Delete clients and appointments.
* Local data persistence using SQLite.
* Relational database structure with foreign keys.
* User-friendly mobile interface.

## Technologies

* Flutter
* Dart
* SQLite (sqflite package)

## Database Structure

The application uses two related tables:

```text
PERSONA
│
└── CITA
```

### PERSONA

Stores client information:

* IDPERSONA
* NOMBRE
* TELEFONO

### CITA

Stores appointment information:

* IDCITA
* LUGAR
* FECHA
* HORA
* ANOTACIONES
* IDPERSONA

Foreign key relationships are used to maintain data integrity between clients and appointments.

## Main Functionalities

### Client Management

* Create clients
* View clients
* Update client information
* Delete clients

### Appointment Management

* Create appointments
* View appointments
* Update appointments
* Delete appointments

## Learning Outcomes

This project provided practical experience in:

* Mobile application development with Flutter.
* SQLite database integration.
* CRUD operations.
* Relational database modeling.
* Foreign key implementation.
* Local data persistence.
* User interface development.

## Project Type

Academic project developed as part of a Mobile Application Development course.
