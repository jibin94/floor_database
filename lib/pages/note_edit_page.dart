import 'package:floor_database/models/note.dart';
import 'package:floor_database/services/note_service.dart';
import 'package:flutter/material.dart';

class NoteEditPage extends StatefulWidget {
  final NoteService noteService;
  final Note? note;

  const NoteEditPage({super.key, required this.noteService, this.note});

  @override
  NoteEditPageState createState() => NoteEditPageState();
}

class NoteEditPageState extends State<NoteEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: Text(
          widget.note == null ? 'Add Note' : 'Edit Note',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final id = widget.note?.id ??
                        DateTime.now().millisecondsSinceEpoch;
                    final note = Note(
                      id,
                      _titleController.text,
                      _contentController.text,
                    );

                    if (widget.note == null) {
                      await widget.noteService.addNote(note);
                    } else {
                      await widget.noteService.updateNote(note);
                    }

                    Navigator.pop(context, "updated");
                  }
                },
                child: Text(widget.note == null ? 'Add' : 'Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
