import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shopping_cart_provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          Consumer<ShoppingCartProvider>(
            builder: (context, cart, child) {
              return Badge(
                label: Text('${cart.itemCount}'),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Show cart details
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Product Grid
          Expanded(
            flex: 3,
            child: _buildProductGrid(context),
          ),
          // Cart Summary
          Expanded(
            flex: 1,
            child: _buildCartSummary(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final products = [
      {'id': '1', 'name': 'Mountain Bike', 'price': 16999.00, 'image': 'assets/images/mountain_bike.jpg', 'isNetwork': false},
      {'id': '2', 'name': 'Road Bike', 'price': 22999.00, 'image': 'assets/images/road_bike.jpg', 'isNetwork': false},
      {'id': '3', 'name': 'Electric Bike', 'price': 33999.00, 'image': 'assets/images/electric_bike.jpg', 'isNetwork': false},
      {'id': '4', 'name': 'BMX Bike', 'price': 11299.00, 'image': 'assets/images/bmx_bike.jpg', 'isNetwork': false},
      {'id': '5', 'name': 'Folding Bike', 'price': 14199.00, 'image': 'assets/images/folding_bike.jpg', 'isNetwork': false},
      {'id': '6', 'name': 'Kids Bike', 'price': 8499.00, 'image': 'assets/images/kids_bike.jpg', 'isNetwork': false},
      // Network images for featured bikes
      {'id': '7', 'name': 'Premium Mountain Bike', 'price': 24999.00, 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop', 'isNetwork': true},
      {'id': '8', 'name': 'High-End Road Bike', 'price': 35999.00, 'image': 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=400&h=300&fit=crop', 'isNetwork': true},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: (product['isNetwork'] as bool)
                        ? Image.network(
                            product['image'] as String,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 8),
                                    Text('Loading...'),
                                  ],
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.directions_bike, size: 48, color: Colors.blue),
                                    SizedBox(height: 8),
                                    Text('Premium Bike'),
                                  ],
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            product['image'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.directions_bike, size: 48, color: Colors.blue),
                                    SizedBox(height: 8),
                                    Text('Bike Image'),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₱${product['price']}',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Using context.read() for one-time action
                          context.read<ShoppingCartProvider>().addItem(
                            CartItem(
                              id: product['id'] as String,
                              name: product['name'] as String,
                              price: product['price'] as double,
                              imageUrl: product['image'] as String,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product['name']} added to cart!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Consumer<ShoppingCartProvider>(
        builder: (context, cart, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_basket,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Items: ${cart.itemCount}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 20,
                        color: Colors.green[700],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₱${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: cart.items.isEmpty ? null : () {
                        cart.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cart cleared!')),
                        );
                      },
                      icon: Icon(Icons.clear_all, size: 18),
                      label: const Text('Clear Cart'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: cart.items.isEmpty ? null : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Checkout completed!')),
                        );
                        cart.clearCart();
                      },
                      icon: Icon(Icons.payment, size: 18),
                      label: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
