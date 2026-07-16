import 'package:flutter_riverpod/flutter_riverpod.dart';

// Bottom navigation index
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Home search query
final homeSearchQueryProvider = StateProvider<String>((ref) => '');

// Featured products search
final wishlistSearchQueryProvider = StateProvider<String>((ref) => '');
