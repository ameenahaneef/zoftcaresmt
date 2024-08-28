import 'package:flutter/material.dart';
import 'package:zoftcares_mt/core/constants/styles.dart';
import 'package:zoftcares_mt/data/models/posts_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              post.image,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                print('Image load error: $error');
                return const Center(
                    child: Icon(Icons.error, color: Colors.red));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.title,
              style: kstyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              post.body,
              style: TextStyle(color: Colors.grey[400]),
              maxLines: 2,
              overflow:TextOverflow.ellipsis ,
            ),
          ),
        ],
      ),
    );
  }
}
