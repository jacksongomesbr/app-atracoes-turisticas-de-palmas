import 'constants.dart';

String getPublicUrl(String path) {
  return supabase.storage.from('fotos').getPublicUrl(path);
}
