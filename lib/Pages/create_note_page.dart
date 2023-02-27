import 'package:ebook/Model/note_model.dart';
import 'package:ebook/Pages/notes_page.dart';
import 'package:ebook/Provider/note_list.dart';
import 'package:ebook/Widgets/note_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class CreateNotePage extends StatefulWidget {
  String? initialTitle;
  String? initialDesc;
  DateTime? id;
  String? label;
  bool edit;
  CreateNotePage(
      {super.key,
      this.initialTitle,
      this.initialDesc,
      required this.edit,
      this.label,
      this.id});
  static String routeName = '/create-note';

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _noteTitle = TextEditingController();

  final TextEditingController _noteDesc = TextEditingController();
  final TextEditingController _noteLabel = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final notesData = Provider.of<Notes>(context, listen: false);
      if (widget.edit) {
        notesData.noteUpdate(Note(
            noteTitle: _noteTitle.text,
            dateCreated: widget.id!,
            noteDescription: _noteDesc.text,
            label: _noteLabel.text));
      } else {
        notesData.noteadd(Note(
            noteTitle: _noteTitle.text,
            noteDescription: _noteDesc.text,
            dateCreated: DateTime.now(),
            label: _noteLabel.text));
      }
      return true;
    }
    return false;
  }

  labelSaveFuntion() {
    setState(() {
      widget.label = _noteLabel.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _noteTitle.text = widget.initialTitle ?? '';
    _noteDesc.text = widget.initialDesc ?? '';
    _noteLabel.text = widget.label ?? '';
  }

  onTap(double height) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NoteOptions(
          notesExists: widget.initialTitle.toString().isEmpty,
          height: height,
          id: widget.id ?? DateTime.now(),
          labelController: _noteLabel,
          labelFunction: labelSaveFuntion,
          createCpyFunction: createCopy,
          shreNoteFunction: shareNote,
        );
      },
    );
  }

  shareNote() {
    Share.share('${_noteTitle.text}\n ${_noteDesc.text}');
  }

  createCopy() {
    final notesData = Provider.of<Notes>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      notesData.noteadd(Note(
          noteTitle: _noteTitle.text,
          noteDescription: _noteDesc.text,
          dateCreated: DateTime.now(),
          label: _noteLabel.text));
      Navigator.of(context).pushReplacementNamed(NotesPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: Color.fromARGB(255, 14, 18, 26)),
        height: height * 1 / 11,
        child: Row(children: [
          IconButton(
            onPressed: () {
              onTap(height);
            },
            icon: const Icon(
              Icons.add_box,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.color_lens,
                color: Colors.white,
              )),
          Expanded(
            child: Center(
              child: Text(
                'Edited ${DateFormat('h:mm a').format(DateTime.now())}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ]),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            save(context);
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_left_sharp,
            color: Color.fromARGB(255, 50, 104, 254),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (save(context)) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.check_circle_outline,
                color: Color.fromARGB(255, 50, 104, 254),
              ))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                  controller: _noteTitle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Title')),
              Text(
                '${DateFormat('E, h:mm').format(widget.id ?? DateTime.now())} | ${_noteDesc.text.length} Characters',
                style: const TextStyle(color: Colors.grey),
              ),
              if (widget.label != '' && widget.label != null)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  child: Text(
                    widget.label!,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: _noteDesc,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Description'),
                maxLines: null,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
