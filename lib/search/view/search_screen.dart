import 'package:ecommerce_app/repositories/search_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchSuggestionsProvider = FutureProvider<List<String>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  return SearchService.getSuggestions(query);
});

final searchResultsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  return SearchService.searchProducts(query); // Simulated service
});
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  @override
  Widget build(BuildContext context) {
 final query = ref.watch(searchQueryProvider);
    final suggestionsAsync = ref.watch(searchSuggestionsProvider);
    final resultsAsync = ref.watch(searchResultsProvider);




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  TextField(
          
          onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          // Suggestions Section
          if (query.isNotEmpty)
            Expanded(
              child: suggestionsAsync.when(
                data: (suggestions) => ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        ref.read(searchQueryProvider.notifier).state = suggestion;
                      },
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => const Center(child: Text('Error loading suggestions')),
              ),
            ),

          // Results Section
          if (query.isNotEmpty)
            Expanded(
              child: resultsAsync.when(
                data: (products) => ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => const Center(child: Text('Error loading results')),
              ),
            ),
        ],
      ),
      );
  }
}