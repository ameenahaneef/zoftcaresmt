class PaginatedResponse {
  final bool status;
  final List<Post> data;
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final int? nextPage;
  final int? previousPage;
  final bool hasMore;

  PaginatedResponse({
    required this.status,
    required this.data,
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    this.nextPage,
    this.previousPage,
    required this.hasMore,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      status: json['status'],
      data: (json['data'] as List)
          .map((postJson) => Post.fromJson(postJson))
          .toList(),
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      nextPage: json['nextPage'],
      previousPage: json['previousPage'],
      hasMore: json['hasMore'],
    );
  }
}

class Post {
  final int id;
  final String title;
  final String body;
  final String image;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'no title',
      body: json['body'] ?? 'No body',
      image: json['image'] ?? '',
    );
  }
}
