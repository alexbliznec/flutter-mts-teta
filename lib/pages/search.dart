import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/components/news_card.dart';
import 'package:flutter_projects/providers/news_search_provider.dart';
import 'package:flutter_projects/types/response_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String urlString = 'https://www.reddit.com/search.json';

class SearchPage extends ConsumerStatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late Dio dio;
  List<Post> newsPosts = [];
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    ref.read(searchQueryProvider.notifier).clearQuery();
    ref.read(searchResultsProvider.notifier).clearResults();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchProvider);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child:
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                hintText: 'Начните поиск',
                hintStyle: TextStyle(fontSize: 18.0),
              ),
              onChanged: (query) {
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  ref.read(searchQueryProvider.notifier).updateQuery(query);
                });
              },
            ),
          ),
          Expanded(
            child: searchResults.when(
                data: (newsPosts) {
                  if (newsPosts.isEmpty) {
                    return Center(child: Text('Пока ничего не найдено'));
                  }
                  return ListView.builder(
                    itemCount: newsPosts.length,
                    itemBuilder: (context, index) {
                      var post = newsPosts[index];
                        return NewsCard(
                          title: post.title,
                          mainContent: post.selftext,
                          thumbnail: post.thumbnail,
                          thumbnail_height: post.thumbnail_height,
                          thumbnail_width: post.thumbnail_width,
                          postUrl: post.postUrl,
                        );
                      }
                  );
                },
                error: (error, stack) => Center(child: Text('Error: $error')),
                loading: () => Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }
}