import 'package:equatable/equatable.dart';

final class PhotoObject extends Equatable {
  final String url; 
  final DateTime? createdAt;

  const PhotoObject({
    required this.url,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    url,
    createdAt,
  ];
}