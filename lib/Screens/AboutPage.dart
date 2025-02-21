import 'package:e_c_website/Screens/contactPage.dart';
import 'package:e_c_website/Screens/footerwidget.dart';
import 'package:e_c_website/Screens/productcatalog.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Banner
            FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/Banner/aboutus.png"), // Add your image here
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Discover Our Story",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                                      builder: (context) =>
                                          ProductCatalogScreen()),
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
                                "Home",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section with Animation
                  FadeIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF333333),
                            const Color(0xFF333333)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "Welcome to Our Website",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Your go-to platform for high-quality products and seamless shopping experience.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // About Section
                  FadeInLeft(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Who We Are",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "We are a platform dedicated to bringing you the best iPhones and Sneakers with a smooth and reliable purchasing process.",
                      style: TextStyle(
                          fontSize: 20, color: const Color(0xFF333333)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mission, Vision, Values
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "🎯 Our Mission",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            "To provide a reliable and efficient online catalog for premium products with direct contact to trusted sellers.",
                          ),
                          SizedBox(height: 10),
                          Text(
                            "🌍 Our Vision",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            "To become the most trusted online marketplace for high-quality iPhones and Sneakers.",
                          ),
                          SizedBox(height: 10),
                          Text(
                            "💡 Our Values",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            "- Quality & Trust\n- Customer Satisfaction\n- Transparency & Fair Pricing",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Why Choose Us Section
                  FadeInLeft(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Why Choose Us?",
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xFF333333)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: const Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: const Color(0xFF333333)),
                          title: Text("Handpicked, high-quality products"),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: const Color(0xFF333333)),
                          title: Text("Verified sellers for reliability"),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: const Color(0xFF333333)),
                          title: Text("Direct contact with sellers"),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: const Color(0xFF333333)),
                          title: Text("Secure and seamless transactions"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Footer remains at the bottom
            Footer(),
          ],
        ),
      ),
    );
  }
}
