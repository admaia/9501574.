import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:streaming_app/blocs/serie_bloc.dart';
import 'package:streaming_app/models/series_model.dart';

class AddSeriePage extends StatefulWidget {
  @override
  _AddSeriePageState createState() => _AddSeriePageState();
}

class _AddSeriePageState extends State<AddSeriePage> {
  final controllerTitre = TextEditingController();
  final controllerType = TextEditingController();
  final controllerCommentaire = TextEditingController();
  final controllerStatus = TextEditingController();
  final controllerStatusOptions = ["En cours", "A voir", "Vu"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter une série")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controllerTitre,
              decoration: InputDecoration(labelText: "Titre"),
            ),
            TextField(
              controller: controllerType,
              decoration: InputDecoration(labelText: "Type"),
            ),
            TextField(
              controller: controllerCommentaire,
              decoration: InputDecoration(labelText: "Commentaire"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controllerStatus,
              decoration: InputDecoration(
                labelText: "Status",
                hintText: "En cours, A voir, Vu",
              ),
              readOnly: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Sélectionner un status"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: controllerStatusOptions.map((status) {
                            return ListTile(
                              title: Text(status),
                              onTap: () {
                                controllerStatus.text = status;
                                Get.back();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: () {
              final serie = Serie.create(
                titre: controllerTitre.text,
                type: controllerType.text,
                commentaire: controllerCommentaire.text,
                status: controllerStatus.text,
              );
              context.read<SerieBloc>().add(AddSerie(serie));
              Get.back();
            },
            child: Text("Ajouter la série"),
          )
          ],
        ),
      ),
    );
  }
}

class UpdateSeriePage extends StatefulWidget {
  final Serie serie;

  UpdateSeriePage({required this.serie});

  @override
  _UpdateSeriePageState createState() => _UpdateSeriePageState();
}

class _UpdateSeriePageState extends State<UpdateSeriePage> {
  late TextEditingController controllerTitre;
  late TextEditingController controllerType;
  late TextEditingController controllerCommentaire;
  late TextEditingController controllerStatus;
  final controllerStatusOptions = ["En cours", "A voir", "Vu"];

  @override
  void initState() {
    super.initState();
    controllerTitre = TextEditingController(text: widget.serie.titre);
    controllerType = TextEditingController(text: widget.serie.type);
    controllerCommentaire = TextEditingController(text: widget.serie.commentaire);
    controllerStatus = TextEditingController(text: widget.serie.status);
  }

  @override
  void dispose() {
    controllerTitre.dispose();
    controllerType.dispose();
    controllerCommentaire.dispose();
    controllerStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modifier la série")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controllerTitre,
              decoration: InputDecoration(labelText: "Titre"),
              readOnly: true,
            ),
            TextField(
              controller: controllerType,
              decoration: InputDecoration(labelText: "Type"),
              readOnly: true,
            ),
            TextField(
              controller: controllerCommentaire,
              decoration: InputDecoration(labelText: "Commentaire"),
              readOnly: true,
            ),
            TextField(
              controller: controllerStatus,
              decoration: InputDecoration(
                labelText: "Status",
                hintText: "En cours, A voir, Vu",
              ),
              readOnly: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Sélectionner un status"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: controllerStatusOptions.map((status) {
                            return ListTile(
                              title: Text(status),
                              onTap: () {
                                controllerStatus.text = status;
                                Get.back();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedSerie = widget.serie.copyWith(
                  status: controllerStatus.text,
                );
                context.read<SerieBloc>().add(UpdateSerie(updatedSerie));
                Get.back();
              },
              child: Text("Mettre à jour la série"),
            )
          ],
        ),
      ),
    );
  }
}

class DeleteSeriePage extends StatelessWidget {
  final Serie serie;

  DeleteSeriePage({required this.serie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Supprimer la série")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Êtes-vous sûr de vouloir supprimer cette série ?",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              serie.titre,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SerieBloc>().add(DeleteSerie(serie));
                    Get.back();
                  },
                  child: Text("Supprimer"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back(); 
                  },
                  child: Text("Annuler"),
                ),
              ],
            )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
