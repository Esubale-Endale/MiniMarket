import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_market/data/market_store.dart';
import 'package:mini_market/models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<LoadProducts>((event, emit) {
      emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
    });

    on<AddProduct>((event, emit) {
      MarketStore.addProduct(event.product);
      emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
    });

    on<UpdateProduct>((event, emit) {
      MarketStore.updateProduct(event.product);
      emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
    });

    on<DeleteProduct>((event, emit) {
      MarketStore.deleteProduct(event.productId);
      emit(ProductsLoaded(List<Product>.from(MarketStore.products)));
    });
  }
}
