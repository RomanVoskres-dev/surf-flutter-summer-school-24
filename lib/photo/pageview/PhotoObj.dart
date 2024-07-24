import 'package:equatable/equatable.dart';

final class PhotoObject extends Equatable {
  final int id;
  final String url; 
  final DateTime? createdAt;

  const PhotoObject({
    required this.id,
    required this.url,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    url,
    createdAt,
  ];
}