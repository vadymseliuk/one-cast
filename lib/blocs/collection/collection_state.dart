part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object?> get props => [];
}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final List<Bottle> bottles;

  const CollectionLoaded(this.bottles);

  @override
  List<Object?> get props => [bottles];
}

class CollectionError extends CollectionState {
  final String message;

  const CollectionError(this.message);

  @override
  List<Object?> get props => [message];
}
