import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_market/data/market_store.dart';
import 'package:mini_market/models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<LoadProducts>((event, emit) {
      try {
        emit(ProductsLoading());
        emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
      } catch (error) {
        emit(ProductsError(error.toString()));
      }
    });

    on<AddProduct>((event, emit) {
      try {
        emit(ProductsLoading());
        MarketStore.addProduct(event.product);
        emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
      } catch (error) {
        emit(ProductsError(error.toString()));
      }
    });

    on<UpdateProduct>((event, emit) {
      try {
        emit(ProductsLoading());
        MarketStore.updateProduct(event.product);
        emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
      } catch (error) {
        emit(ProductsError(error.toString()));
      }
    });

    on<DeleteProduct>((event, emit) {
      try {
        emit(ProductsLoading());
        MarketStore.deleteProduct(event.productId);
        emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
      } catch (error) {
        emit(ProductsError(error.toString()));
      }
    });

    add(LoadProducts());
  }
}
