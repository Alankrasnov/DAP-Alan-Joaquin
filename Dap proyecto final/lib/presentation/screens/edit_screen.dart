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
          'https://images.mrcook.app/recipe-image/0190c42d-e8fb-7945-9ae0-de87d1b545d8';
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
