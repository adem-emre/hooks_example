import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;


class FetchDataExample extends HookWidget {
  const FetchDataExample({Key? key}) : super(key: key);

  Future<List> fetchPosts() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    final postFuture = useMemoized(() => fetchPosts());
    final postSnapshot = useFuture(postFuture);

    return Scaffold(
      body: Column(
        children: [
          postSnapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: postSnapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text((postSnapshot.data?[index]["id"] as int)
                              .toString()),
                          subtitle: Text(postSnapshot.data?[index]["title"]),
                        );
                      }),
                )
              : postSnapshot.hasError
                  ? Text(postSnapshot.error.toString())
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
