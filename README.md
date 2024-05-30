## Plugin Used
- [floor](https://pub.dev/packages/floor)

## Basics of Floor
**Entity** : It will represent a database table as well as your business object. It is like a table in SQL which few properties.
**Data Access Object(DAO)** : This component is responsible for managing access to the underlying SQLite database. The abstract class contains the method signatures for querying the database.
**Database** : It has to be an abstract class that extends FloorDatabase.Using this abstract you can access DAO.

Generate Floor Database Code:
Floor uses code generation to create the database implementation. Run the following command to generate the necessary files:

`flutter pub run build_runner build --delete-conflicting-outputs`

To automatically run it, whenever a file changes, use `flutter packages pub run build_runner watch`

## Project Structure

- `lib/main.dart`: Entry point of the application.
- `lib/models/note.dart`: Defines the Note entity.
- `lib/dao/note_dao.dart`: Data Access Object (DAO) for Note entity.
- `lib/database/app_database.dart`: Floor database setup.
- `lib/services/note_service.dart`: Service layer for handling business logic.
- `lib/screens/note_edit_page.dart`: UI for adding and editing notes.
