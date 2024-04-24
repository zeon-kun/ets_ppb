import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb/db/books_database.dart';
import 'package:ets_ppb/model/books.dart';
import 'package:ets_ppb/pages/edit_books_page.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  const BookDetailPage({required this.bookId, super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isLoading = true;
  late Book book;

  @override
  void initState() {
    super.initState();
    updateBook();
  }

  void updateBook() async {
    setState(() {
      isLoading = true;
    });
    Book loaded = await BooksDatabase.instance.readBook(widget.bookId);
    setState(() {
      isLoading = false;
      book = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          deleteButton(),
          editButton(),
        ],
      ),
      body: isLoading ? const CircularProgressIndicator()
            : Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMd().format(book.createdTime),
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      book.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
            ),
    );
  }

  Widget deleteButton() {
    return IconButton(
      onPressed: () {
        BooksDatabase.instance.delete(book.id!);
        Navigator.pop(context);
      },
      icon: const Icon(Icons.delete)
    );
  }

  Widget editButton() {
    return IconButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddEditBookPage(book: book,)
          )
        );

        updateBook();
      },
      icon: const Icon(Icons.edit)
    );
  }
}