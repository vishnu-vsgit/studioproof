import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';

/// Centralized service layer for Supabase Database operations & inquiry persistence.
class SupabaseService {
  static bool _isInitialized = false;

  /// Returns true if Supabase client is initialized with valid non-placeholder credentials.
  static bool get isInitialized => _isInitialized;

  /// Initialize Supabase client cleanly during app boot.
  static Future<void> init() async {
    final url = AppConfig.supabaseUrl.trim();
    final key = AppConfig.supabaseAnonKey.trim();

    // Check if configuration is set to default placeholders
    if (url.isEmpty ||
        url.contains('xyzcompany') ||
        key.isEmpty ||
        key.contains('placeholder')) {
      if (kDebugMode) {
        print('[SupabaseService] Notice: Supabase credentials set to placeholder defaults. Submissions will fallback to FormSubmit / Email.');
      }
      _isInitialized = false;
      return;
    }

    try {
      await Supabase.initialize(
        url: url,
        // ignore: deprecated_member_use
        anonKey: key,
        debug: kDebugMode,
      );
      _isInitialized = true;
      if (kDebugMode) {
        print('[SupabaseService] Successfully connected to Supabase instance.');
      }
    } catch (e) {
      _isInitialized = false;
      if (kDebugMode) {
        print('[SupabaseService] Error initializing Supabase: $e');
      }
    }
  }

  /// Submit a quick contact inquiry to `contact_inquiries` table.
  /// Returns `true` if saved successfully to Supabase, `false` otherwise.
  static Future<bool> submitContactInquiry({
    required String name,
    required String email,
    required String message,
  }) async {
    if (!_isInitialized) return false;

    try {
      final client = Supabase.instance.client;
      await client.from('contact_inquiries').insert({
        'name': name.trim(),
        'email': email.trim(),
        'message': message.trim(),
        'created_at': DateTime.now().toIso8601String(),
        'status': 'new',
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('[SupabaseService] Error submitting contact inquiry: $e');
      }
      return false;
    }
  }

  /// Submit a project brief / training inquiry to `project_briefs` table.
  /// Returns `true` if saved successfully to Supabase, `false` otherwise.
  static Future<bool> submitProjectBrief({
    required String name,
    required String email,
    String? organization,
    required String category,
    required String projectType,
    required String budget,
    required String deadline,
    required String details,
  }) async {
    if (!_isInitialized) return false;

    try {
      final client = Supabase.instance.client;
      await client.from('project_briefs').insert({
        'name': name.trim(),
        'email': email.trim(),
        'organization': (organization ?? '').trim(),
        'category': category.trim(),
        'project_type': projectType.trim(),
        'budget_range': budget.trim(),
        'deadline': deadline.trim(),
        'details': details.trim(),
        'created_at': DateTime.now().toIso8601String(),
        'status': 'pending_review',
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('[SupabaseService] Error submitting project brief: $e');
      }
      return false;
    }
  }
}
