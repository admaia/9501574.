import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:streaming_app/blocs/serie_bloc.dart';
import 'package:streaming_app/controllers/controller.dart';
import 'package:streaming_app/screens/add_serie_screen.dart';
import 'package:streaming_app/screens/serie_details.dart';

class HomePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue !"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authController.logout();
            },
          ),
        ],
      ),
      body: BlocBuilder<SerieBloc, SerieState>(
        builder: (context, state) {
          if (state.series.isEmpty) {
            return Center(child: Text("Vous n'avez pas encore de séries."));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Vos séries",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.series.length,
                  itemBuilder: (context, index) {
                    final serie = state.series[index];
                    return ListTile(
                      title: Text(serie.titre),
                      subtitle: Text("${serie.type} - ${serie.status}"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => SerieDetailsPage(serie: serie));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddSeriePage()),
        child: Icon(Icons.add),
      ),
    );
  }
}
