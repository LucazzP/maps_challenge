class CommentModel {
  final String comment;
  final int rating;
  final String author;

  CommentModel({
    this.comment,
    this.rating,
    this.author,
  });

  factory CommentModel.fromJson(Map<dynamic, dynamic> json) => CommentModel(
        comment: json['comment'],
        rating: json['rating'],
        author: json['author'],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "rating": rating,
        "author": author,
      };
}
