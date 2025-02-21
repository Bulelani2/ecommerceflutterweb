import 'package:e_c_website/Screens/AboutPage.dart';
import 'package:e_c_website/Screens/footerwidget.dart';
import 'package:e_c_website/Screens/productcatalog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to make a phone call
  void _makePhoneCall() async {
    final Uri phoneUrl = Uri.parse("tel:0796109470");
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      _showErrorSnackBar("Could not make phone call");
    }
  }

  void _openWhatsApp() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/27796109470");
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      _showErrorSnackBar("Could not open WhatsApp");
    }
  }

  void _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'support@yourwebsite.com',
        queryParameters: {
          'subject': 'Customer Inquiry from ${_nameController.text}',
          'body': _messageController.text,
        },
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        _showConfirmationDialog();
      } else {
        _showErrorSnackBar("Could not open email app");
        debugPrint('Could not launch email');
      }
    }
  }

  // Error message handler
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message Sent"),
          content: const Text(
              "Your message has been sent successfully! We will get back to you soon."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner Animation
            Hero(
              tag: "contactBanner",
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Banner/contactus.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the products section
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductCatalogScreen()),
                          );
                          Scrollable.ensureVisible(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF333333),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "Home",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 15),
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
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "We’d Love to Hear from You!",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Reach out for inquiries, collaborations, or support.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Contact Buttons
                      ListTile(
                        leading: const Icon(
                          Icons.phone,
                          color: const Color(0xFF333333),
                          size: 28,
                        ),
                        title: const Text("0796109470"),
                        onTap: _makePhoneCall, // Implement phone call function
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.email,
                          color: const Color(0xFF333333),
                          size: 28,
                        ),
                        title: const Text("support@yourwebsite.com"),
                        onTap: _sendEmail,
                      ),
                      ListTile(
                        leading: const Icon(FontAwesomeIcons.whatsapp,
                            size: 28, color: const Color(0xFF333333)),
                        title: const Text("Chat on WhatsApp"),
                        onTap: _openWhatsApp, // Implement WhatsApp function
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Send Us a Message",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildAnimatedField(
                              controller: _nameController,
                              label: "Your Name",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Please enter your name"
                                      : null,
                            ),
                            const SizedBox(height: 10),
                            _buildAnimatedField(
                              controller: _emailController,
                              label: "Your Email",
                              validator: (value) => value == null ||
                                      value.isEmpty ||
                                      !value.contains('@')
                                  ? "Enter a valid email"
                                  : null,
                            ),
                            const SizedBox(height: 10),
                            _buildAnimatedField(
                              controller: _messageController,
                              label: "Your Message",
                              maxLines: 4,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Please enter a message"
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Animated Send Button
                      ScaleTransition(
                        scale: _fadeAnimation,
                        child: ElevatedButton.icon(
                          onPressed: _sendEmail,
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: const Text(
                            "Send Message",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF333333),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
