import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t1/api/job_api.dart';
import 'package:t1/detail.dart';
import 'package:t1/main.dart';
import 'package:t1/model/job_model.dart';
import 'package:t1/search.dart';
import 'package:t1/shift_list.dart';

class FilterNetworkListPage extends StatefulWidget {
  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<Job> books = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await Jobapi.getBooks(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return buildBook(book);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await Jobapi.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });

  Widget buildBook(Job job) => Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://picsum.photos/250?image=9'))),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text(
                          (job.job_events_name),
                          style: TextStyle(fontSize: 17),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      (job.job_code),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Shiftlistpage(value: job),
                ),
              );
            },
          ),
        ),
      );
}
