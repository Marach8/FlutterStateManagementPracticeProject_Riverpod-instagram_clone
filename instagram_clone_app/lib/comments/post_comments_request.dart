import 'package:flutter/foundation.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/typedefs.dart';

@immutable 
class RequestForPostAndComment{
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestForPostAndComment({
    required this.postId,
    this.sortByCreatedAt = true,
    this.dateSorting = DateSorting.newestOnTop,
    this.limit
  });

  @override 
  bool operator ==(covariant RequestForPostAndComment other)
    => postId == other.postId && 
    sortByCreatedAt == other.sortByCreatedAt &&
    dateSorting == other.dateSorting && 
    limit == other.limit;

  @override 
  int get hashCode => Object.hash(postId, sortByCreatedAt, dateSorting, limit);
}