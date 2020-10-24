import 'order.dart';

class User {
  final String name;
  final bool isLoggedIn;
  final String profileImageUrl;
  final List<Order> orders;
  final List<Order> cart;

  User({
    this.name,
    this.isLoggedIn,
    this.profileImageUrl,
    this.orders,
    this.cart,
  });
}
