import 'package:tarea8/models/notes.dart';
import 'package:tarea8/models/repo_crud.dart';

class NotaService {
  final repositorionote _norepo = repositorionote();

  Future<void> agregarNota(Note nota) async {
    await _norepo.agregarNota(nota);
  }

  Stream<List<Note>> obtenerNotas() {
    return _norepo.obtenerNotas();
  }

  Future<Note?> obtenerNotaPorId(String id) async {
    return await _norepo.obtenerNotaPorId(id);
  }

  Future<void> actualizarNota(Note nota) async {
    await _norepo.actualizarNota(nota);
  }

  Future<void> eliminarNota(String id) async {
    await _norepo.eliminarNota(id);
  }
}