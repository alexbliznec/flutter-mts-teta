class Post {
  final String selftext;
  final String title;
  final String thumbnail;
  final String postUrl;
  final int thumbnail_height;
  final int thumbnail_width;

  Post({
    required this.selftext,
    required this.title,
    required this.thumbnail,
    required this.thumbnail_height,
    required this.thumbnail_width,
    required this.postUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      selftext: json['selftext'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      thumbnail_height: json['thumbnail_height'] ?? 0,
      thumbnail_width: json['thumbnail_width'] ?? 0,
      title: json['title'] ?? '',
      postUrl: json['url'] ?? '',
    );
  }
}

class NewsItem {
  final String kind;
  final Post data;

  NewsItem({required this.kind, required this.data});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      kind: json['kind'] ?? '',
      data: Post.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class NewsItems {
  final List<NewsItem> children;

  NewsItems({required this.children});

  factory NewsItems.fromJson(Map<String, dynamic> json) {
    var childrenJson = json['children'] as List;
    List<NewsItem> childrenList =
    childrenJson.map((item) => NewsItem.fromJson(item)).toList();

    return NewsItems(
      children: childrenList,
    );
  }
}

class NewsResponse {
  final NewsItems data;

  NewsResponse({required this.data});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      data: NewsItems.fromJson(json['data']),
    );
  }
}