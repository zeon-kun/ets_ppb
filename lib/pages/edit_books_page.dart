import 'package:flutter/material.dart';
import 'package:ets_ppb/db/books_database.dart';
import 'package:ets_ppb/model/books.dart';

class AddEditBookPage extends StatefulWidget {
  final Book? book;
  const AddEditBookPage({this.book, super.key});

  @override
  State<AddEditBookPage> createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formkey = GlobalKey<FormState>();
  late String onChangedTitle;
  late String onChangedDescription;

  @override
  void initState() {
    super.initState();
    onChangedTitle = widget.book?.title ?? '';
    onChangedDescription = widget.book?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarTextStyle: const TextStyle(color: Colors.white),
        actions: [
          saveButton(),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.book?.title,
                  validator: (value) {
                    if(value != null && value.isEmpty) return 'Title cannot be empty';
                    return null;
                  },
                  onChanged: (title) {
                    setState(() {
                      onChangedTitle = title;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white30
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  initialValue: widget.book?.description,
                  validator: (value) {
                    if(value != null && value.isEmpty) return 'Book description cannot be empty';
                    return null;
                  },
                  onChanged: (descrption) {
                    setState(() {
                      onChangedDescription = descrption;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Book description goes here ...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white30
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }

  Widget saveButton() {
    return IconButton(
      onPressed: () {
        bool isValid = _formkey.currentState!.validate();
        if(isValid) {
          if(widget.book != null) {
            Book updated = widget.book!.copy(
              title: onChangedTitle,
              description: onChangedDescription,
            );

            print({'updated book is: id ${widget.book!.id}'});

            BooksDatabase.instance.update(updated);
          } else {
            BooksDatabase.instance.create(
              Book(title: onChangedTitle, description: onChangedDescription, createdTime: DateTime.now())
            );
          }
          Navigator.pop(context);
        }
      },
      icon: const Icon(Icons.save)
    );
  }
}