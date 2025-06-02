import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/blocs/serie_bloc.dart';
import 'package:streaming_app/models/series_model.dart';
import 'package:streaming_app/screens/add_serie_screen.dart';

class SerieDetailsPage extends StatelessWidget {
  final Serie serie;

  const SerieDetailsPage({required this.serie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateSeriePage(serie: serie),
                ),
              );
            },
            icon: Icon(Icons.update),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<SerieBloc>().add(DeleteSerie(serie));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<SerieBloc, SerieState>(
        builder: (context, state) {
          final actuel = state.series.firstWhere(
            (s) => s.id == serie.id,
            orElse: () => serie,
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Titre: ${actuel.titre}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text("Type: ${actuel.type}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text(
                  "Status: ${actuel.status}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  "Commentaire: ${actuel.commentaire}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
