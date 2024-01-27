import 'package:flutter/foundation.dart';


@immutable
class Event {
  final String id;
  final String title;
  final String? description;

  Event({required this.id, required this.title, this.description});

  @override
  bool operator ==(Object other) => other is Event && title == other.title;

  @override
  String toString() => title;
}
