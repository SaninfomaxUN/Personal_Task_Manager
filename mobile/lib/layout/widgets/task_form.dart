import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../controller/task_controller.dart';
import '../../data/entites/task_entity.dart';

class TaskForm extends StatefulWidget {
  final VoidCallback onTaskCalled;
  final bool isUpdateMode;
  final int taskId;

  const TaskForm({
    super.key,
    required this.onTaskCalled,
    required this.isUpdateMode,
    required this.taskId,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;
  bool _isCompleted = false;

  bool _isUpdateMode = false;
  int _taskId = 0;

  @override
  void initState() {
    super.initState();
    _isUpdateMode = widget.isUpdateMode;
    _taskId = widget.taskId;
    if (_isUpdateMode) {
      _getActualTask();
    }
  }

  Future<void> _getActualTask() async {
    await getTaskByIdApi(_taskId)
        .then((task) {
          _titleController.text = task.title;
          _descriptionController.text = task.description ?? '';
          _isCompleted = task.isCompleted;
          setState(() {
            _errorMessage = null;
          });
        })
        .catchError((error) {
          setState(() {
            _errorMessage = 'Error al obtener la tarea: $error';
          });
        });
  }

  Future<void> _sendTask() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;

      final TaskEntity task = TaskEntity(
        id: _taskId,
        username: await Config.getUsername() ?? '',
        title: title,
        description: description.isNotEmpty ? description : null,
        isCompleted: _isCompleted,
      );

      if (_isUpdateMode) {
        await updateTaskApi(task)
            .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tarea actualizada correctamente ✅')),
              );
            })
            .catchError((error) {
              setState(() {
                _errorMessage = 'Error al actualizar la tarea: $error';
              });
            });
      } else {
        await createTaskApi(task)
            .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tarea creada correctamente ✅')),
              );
            })
            .catchError((error) {
              setState(() {
                _errorMessage = 'Error al crear la tarea: $error';
              });
            });
      }

      widget.onTaskCalled();

      _titleController.clear();
      _descriptionController.clear();
    } else {
      setState(() {
        _errorMessage = 'Por favor, completa todos los campos.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _isUpdateMode ? 'Actualizar Tarea' : 'Crear Nueva Tarea',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un título.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa una descripción.';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿Tarea completada?'),
                      Checkbox(
                        value: _isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCompleted = value ?? false;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),

                  if (_errorMessage != null)
                    Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _sendTask,
                    child: Text(
                      _isLoading
                          ? 'Enviando...'
                          : (_isUpdateMode
                                ? 'Actualizar Tarea'
                                : 'Crear Tarea'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
