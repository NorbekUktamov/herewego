class Post {
  String userId;
  String title;
  String id;
  String content;
  String img_url;

  Post({
    required this.userId,
    required this.title,
    required this.id,
    required this.content,
    required this.img_url,
  });
  static Post fromJson(Map<String, dynamic> json) => Post(
    title: json['title'],
    userId: json['userId'],
    id: json['id'],
    content: json['content'],
    img_url: json['img_url'],
  );


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'title': title,
    'id': id,
    'content': content,
    'img_url': img_url,
  };
}