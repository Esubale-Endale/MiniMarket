import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/data/market_store.dart';
import 'package:mini_market/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) {
      try {
        emit(CartLoading());
        emit(CartLoaded(List<CartItem>.from(MarketStore.cart)));
      } catch (error) {
        emit(CartError(error.toString()));
      }
    });

    on<AddToCart>((event, emit) {
      try {
        emit(CartLoading());
        MarketStore.addToCart(event.item.product, event.item.quantity);
        emit(CartLoaded(List<CartItem>.from(MarketStore.cart)));
      } catch (error) {
        emit(CartError(error.toString()));
      }
    });

    on<RemoveFromCart>((event, emit) {
      try {
        emit(CartLoading());
        MarketStore.removeFromCart(event.productId);
        emit(CartLoaded(List<CartItem>.from(MarketStore.cart)));
      } catch (error) {
        emit(CartError(error.toString()));
      }
    });

    on<ClearCart>((event, emit) {
      try {
        emit(CartLoading());
        MarketStore.clearCart();
        emit(CartLoaded(List<CartItem>.from(MarketStore.cart)));
      } catch (error) {
        emit(CartError(error.toString()));
      }
    });

    on<IncreaseQuantity>((event, emit) {
      final product = MarketStore.findProduct(event.productId);
      if (product == null) {
        emit(CartError('Product not found: ${event.productId}'));
        return;
      }

      try {
        emit(CartLoading());
        MarketStore.addToCart(product, event.amount);
        emit(CartLoaded(List<CartItem>.from(MarketStore.cart)));
      } catch (error) {
        emit(CartError(error.toString()));
      }
    });

    on<DecreaseQuantity>((event, emit) {
      final index = MarketStore.cart.indexWhere(
        (item) => item.product.id == event.productId,
      );
      if (index == -1) {
        emit(CartError('Product is not in the cart: ${event.productId}'));
        return;
      }

      try {
        final item = MarketStore.cart[index];
        final remaining = item.quantity - event.amount;

        emit(CartLoading());
        if (remaining <= 0) {
          MarketStore.removeFromCart(event.productId);
        } else {
          item.quantity = remaining;
        }

        emit(CartLoaded(List<CartItem>.from(MarketStore.cart)));
      } catch (error) {
        emit(CartError(error.toString()));
      }
    });

    add(LoadCart());
  }
}
