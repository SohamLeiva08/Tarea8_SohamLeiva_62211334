import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarea8/models/notes.dart';



class repositorionote {
  final FirebaseFirestore _basedatos = FirebaseFirestore.instance;

  Future<void> agregarNota(Note nota) async { //"Note" es la clase de notes.dart
    await _basedatos.collection('Notas').add(nota.toFirestore());
  }

  Stream<List<Note>> obtenerNotas() {
    return _basedatos.collection('Notas').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  Future<Note?> obtenerNotaPorId(String id) async {
    final doc = await _basedatos.collection('Notas').doc(id).get();
    if (doc.exists) {
      return Note.fromFirestore(doc);
    }
    return null;
  }

  Future<void> actualizarNota(Note nota) async {
    await _basedatos
        .collection('Notas')
        .doc(nota.id)
        .update(nota.toFirestore());
  }

  Future<void> eliminarNota(String id) async {
    await _basedatos.collection('Notas').doc(id).delete();
  }
}