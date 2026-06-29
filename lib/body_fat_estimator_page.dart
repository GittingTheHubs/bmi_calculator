import 'package:flutter/material.dart';

class BodyFatEstimatorPage extends StatefulWidget {
  const BodyFatEstimatorPage({super.key});

  @override
  State<BodyFatEstimatorPage> createState() => _BodyFatEstimatorPageState();
}

class _BodyFatEstimatorPageState extends State<BodyFatEstimatorPage> {
  // ==========================================
  // STATE VARIABLES & LOGIC
  // ==========================================
  double? selectedBodyFat;
  int exerciseDays = 0;
  String physique = "";

  void calculateBodyFat() {
    double base = selectedBodyFat ?? 20;

    // Adjust based on weekly activity levels
    if (exerciseDays >= 5) {
      base -= 2;
    } else if (exerciseDays <= 1) {
      base += 2;
    }

    // Adjust based on self-described physique
    if (physique == "Very Lean") {
      base -= 3;
    } else if (physique == "Soft") {
      base += 3;
    }

    // Safety clamp to keep bounds realistic
    base = base.clamp(5, 45);

    Navigator.pop(context, base);
  }

  // ==========================================
  // CUSTOM CARD WIDGET
  // ==========================================
  Widget fatCard(String label, String image, double value) {
    final isSelected = selectedBodyFat == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBodyFat = value;
        });
      },
      child: Card(
        elevation: isSelected ? 5 : 2,
        color: isSelected ? Colors.blue.shade50 : null,
        child: Padding(
          padding: const EdgeInsets.all(6), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.contain, 
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10, 
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // MAIN BUILD METHOD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estimate Body Fat"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------
            // SECTION 1: Visual Body Fat Grid (4 per row)
            // ------------------------------------------
            const Text(
              "Select the image that looks closest to you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,         
                childAspectRatio: 0.65, // Taller aspect ratio to prevent labels from breaking over 4 columns   
                crossAxisSpacing: 8,       
                mainAxisSpacing: 8,
              ),
              children: [
                fatCard("Athletic (6–10%)", "assets/images/extremelean.png", 8),
                fatCard("Lean (10–15%)", "assets/images/10.png", 13),
                fatCard("Fit (15–20%)", "assets/images/15.png", 18),
                fatCard("Average (20–25%)", "assets/images/20.png", 23),
                fatCard("Overweight (25–30%)", "assets/images/25.png", 28),
                fatCard("High (30–40%)", "assets/images/30.png", 35),
                fatCard("Very High (40%+)", "assets/images/40.png", 42),
              ],
            ),
            const SizedBox(height: 25),

            // ------------------------------------------
            // SECTION 2: Exercise Frequency Slider
            // ------------------------------------------
            const Text(
              "How often do you exercise?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: exerciseDays.toDouble(),
              min: 0,
              max: 7,
              divisions: 7,
              label: "$exerciseDays days/week",
              onChanged: (value) {
                setState(() {
                  exerciseDays = value.toInt();
                });
              },
            ),
            const SizedBox(height: 10),

            // ------------------------------------------
            // SECTION 3: Physique Descriptor Chips
            // ------------------------------------------
            const Text(
              "How would you describe your physique?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text("Very Lean"),
                  selected: physique == "Very Lean",
                  onSelected: (_) => setState(() => physique = "Very Lean"),
                ),
                ChoiceChip(
                  label: const Text("Average"),
                  selected: physique == "Average",
                  onSelected: (_) => setState(() => physique = "Average"),
                ),
                ChoiceChip(
                  label: const Text("Soft"),
                  selected: physique == "Soft",
                  onSelected: (_) => setState(() => physique = "Soft"),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ------------------------------------------
            // SECTION 4: Submit Button
            // ------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedBodyFat == null 
                    ? null 
                    : calculateBodyFat,
                child: const Text("Use This Estimate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}