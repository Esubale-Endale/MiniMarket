import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/data/market_store.dart';
import 'package:mini_market/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) {
      emit(CartAdded(List<CartItem>.from(MarketStore.cart)));
    });

    on<AddToCart>((event, emit) {
      MarketStore.addToCart(event.item.product, event.item.quantity);
      emit(CartAdded(List<CartItem>.from(MarketStore.cart)));
    });

    on<RemoveFromCart>((event, emit) {
      MarketStore.removeFromCart(event.productId);
      emit(CartAdded(List<CartItem>.from(MarketStore.cart)));
    });

    on<ClearCart>((event, emit) {
      MarketStore.clearCart();
      emit(CartAdded(List<CartItem>.from(MarketStore.cart)));
    });

    on<IncreaseQuantity>((event, emit) {
      final product = MarketStore.findProduct(event.productId);
      if (product == null) return;

      MarketStore.addToCart(product, event.amount);
      emit(CartAdded(List<CartItem>.from(MarketStore.cart)));
    });

    on<DecreaseQuantity>((event, emit) {
      final index = MarketStore.cart.indexWhere(
        (item) => item.product.id == event.productId,
      );
      if (index == -1) return;

      final item = MarketStore.cart[index];
      final remaining = item.quantity - event.amount;

      if (remaining <= 0) {
        MarketStore.removeFromCart(event.productId);
      } else {
        item.quantity = remaining;
      }

      emit(CartAdded(List<CartItem>.from(MarketStore.cart)));
    });
  }
}
