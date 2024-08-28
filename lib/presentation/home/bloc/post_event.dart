part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

final class FetchPosts extends PostEvent {
  final BuildContext context;
  final int page;
  FetchPosts(this.context, {this.page = 1});
}
