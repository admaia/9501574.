import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/models/series_model.dart';

abstract class SerieEvent {}

class AddSerie extends SerieEvent {
  final Serie serie;
  AddSerie(this.serie);
}

class UpdateSerie extends SerieEvent {
  final Serie updatedSerie;
  UpdateSerie(this.updatedSerie);
}

class DeleteSerie extends SerieEvent {
  final Serie serieToDelete;
  DeleteSerie(this.serieToDelete);
}

class SerieState {
  final List<Serie> series;
  SerieState(this.series);
}

class SerieBloc extends Bloc<SerieEvent, SerieState> {
  SerieBloc() : super(SerieState([])) {
    on<AddSerie>((event, emit) {
      final updated = List<Serie>.from(state.series)..add(event.serie);
      emit(SerieState(updated));
    });

    on<UpdateSerie>((event, emit) {
      final updated =
          state.series.map((serie) {
            if (serie.id == event.updatedSerie.id) {
              return event.updatedSerie;
            }
            return serie;
          }).toList();
      emit(SerieState(updated));
    });

    on<DeleteSerie>((event, emit) {
      final updated =
          state.series
              .where((serie) => serie.id != event.serieToDelete.id)
              .toList();
      emit(SerieState(updated));
    });
  }
}
