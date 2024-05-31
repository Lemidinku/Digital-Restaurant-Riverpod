part of 'auth_provider.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthInitial());

  Future<void> handleEvent(AuthEvent event) async {
    if (event is AuthLogin) {
      try {
        final user = await authRepository.login(event.username, event.password);
        print(user);
        state = AuthAuthenticated(user: user);
      } catch (e) {
        print("in the auth_notifier");
        print(e.toString());
        state = AuthError(message: e.toString());
      }
    } else if (event is AuthLogout) {
      // await authRepository.logout();
      state = AuthUnauthenticated();
    } else if (event is AuthSignUp) {
      try {
        final user = await authRepository.signup(
            event.username, event.password, event.phone);
        print(user);
        state = AuthRegistered();
      } catch (e) {
        state = AuthError(message: e.toString());
      }
    }
  }
}
