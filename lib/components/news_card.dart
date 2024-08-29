import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String mainContent;
  final String thumbnail;
  final String postUrl;
  final int thumbnail_width;
  final int thumbnail_height;

  NewsCard({
    required this.title,
    required this.mainContent,
    required this.thumbnail,
    required this.thumbnail_width,
    required this.thumbnail_height,
    required this.postUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(16),
        shadowColor: Colors.black,
        elevation: 10,
        child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )
                  ),
                  child: ListTile(
                    title: Text(
                      this.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    constraints: BoxConstraints(
                      minHeight: 200,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        this.thumbnail != 'self' ?
                        Image.network(
                          this.thumbnail,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ) :
                        Icon(Icons.image),
                        SizedBox(height: 20),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 200,
                          ),
                          child: Text(
                            this.mainContent,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            ),
                          ),
                        )

                      ],
                    )
                )
              ],
            )
        ),
      );
  }
}