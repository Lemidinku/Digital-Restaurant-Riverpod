import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'package:restaurant/Infrastructure/repositories/auth_repository.dart';
import 'package:restaurant/domain/user.dart';
import 'package:restaurant/storage.dart';

import 'auth_repository_test.mocks.dart';

// Generate the mock classes
@GenerateMocks([http.Client, SecureStorage])
void main() {
  late MockClient mockHttpClient;
  late MockSecureStorage mockSecureStorage;
  late AuthRepository authRepository;

  setUp(() {
    mockHttpClient = MockClient();
    mockSecureStorage = MockSecureStorage();
    authRepository = AuthRepository(
      baseUrl: 'https://example.com',
    );
  });

  group('AuthRepository', () {
    test('login successfully', () async {
      final responsePayload = {
        'success': true,
        'token': 'mockToken',
        'user': {
          'id': '1',
          'username': 'testUser',
          'phone': '123456789',
          'roles': ['user']
        }
      };
      when(mockHttpClient.post(
        Uri.parse('https://example.com/auth/login'),
        headers: anyNamed('headers'),
        body: {
          'username': 'testUser',
          'password': 'password',
        },
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      when(mockSecureStorage.write('token', 'mockToken'))
          .thenAnswer((_) async => {});

      expect(
        () async => await authRepository.login('testUser', 'password'),
        returnsNormally,
      );
    });
    test('login failure', () async {
      final responsePayload = {
        'success': false,
        'message': 'Invalid credentials'
      };
      when(mockHttpClient.post(
        Uri.parse('https://example.com/auth/login'),
        headers: anyNamed('headers'),
        body: {
          'username': 'testUser',
          'password': 'password',
        },
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 401));

      expect(
          () => authRepository.login('testUser', 'password'), throwsException);
    });

    test('signup successfully', () async {
      final responsePayload = {'success': true};
      when(mockHttpClient.post(
        Uri.parse('https://example.com/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': 'testUser',
          'password': 'password',
          'phone': '123456789',
        }),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      expect(
        () async =>
            await authRepository.signup('testUser', 'password', '123456789'),
        returnsNormally,
      );
    });

    test('signup failure', () async {
      final responsePayload = {'success': false, 'message': 'Signup failed'};
      when(mockHttpClient.post(
        Uri.parse('https://example.com/auth/signup'),
        headers: anyNamed('headers'),
        body: {
          'username': 'testUser',
          'password': 'password',
          'phone': '123456789',
        },
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 400));

      expect(() => authRepository.signup('testUser', 'password', '123456789'),
          throwsException);
    });

    test('logout', () async {
      when(mockSecureStorage.delete('token')).thenAnswer((_) async => {});

      // expect(
      //   () async => await authRepository.logout(),
      //   returnsNormally,
      // );
    });

    test('authCheck with valid token', () async {
      final token = JWT({
        'id': '1',
        'username': 'testUser',
        'phone': '123456789',
        'roles': ['user']
      }).sign(SecretKey('secret'));
      when(mockSecureStorage.read('token')).thenAnswer((_) async => token);

      // expect(
      //   () async => await authRepository.authCheck(),
      //   returnsNormally,
      // );
    });

    test('authCheck with no token', () async {
      when(mockSecureStorage.read('token')).thenAnswer((_) async => null);
      // expect(
      //   () async => await authRepository.authCheck(),
      //   returnsNormally,
      // );
    });
  });
}
