import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Constants {
  static const String SUPABASE_URL = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://sxylxiukzxfrwgjlnkwc.supabase.co',
  );
  static const String SUPABASE_ANON_KEY = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4eWx4aXVrenhmcndnamxua3djIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODIwNTA5NDUsImV4cCI6MTk5NzYyNjk0NX0.dqZZZbZiktS9ol4S1tGV4pp5b3k35ZwwlUYRg278ziU',
  );
}

final supabase = Supabase.instance.client;