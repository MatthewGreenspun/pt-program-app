# PT Program

An app to help physical therapists manage exercise programs.

## Front End

A flutter app for IOS and Android. It works on all screen sizes but works best on tablets.

### Folder Structure

#### lib/screens

Contains widgets for each screen of the app.

#### lib/services

Contains classes which connect the front end to the back end by performing HTTP requests.

#### lib/models

Contains classes for each entity in the app.

#### lib/widgets

Contains shared widgets.

## Back End

### Folder Structure

#### src/db

Contains SQL code and PostgreSQL client.

#### src/middleware

Contains middleware used in the Express API.

#### src/services

Contains classes which connect the back end to the database.

#### src/routes

Contains code for the Express API.

#### src/utils

Contains utility functions.
