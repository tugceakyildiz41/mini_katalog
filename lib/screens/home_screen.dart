import 'package:flutter/material.dart';
import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../models/cart_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Product>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keşfet',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
                actions: [
          ListenableBuilder(
            listenable: cart,
            builder: (context, _) {
              return IconButton(
                icon: Badge(
                  label: Text('${cart.totalItems}'),
                  isLabelVisible: cart.totalItems > 0,
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final q = _query.toLowerCase();
          final products = snapshot.data!.where((p) {
            return p.name.toLowerCase().contains(q) ||
                p.category.toLowerCase().contains(q);
          }).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Aradığın ürünü bul',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Ürün ara...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildBanner(),
              const SizedBox(height: 20),
              if (products.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('Ürün bulunamadı')),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: product,
                        );
                      },
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 1,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HAFTANIN FIRSATI',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Seçili ürünlerde\nfırsatları kaçırma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.local_offer, color: Colors.white, size: 48),
        ],
      ),
    );
  }
}