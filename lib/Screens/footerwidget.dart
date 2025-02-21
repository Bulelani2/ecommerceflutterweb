import 'package:e_c_website/Screens/AboutPage.dart';
import 'package:e_c_website/Screens/contactPage.dart';
import 'package:e_c_website/Screens/productcatalog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      color: const Color(0xFF333333), // Dark background for contrast
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 📌 Social Media Links
          Wrap(
            spacing: 20,
            children: [
              _buildSocialIcon(Icons.phone, "tel:0796109470"),
              _buildSocialIcon(Icons.email, "mailto:bu...@gmail.com"),
              _buildSocialIcon(
                  FontAwesomeIcons.whatsapp, "https://wa.me/27796109470"),
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.7),
            thickness: 0.8, // Thin line
            height: 20, // Reduce vertical space
            indent: 50, // Shorter line from left
            endIndent: 50, // Shorter line from right
          ),

          const SizedBox(height: 20),

          // 📌 Quick Links
          Wrap(
            spacing: 20,
            children: [
              _buildFooterLink(context, "Home", ProductCatalogScreen()),
              _buildFooterLink(context, "About", AboutPage()),
              _buildFooterLink(context, "Contact", ContactPage()),
            ],
          ),

          const SizedBox(height: 20),

          // 📌 Copyright Text
          Text(
            "© ${DateTime.now().year} Bulelani. All rights reserved.",
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }

  // 📌 Helper function for social media icons
  Widget _buildSocialIcon(IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  // 📌 Updated Footer Link Function
  Widget _buildFooterLink(BuildContext context, String text, Widget page) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
