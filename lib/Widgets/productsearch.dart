import 'package:e_c_website/Widgets/productcard.dart';
import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ScrollController scrollController = ScrollController();

    final results = products
        .where((product) =>
            product['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "No results found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Search Results",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (scrollController.position.pixels > 0) {
                  scrollController.animateTo(
                    scrollController.position.pixels - 300,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                child: Row(
                  children: results
                      .map((product) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProjectCard(product: product),
                          ))
                      .toList(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                if (scrollController.position.pixels <
                    scrollController.position.maxScrollExtent) {
                  scrollController.animateTo(
                    scrollController.position.pixels + 300,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
