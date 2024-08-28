import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoftcares_mt/core/colors/colors.dart';
import 'package:zoftcares_mt/presentation/home/bloc/post_bloc.dart';
import 'package:zoftcares_mt/presentation/home/bloc/post_state.dart';
import 'package:zoftcares_mt/presentation/home/widgets/card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
            
        BlocProvider.of<PostBloc>(context).add(FetchPosts(context));
      }
    });
    BlocProvider.of<PostBloc>(context).add(FetchPosts(context));

    return Scaffold(
      backgroundColor: kblack,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kblack,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 0.65,
              ),
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final post = state.posts[index];
                return PostCard(post: post);
              },
            );
          } else if (state is PostError) {
            return Center(
                child: Text(
              'Error: ${state.message}',
              style: TextStyle(color: kwhite),
            ));
          } else {
            return Center(
                child: Text(
              'No Posts Available',
              style: TextStyle(color: kwhite),
            ));
          }
        },
      ),
    );
  }
}
