part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

final class LoadProducts extends ProductsEvent {}

final class AddProduct extends ProductsEvent {
  final Product product;

  AddProduct(this.product);
}

final class UpdateProduct extends ProductsEvent {
  final Product product;

  UpdateProduct(this.product);
}

final class DeleteProduct extends ProductsEvent {
  final String productId;

  DeleteProduct(this.productId);
}
