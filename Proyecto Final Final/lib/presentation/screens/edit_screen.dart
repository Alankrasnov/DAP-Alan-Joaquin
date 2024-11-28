import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/List_provider.dart';
import 'package:myapp/entities/Post.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(listProvider);
    final pressed = ref.watch(pressedProvider);
    String title;
    String imagesrc;
    late TextEditingController titleController;
    late TextEditingController descriptionController;
    late TextEditingController textController;
    late TextEditingController imgsrcController;

    title = '';
    imagesrc = '';

    if (pressed == -1) {
      title = 'Nuevo Post';
      titleController = TextEditingController();
      descriptionController = TextEditingController();
      textController = TextEditingController();
      imgsrcController = TextEditingController();
      imagesrc =
          'data:image/jpeg;base64,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';
    } else {
      listAsync.when(
        data: (list) {
          title = list[pressed].title;
          titleController = TextEditingController(text: list[pressed].title);
          descriptionController =
              TextEditingController(text: list[pressed].description);
          textController = TextEditingController(text: list[pressed].text);
          imgsrcController =
              TextEditingController(text: list[pressed].imagesrc);
          imagesrc = list[pressed].imagesrc;
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  imagesrc,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Titulo",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: textController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Texto",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: imgsrcController,
                  decoration: const InputDecoration(
                    labelText: "Direccion de la Imagen",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      listAsync.when(
                        data: (list) {
                          if (pressed != -1) {
                            list[pressed].title = titleController.text;
                            list[pressed].description =
                                descriptionController.text;
                            list[pressed].text = textController.text;
                            list[pressed].imagesrc = imgsrcController.text;
                            ref.read(listaddProvider).addMovie(list);
                            context.go('/home');
                          } else {
                            if (titleController.text == '' ||
                                descriptionController.text == '' ||
                                textController.text == '' ||
                                imgsrcController.text == '') {
                              SnackBar snackBar = const SnackBar(
                                content:
                                    Text("Todos los campos son obligatorios"),
                                duration: Duration(seconds: 3),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              list.add(Post(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  text: textController.text,
                                  imagesrc: imgsrcController.text));
                              ref.read(listaddProvider).addMovie(list);
                              context.push('/home');
                            }
                          }
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => Text('Error: $error'),
                      );
                    },
                    child: const Text("Guardar")),
                    
              ],
            ),
          ),
        ));
  }
}
