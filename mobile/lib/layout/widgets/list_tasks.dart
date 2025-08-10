import 'package:flutter/material.dart';
import 'package:mobile/data/entites/task_entity.dart';

import '../../config/config.dart';
import '../../controller/task_controller.dart';

class ListTasks extends StatefulWidget {
  final bool isCompleted;

  const ListTasks({super.key, required this.isCompleted});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  Future<List<TaskEntity>>? _tasksFuture;
  bool isCompleted = true;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.isCompleted;
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _tasksFuture = _fetchTasks();
    });
  }

  Future<List<TaskEntity>> _fetchTasks() async {
    try {
      String? username = await Config.getUsername();
      if (username == null) {
        throw Exception("Nombre de usuario no encontrado.");
      }
      if (isCompleted) {
        return await getCompletedTasksApi(username);
      } else {
        return await getPendingTasksApi(username);
      }
    } catch (e) {
      print("Error al cargar tareas: $e");
      rethrow;
    }
  }

  Future<void> _refreshTasks() async {
    _loadTasks();
  }

  Future<void> _deleteTask(int taskId) async {
    try {
      await deleteTaskApi(taskId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarea $taskId eliminada con éxito.')),
      );
      _refreshTasks();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al eliminar tarea: $e')));
    }
  }

  Future<void> _setCompletedTask(int taskId) async {
    try {
      bool result = await setCompletedTaskApi(taskId);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarea marcada como completada.')),
        );
        _refreshTasks();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al marcar la tarea como completada.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al marcar tarea como completada: $e')),
      );
    }
  }

  Future<void> _setPendingTask(int taskId) async {
    try {
      bool result = await setPendingTaskApi(taskId);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarea marcada como pendiente.')),
        );
        _refreshTasks();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al marcar la tarea como pendiente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al marcar tarea como pendiente: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaskEntity>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error al cargar las tareas: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: _refreshTasks,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final tasks = snapshot.data!;
          final tasksReversed = tasks.reversed.toList();
          return ListView.builder(
            itemCount: tasksReversed.length,
            itemBuilder: (context, index) {
              final task = tasksReversed[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description ?? 'Sin descripción'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/updateTask',
                          arguments: task.id,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () async {
                        String? username = await Config.getUsername();
                        if (username != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('Confirmar Eliminación'),
                                content: Text(
                                  '¿Estás seguro de que quieres eliminar la tarea "${task.title}"?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Eliminar',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      _deleteTask(task.id);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No se pudo obtener el usuario o ID para eliminar la tarea.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),

                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    if (value != null) {
                      if (value) {
                        _setCompletedTask(task.id);
                      } else {
                        _setPendingTask(task.id);
                      }
                    }
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No hay tareas completadas.'));
        }
      },
    );
  }
}
