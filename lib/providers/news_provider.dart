import 'package:flutter_projects/types/response_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

const NEWS_URL = 'https://reddit.com/r/flutterdev/new.json';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final dio = ref.read(dioProvider);
  print('sending request-------------------');
  final response = await dio.get(NEWS_URL);
  NewsResponse newsResponse = NewsResponse.fromJson(response.data as Map<String, dynamic>);
  List<Post> newsPosts = newsResponse.data.children
      .map((item) => item.data).toList();
  return newsPosts;
});
