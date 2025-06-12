import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

// STATES
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userEmail; // Example info to hold

  const AuthAuthenticated(this.userEmail);

  @override
  List<Object?> get props => [userEmail];
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthUnauthenticated extends AuthState {}

// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Add your authentication logic here
      await Future.delayed(const Duration(seconds: 2)); // simulate delay

      // For demo, accept any non-empty email/password:
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthAuthenticated(event.email));
      } else {
        emit(const AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }
}
