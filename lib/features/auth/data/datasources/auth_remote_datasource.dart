// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/userModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Abstract class

abstract interface class AuthRemoteDatasource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentUserData();
}

// Network class
class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  SupabaseClient supabaseClient;
  AuthRemoteDatasourceImp({
    required this.supabaseClient,
  });

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      if (response.user == null) {
        throw ServerException('user is null1!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient!.auth
          .signUp(password: password, email: email, data: {'name': name});

      if (response.user == null) {
        throw ServerException('user is null1!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);

        return UserModel.fromJson(userData.first);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
