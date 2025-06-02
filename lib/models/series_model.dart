import 'package:uuid/uuid.dart';

class Serie {
  final String id;
  final String titre;
  final String type;
  final String commentaire;
  String status;

  Serie({
    required this.id,
    required this.titre,
    required this.type,
    required this.commentaire,
    required this.status,
  });

  factory Serie.create({
    required String titre,
    required String type,
    required String commentaire,
    required String status,
  }) {
    return Serie(
      id: const Uuid().v4(),
      titre: titre,
      type: type,
      commentaire: commentaire,
      status: status,
    );
  }

  Serie copyWith({String? status}) {
    return Serie(
      id: id,
      titre: titre,
      type: type,
      commentaire: commentaire,
      status: status ?? this.status,
    );
  }
}
