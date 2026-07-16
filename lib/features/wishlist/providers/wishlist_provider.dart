import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacy_medication/shared/models/product_model.dart';

// Wishlist provider
class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  WishlistNotifier() : super(SampleData.wishlistProducts);

  void toggleWishlist(ProductModel product) {
    final exists = state.any((p) => p.id == product.id);
    if (exists) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product.copyWith(isWishlisted: true)];
    }
  }

  bool isWishlisted(String productId) {
    return state.any((p) => p.id == productId);
  }
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<ProductModel>>((ref) {
  return WishlistNotifier();
});

// Wishlist count provider
final wishlistCountProvider = Provider<int>((ref) {
  return ref.watch(wishlistProvider).length;
});
