import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacy_medication/shared/models/product_model.dart';

// Cart state notifier
class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super(SampleData.cartItems);

  void addItem(ProductModel product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state = [
        ...state.sublist(0, index),
        state[index].copyWith(quantity: state[index].quantity + 1),
        ...state.sublist(index + 1),
      ];
    } else {
      state = [...state, CartItemModel(product: product, quantity: 1)];
    }
  }

  void removeItem(String productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final item = state[index];
      if (item.quantity > 1) {
        state = [
          ...state.sublist(0, index),
          item.copyWith(quantity: item.quantity - 1),
          ...state.sublist(index + 1),
        ];
      } else {
        state = state.where((item) => item.product.id != productId).toList();
      }
    }
  }

  void deleteItem(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void clearCart() {
    state = [];
  }

  int getQuantity(String productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    return index >= 0 ? state[index].quantity : 0;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItemModel>>((ref) {
  return CartNotifier();
});

// Cart count provider
final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

// Cart subtotal
final cartSubtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
});

// Promo code
final promoCodeProvider = StateProvider<String>((ref) => '');
final discountProvider = StateProvider<double>((ref) => 0.0);

// Delivery charge
const double deliveryCharge = 7.0;

// Cart total
final cartTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final discount = ref.watch(discountProvider);
  return subtotal + deliveryCharge - discount;
});
