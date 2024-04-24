import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb/model/books.dart';
import 'package:ets_ppb/pages/edit_books_page.dart';
import 'package:ets_ppb/pages/book_detail_page.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final Function? update;
  const BookCard(this.book, {
    this.update,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDetailPage(bookId: book.id!,)
          )
        );
        if(update != null) update!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMd().format(book.createdTime),
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}