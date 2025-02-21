import 'package:e_c_website/Data/json.dart';
import 'package:e_c_website/Screens/AboutPage.dart';
import 'package:e_c_website/Screens/contactPage.dart';
import 'package:flutter/material.dart';
import 'package:e_c_website/Screens/categoryscreen.dart';
import 'package:e_c_website/Screens/footerwidget.dart';
import 'package:e_c_website/Widgets/productcard.dart';
import 'package:e_c_website/Widgets/productsearch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allProducts = [...iphones, ...sneakers];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            // 🏆 HERO SECTION
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/Banner/banner1.png"), // Use your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5), // Dark overlay
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Premium iPhones & Sneakers",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Shop the best deals on authentic products",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutPage()),
                              );
                              // Navigate to the products section
                              Scrollable.ensureVisible(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF333333),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              "About Us",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to the products section
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactPage()),
                              );
                              Scrollable.ensureVisible(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF333333),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              "Contact Us",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(allProducts));
                },
              ),
            ),

            // Category Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categoryButton(context, 'iPhones', iphones),
                  categoryButton(context, 'Sneakers', sneakers),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Featured Products (Carousel)
            CarouselSlider(
              options: CarouselOptions(
                  height: 450, autoPlay: true, enlargeCenterPage: true),
              items: allProducts.map((product) {
                return ProjectCard(product: product);
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Product Listings
            buildCategorySection('iPhones', iphones),
            buildCategorySection('Sneakers', sneakers),

            // Contact & Footer
            // ContactScreen(),
            const SizedBox(height: 20),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget buildCategorySection(
      String title, List<Map<String, String>> products) {
    return Column(
      children: [
        Center(
          child: Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        buildProductGrid(products),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildProductGrid(List<Map<String, String>> products) {
    ScrollController scrollController = ScrollController();
    return Row(
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
              children: products
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
    );
  }

  Widget categoryButton(
      BuildContext context, String title, List<Map<String, String>> products) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CategoryScreen(title: title, products: products)),
        );
      },
      child: Column(
        children: [
          const Icon(FontAwesomeIcons.store,
              size: 40, color: const Color(0xFF333333)),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
