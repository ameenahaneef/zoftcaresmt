import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zoftcares_mt/data/apiservices/posts_services.dart';
import 'package:zoftcares_mt/presentation/home/bloc/post_state.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  int _currentPage = 1;
  bool _hasReachedMax = false;

  PostBloc() : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      if (_hasReachedMax) return;

      final currentState = state;

      try {
        if (currentState is PostLoaded) {
          emit(PostLoading());
          _currentPage++;
          final paginatedResponse = await PostServices()
              .fetchPosts(event.context, page: _currentPage);
          final posts = paginatedResponse.data;

          if (posts.isEmpty) {
            _hasReachedMax = true;
          }
          emit(PostLoaded(currentState.posts + posts,
              hasReachedMax: _hasReachedMax));
        } else {
          emit(PostLoading());

          final paginatedResponse = await PostServices()
              .fetchPosts(event.context, page: _currentPage);
          final posts = paginatedResponse.data;
          _hasReachedMax = posts.isEmpty;
          emit(PostLoaded(posts, hasReachedMax: _hasReachedMax));
        }
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
