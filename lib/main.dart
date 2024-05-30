import 'package:floor_database/database/app_database.dart';
import 'package:floor_database/pages/note_edit_page.dart';
import 'package:floor_database/services/note_service.dart';
import 'package:flutter/material.dart';
import 'models/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteListPage(database: database),
    );
  }
}

class NoteListPage extends StatefulWidget {
  final AppDatabase database;

  NoteListPage({required this.database});

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late NoteService noteService;
  late Future<List<Note>> notesFuture;

  @override
  void initState() {
    super.initState();
    noteService = NoteService(widget.database);
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      notesFuture = noteService.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('Floor Database',style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<List<Note>>(
        future: notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final notes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NoteEditPage(noteService: noteService, note: note),
                      ),
                    );
                    if (result != null) {
                      _loadNotes();
                    }
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await noteService.deleteNote(note);
                      _loadNotes();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditPage(noteService: noteService),
            ),
          );
          if (result != null) {
            _loadNotes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
