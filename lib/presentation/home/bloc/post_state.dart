import 'package:meta/meta.dart';
import 'package:zoftcares_mt/data/models/posts_model.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded(this.posts, {this.hasReachedMax = false});
}

final class PostError extends PostState {
  final String message;

  PostError(this.message);
}

final class SessionExpired extends PostState {}
