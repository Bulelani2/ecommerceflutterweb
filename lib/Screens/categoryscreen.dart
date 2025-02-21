import 'package:e_c_website/Widgets/productcard.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  final List<Map<String, String>> products;

  CategoryScreen({required this.title, required this.products});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isGrid = true;
  List<Map<String, String>> filteredProducts = [];
  String sortOption = "None";
  double minPrice = 0;
  double maxPrice = 33000;
  double selectedMin = 0;
  double selectedMax = 33000;

  TextEditingController searchController = TextEditingController();
  Set<String> wishlist = {};

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(widget.products);
    updateFilteredProducts();
  }

  void updateFilteredProducts() {
    setState(() {
      filteredProducts = widget.products.where((product) {
        double price =
            double.tryParse(product['price']!.replaceAll('\R', '')) ?? 0;
        return price >= selectedMin && price <= selectedMax;
      }).toList();

      if (sortOption == "Low to High") {
        filteredProducts.sort((a, b) =>
            double.parse(a['price']!.replaceAll('\R', ''))
                .compareTo(double.parse(b['price']!.replaceAll('\R', ''))));
      } else if (sortOption == "High to Low") {
        filteredProducts.sort((a, b) =>
            double.parse(b['price']!.replaceAll('\R', ''))
                .compareTo(double.parse(a['price']!.replaceAll('\R', ''))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF333333),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view,
                color: Colors.white),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Search",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      filteredProducts =
                          widget.products; // Reset to all products
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filteredProducts = widget.products.where((product) {
                    return product['name']!
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    value: sortOption,
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: const Color(0xFF333333),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black),
                    items: ["None", "Low to High", "High to Low"]
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        sortOption = newValue!;
                        updateFilteredProducts();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF333333),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Filter by Price Range",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    RangeSlider(
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.grey,
                                      values:
                                          RangeValues(selectedMin, selectedMax),
                                      min: minPrice,
                                      max: maxPrice,
                                      divisions: 30,
                                      labels: RangeLabels(
                                          "\R${selectedMin.toInt()}",
                                          "\R${selectedMax.toInt()}"),
                                      onChanged: (RangeValues values) {
                                        setState(() {
                                          selectedMin = values.start;
                                          selectedMax = values.end;
                                        });
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF333333),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 50,
                                          vertical: 15,
                                        ),
                                      ),
                                      onPressed: () {
                                        updateFilteredProducts();
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Apply Filters",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  double aspectRatio = constraints.maxWidth > 600 ? 0.85 : 0.55;

                  return filteredProducts.isEmpty
                      ? const Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      : isGrid
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: aspectRatio,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 30,
                              ),
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                return ProjectCard(
                                    product: filteredProducts[index]);
                              },
                            )
                          : ListView.builder(
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Image.asset(
                                      filteredProducts[index]['image']!),
                                  title: Text(filteredProducts[index]['name']!),
                                  subtitle:
                                      Text(filteredProducts[index]['price']!),
                                  trailing: IconButton(
                                    icon: wishlist.contains(
                                            filteredProducts[index]['name'])
                                        ? const Icon(Icons.favorite,
                                            color: Colors.red)
                                        : const Icon(Icons.favorite_border),
                                    onPressed: () {
                                      setState(() {
                                        if (wishlist.contains(
                                            filteredProducts[index]['name'])) {
                                          wishlist.remove(
                                              filteredProducts[index]['name']);
                                        } else {
                                          wishlist.add(
                                              filteredProducts[index]['name']!);
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
