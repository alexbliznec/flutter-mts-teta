import 'package:flutter_projects/types/response_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

const SEARCH_URL = 'https://www.reddit.com/search.json';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

class SearchQueryNotifier extends StateNotifier<String> {
  SearchQueryNotifier() : super('');

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }

  void clearSearch() {

  }
}

final searchQueryProvider = StateNotifierProvider<SearchQueryNotifier, String>((ref) {
  return SearchQueryNotifier();
});

final searchProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final dio = ref.read(dioProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.isEmpty) {
    return [];
  }

  final searchResponse = await dio.get(SEARCH_URL, queryParameters: {'q': searchQuery});

  NewsResponse newsResponse = NewsResponse.fromJson(searchResponse.data as Map<String, dynamic>);
  List<Post> newsPosts = newsResponse.data.children
      .map((item) => item.data).toList();
  return newsPosts;
});

class SearchResultsNotifier extends StateNotifier<List<Post>> {
  SearchResultsNotifier() : super([]);

  void updateResults(List<Post> results) {
    state = results;
  }

  void clearResults() {
    state = [];
  }
}

final searchResultsProvider = StateNotifierProvider<SearchResultsNotifier, List<Post>>((ref) {
  return SearchResultsNotifier();
});