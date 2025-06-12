import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import '../../models/bottle.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(CollectionLoading()) {
    on<LoadCollectionEvent>(_onLoadCollection);
  }

  Future<void> _onLoadCollection(
    LoadCollectionEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(CollectionLoading());
    try {
      final String jsonString = await rootBundle.loadString('assets/json/collection.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final bottles = jsonList.map((e) => Bottle.fromJson(e)).toList();
      emit(CollectionLoaded(bottles));
    } catch (e) {
      emit(CollectionError("Failed to load collection"));
    }
  }
}
