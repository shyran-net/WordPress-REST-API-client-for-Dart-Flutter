import '../../utilities/helpers.dart';
import '../request_interface.dart';

class CreateCommentRequest implements IRequest {
  CreateCommentRequest({
    this.author,
    this.authorIp,
    this.authorUrl,
    this.authorEmail,
    this.content,
    this.authorDisplayName,
    this.authorUserAgent,
    this.parent,
    this.post,
  });

  int? author;
  String? authorIp;
  String? authorUrl;
  String? authorEmail;
  String? authorDisplayName;
  String? authorUserAgent;
  String? content;
  String? parent;
  String? post;

  @override
  Map<String, dynamic> build() {
    return <String, dynamic>{}
      ..addIfNotNull('author', author)
      ..addIfNotNull('author_ip', authorIp)
      ..addIfNotNull('author_url', authorUrl)
      ..addIfNotNull('author_email', authorEmail)
      ..addIfNotNull('author_display_name', authorDisplayName)
      ..addIfNotNull('author_user_agent', authorUserAgent)
      ..addIfNotNull('content', content)
      ..addIfNotNull('parent', parent)
      ..addIfNotNull('post', post);
  }
}
