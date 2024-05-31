// auth_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/Infrastructure/repositories/auth_repository.dart'; // Update with your actual import path
import 'package:restaurant/domain/user.dart';
import 'auth_provider_test.mocks.dart'; // Generated mock file

@GenerateMocks([AuthRepository])
void main() {
  late AuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('Login Tests', () {
    test('Login Success', () async {
      // Mock successful response
      when(mockAuthRepository.login('testuser', 'testpassword')).thenAnswer(
          (_) async => User(
              id: 1, username: 'testuser', phone: '1234567890', role: 'user'));

      // Call the login method
      final user = await mockAuthRepository.login('testuser', 'testpassword');

      // Verify that the correct user object is returned
      expect(user.id, 1);
      expect(user.username, 'testuser');
      expect(user.phone, '1234567890');
      expect(user.role, 'user');
    });

    test('Login Failure', () async {
      // Mock failed response
      when(mockAuthRepository.login('testuser', 'wrongpassword'))
          .thenThrow(Exception('Invalid credentials'));

      // Call the login method and expect an exception to be thrown
      expect(() => mockAuthRepository.login('testuser', 'wrongpassword'),
          throwsException);
    });
  });

  // Add more test groups for signup, logout, and authCheck methods
}
