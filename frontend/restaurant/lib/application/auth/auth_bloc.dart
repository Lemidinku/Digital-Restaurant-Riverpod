import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/user.dart';
import '../../Infrastructure/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      try {
        final user = await authRepository.login(event.username, event.password);
        print(user);
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        print("in the auth_bloc");
        print(e.toString());
        emit(AuthError(message: e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      await authRepository.logout();
      emit(AuthUnauthenticated());
    });

    on<AuthCheck>((event, emit) async {
      print('in the auth_bloc authCheck');
      final user = await authRepository.authCheck();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthSignUp>((event, emit) async {
      try {
        final success = await authRepository.signup(
            event.username, event.password, event.phone);
        if (!success) {
          emit(AuthError(message: 'Failed to register'));
        }
        emit(AuthRegistered());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
