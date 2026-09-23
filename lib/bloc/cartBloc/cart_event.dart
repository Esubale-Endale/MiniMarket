part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class LoadCart extends CartEvent {}

final class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart(this.item);
}

final class RemoveFromCart extends CartEvent {
  final String productId;

  RemoveFromCart(this.productId);
}

final class ClearCart extends CartEvent {}

final class IncreaseQuantity extends CartEvent {
  final String productId;
  final int amount;

  IncreaseQuantity(this.productId, [this.amount = 1]);
}

final class DecreaseQuantity extends CartEvent {
  final String productId;
  final int amount;

  DecreaseQuantity(this.productId, [this.amount = 1]);
}
