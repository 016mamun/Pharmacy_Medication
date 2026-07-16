import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacy_medication/shared/models/shop_model.dart';

// Selected shop provider
final selectedShopProvider = StateProvider<ShopModel?>((ref) => null);

// Has selected shop provider
final hasSelectedShopProvider = Provider<bool>((ref) {
  return ref.watch(selectedShopProvider) != null;
});
