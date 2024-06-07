import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String descripcion;
  DateTime fecha;
  String estado;
  bool importante;

  Note({
    required this.id,
    required this.descripcion,
    required this.fecha,
    required this.estado,
    required this.importante,
  });

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Note(
      id: doc.id,
      descripcion: data['Descripcion'] ?? '',
      fecha: (data['Fecha'] as Timestamp).toDate(),
      estado: data['Estado'] ?? 'Creado',
      importante: data['Importante'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Descripcion': descripcion,
      'Fecha': fecha,
      'Estado': estado,
      'Importante': importante,
    };
  }
}