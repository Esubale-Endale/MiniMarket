part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartAdded extends CartState {
  final List<CartItem> cartItems;

  CartAdded(this.cartItems);
}

final class CartEmpty extends CartState {}
