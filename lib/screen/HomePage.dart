import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<Map<String, dynamic>> _NOTAS = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de inicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese un título';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese una descripción';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _createData();
                }
              },
              child: const Text('Crear'),
            ),
            SizedBox(height: 20),
            _NOTAS.isEmpty
               ? const Text('No hay datos')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _NOTAS.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_NOTAS[index]['title']),
                        subtitle: Text(_NOTAS[index]['description']),
                        trailing: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _updateData(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteData(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  _createData() {
    setState(() {
      _NOTAS.add({
        'title': _titleController.text,
        'description': _descriptionController.text,
      });
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  _updateData(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar'),
          content: Form(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _NOTAS[index]['title'],
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese un título';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _NOTAS[index]['description'],
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese una descripción';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _NOTAS[index]['title'] = _titleController.text;
                  _NOTAS[index]['description'] = _descriptionController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  _deleteData(int index) {
    setState(() {
      _NOTAS.removeAt(index);
    });
  }
}