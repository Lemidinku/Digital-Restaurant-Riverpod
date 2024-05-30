import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/user.dart';
import '../../Infrastructure/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_notifier.dart';
part 'auth_event.dart';

// Define a provider for the AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(baseUrl: 'http://10.0.2.2:5000');
});

// Define a provider for the AuthNotifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository: authRepository);
});