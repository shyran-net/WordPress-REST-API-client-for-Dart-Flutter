import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../enums.dart';
import '../utilities/helpers.dart';
import '../utilities/self_representive_base.dart';
import 'properties/author_meta.dart';
import 'properties/content.dart';
import 'properties/links.dart';

@immutable
class Post implements ISelfRespresentive {
  const Post({
    required this.id,
    required this.slug,
    required this.status,
    required this.link,
    required this.author,
    required this.commentStatus,
    required this.pingStatus,
    required this.sticky,
    required this.format,
    required this.self,
    this.date,
    this.dateGmt,
    this.password,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.type,
    this.title,
    this.content,
    this.excerpt,
    this.featuredMedia,
    this.template,
    this.meta,
    this.categories,
    this.tags,
    this.links,
    this.featuredImageUrl,
    this.authorMeta,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: castOrElse(json['id']),
      date: castOrElse(
        json['date'],
        transformer: parseDateIfNotNull,
      ),
      dateGmt: castOrElse(
        json['date_gmt'],
        transformer: parseDateIfNotNull,
      ),
      guid: Content.fromJson(json['guid']),
      password: castOrElse(json['password']),
      modified: castOrElse(json['modified'], transformer: parseDateIfNotNull),
      modifiedGmt: castOrElse(
        json['modified_gmt'],
        transformer: parseDateIfNotNull,
      ),
      slug: castOrElse(json['slug']),
      status: castOrElse(
        json['status'],
        transformer: (value) => getContentStatusFromValue(value as String?),
        orElse: () => ContentStatus.pending,
      )!,
      type: castOrElse(json['type']),
      link: castOrElse(json['link']),
      title: Content.fromJson(json['title']),
      content: Content.fromJson(json['content']),
      excerpt: Content.fromJson(json['excerpt']),
      author: castOrElse(json['author']),
      featuredMedia: castOrElse(json['featured_media']),
      commentStatus: getStatusFromValue(json['comment_status'] as String?),
      pingStatus: getStatusFromValue(json['ping_status'] as String?),
      sticky: castOrElse(json['sticky']),
      template: castOrElse(json['template']),
      format: getFormatFromValue(json['format'] as String?),
      meta: json['meta'],
      categories: mapIterableWithChecks<int>(
        json['categories'],
        (dynamic v) => v as int,
      ),
      tags: mapIterableWithChecks<int>(json['tags'], (dynamic v) => v as int),
      authorMeta: AuthorMeta.fromJson(json['author_meta']),
      featuredImageUrl: decodeByMultiKeys(
        json,
        ['featured_image_url', 'featured_media_src_url'],
      ),
      links: Links.fromJson(json['_links']),
      self: json,
    );
  }

  final int id;
  final DateTime? date;
  final DateTime? dateGmt;
  final Content? guid;
  final String? password;
  final DateTime? modified;
  final DateTime? modifiedGmt;
  final String slug;
  final ContentStatus status;
  final String? type;
  final String link;
  final Content? title;
  final Content? content;
  final Content? excerpt;
  final int author;
  final int? featuredMedia;
  final Status commentStatus;
  final Status pingStatus;
  final bool sticky;
  final String? template;
  final PostFormat format;
  final dynamic meta;
  final List<int>? categories;
  final List<int>? tags;
  final Links? links;

  /// Field generated by https://wordpress.org/plugins/rest-api-featured-image/ plugin
  final String? featuredImageUrl;

  /// Field generated by https://wordpress.org/plugins/wp-rest-api-user-meta/
  final AuthorMeta? authorMeta;

  @override
  final Map<String, dynamic> self;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date?.toIso8601String(),
      'date_gmt': dateGmt?.toIso8601String(),
      'guid': guid?.toJson(),
      'password': password,
      'modified': modified?.toIso8601String(),
      'modified_gmt': modifiedGmt?.toIso8601String(),
      'slug': slug,
      'status': status.name,
      'type': type,
      'link': link,
      'title': title?.toJson(),
      'content': content?.toJson(),
      'excerpt': excerpt?.toJson(),
      'author': author,
      'featured_media': featuredMedia,
      'comment_status': commentStatus.name,
      'ping_status': pingStatus.name,
      'sticky': sticky,
      'template': template,
      'featured_image_url': featuredImageUrl,
      'author_meta': authorMeta?.toJson(),
      'format': format.name,
      'meta': meta,
      'categories': categories,
      'tags': tags,
      '_links': links?.toJson(),
    };
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) {
      return true;
    }

    final collectionEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.date == date &&
        other.dateGmt == dateGmt &&
        other.guid == guid &&
        other.password == password &&
        other.modified == modified &&
        other.modifiedGmt == modifiedGmt &&
        other.slug == slug &&
        other.status == status &&
        other.type == type &&
        other.link == link &&
        other.title == title &&
        other.content == content &&
        other.excerpt == excerpt &&
        other.author == author &&
        other.featuredMedia == featuredMedia &&
        other.commentStatus == commentStatus &&
        other.pingStatus == pingStatus &&
        other.sticky == sticky &&
        other.template == template &&
        other.format == format &&
        other.meta == meta &&
        collectionEquals(other.categories, categories) &&
        collectionEquals(other.tags, tags) &&
        other.links == links &&
        other.featuredImageUrl == featuredImageUrl &&
        other.authorMeta == authorMeta &&
        collectionEquals(other.self, self);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        dateGmt.hashCode ^
        guid.hashCode ^
        password.hashCode ^
        modified.hashCode ^
        modifiedGmt.hashCode ^
        slug.hashCode ^
        status.hashCode ^
        type.hashCode ^
        link.hashCode ^
        title.hashCode ^
        content.hashCode ^
        excerpt.hashCode ^
        author.hashCode ^
        featuredMedia.hashCode ^
        commentStatus.hashCode ^
        pingStatus.hashCode ^
        sticky.hashCode ^
        template.hashCode ^
        format.hashCode ^
        meta.hashCode ^
        categories.hashCode ^
        tags.hashCode ^
        links.hashCode ^
        featuredImageUrl.hashCode ^
        authorMeta.hashCode ^
        self.hashCode;
  }

  @override
  String toString() {
    return 'Post(id: $id, date: $date, dateGmt: $dateGmt, guid: $guid, password: $password, modified: $modified, modifiedGmt: $modifiedGmt, slug: $slug, status: $status, type: $type, link: $link, title: $title, content: $content, excerpt: $excerpt, author: $author, featuredMedia: $featuredMedia, commentStatus: $commentStatus, pingStatus: $pingStatus, sticky: $sticky, template: $template, format: $format, meta: $meta, categories: $categories, tags: $tags, links: $links, featuredImageUrl: $featuredImageUrl, authorMeta: $authorMeta, self: $self)';
  }
}
