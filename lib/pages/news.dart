import 'package:flutter/material.dart';
import 'package:flutter_projects/components/news_card.dart';
import 'package:flutter_projects/providers/news_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class News extends ConsumerWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsPostsAsync = ref.watch(postsProvider);
    return Scaffold(
      body: newsPostsAsync.when(
        data: (newsPosts) => RefreshIndicator(
            child: ListView.builder(
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
              },
            ),
            onRefresh: () async {
              ref.refresh(postsProvider);
            },
        ),
        error: (error, stack) {
          print(error);
          print('----------------');
          print(stack);
           return Column(
            children: <Widget>[
              Text('Что-то пошло не так'),
              Text(stack.toString()),
            ]
          );
        },
        loading: () => Center(child: CircularProgressIndicator()
        ),
      ),
      );
  }
}