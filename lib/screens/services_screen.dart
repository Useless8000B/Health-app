import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 24),
              const Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              _buildCategoryList(),
              const SizedBox(height: 32),
              _buildDoctorTile(
                name: "Dr. Peter Parker",
                specialty: "Spider Specialist",
                themeColor: const Color(0xFF1976D2),
                imageUrl: "https://randomuser.me/api/portraits/men/1.jpg",
              ),
              const SizedBox(height: 12),
              _buildDoctorTile(
                name: "Dr. Stephen Strange",
                specialty: "Neurologist",
                themeColor: const Color(0xFFFF5252),
                imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
              ),
              const SizedBox(height: 12),
              _buildDoctorTile(
                name: "Dr. Conors",
                specialty: "Lizard Specialist",
                themeColor: const Color(0xFFFF5252),
                imageUrl: "https://randomuser.me/api/portraits/men/3.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      style: TextStyle(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        suffixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: "Search",
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildCategoryCard({
    required Color color,
    required IconData icon,
    required String title,
  }) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              left: -20,
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                radius: 40,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 26),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryCard(
            color: const Color(0xFF1976D2),
            icon: Icons.coronavirus,
            title: "Covid-19\nSpecialist",
          ),
          const SizedBox(width: 12),
          _buildCategoryCard(
            color: const Color(0xFF00C569),
            icon: Icons.local_pharmacy,
            title: "Chemist &\nDrugist",
          ),
          const SizedBox(width: 12),
          _buildCategoryCard(
            color: const Color(0xFF7A54FF),
            icon: Icons.biotech,
            title: "General\nSurgeon",
          ),
          const SizedBox(width: 12),
          _buildCategoryCard(
            color: const Color(0xFFFF5252),
            icon: Icons.emergency,
            title: "Emergency\nUnit",
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorTile({
    required String name,
    required String specialty,
    required Color themeColor,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, size: 35, color: themeColor),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(specialty, style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 15),
        ],
      ),
    );
  }
}
