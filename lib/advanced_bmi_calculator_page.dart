import 'package:flutter/material.dart';

class AdvancedBMICalculatorPage extends StatefulWidget {
  const AdvancedBMICalculatorPage({super.key});

  @override
  State<AdvancedBMICalculatorPage> createState() =>
      _AdvancedBMICalculatorPageState();
}

class _AdvancedBMICalculatorPageState
    extends State<AdvancedBMICalculatorPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final bodyFatController = TextEditingController();
  String physiqueImage = "";
  String ffmiRating = "";
  String selectedSex = "Male";
  String bodySubtitle = "";
  double bmi = 0;
  double fatMass = 0;
  double leanMass = 0;
  double ffmi = 0;
  Color ffmiColor = Colors.blue;
  String bmiCategory = "";
  String bodyFatCategory = "";
  String bodyCompositionSummary = "";
  String recommendation = "";

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    bodyFatController.dispose();
    super.dispose();
  }

  void calculateAdvancedBMI() {
  final double? height = double.tryParse(heightController.text);
  final double? weight = double.tryParse(weightController.text);
  final double? bodyFat = double.tryParse(bodyFatController.text);
  final int? age = int.tryParse(ageController.text);

  if (height == null ||
      weight == null ||
      bodyFat == null ||
      age == null ||
      height <= 0 ||
      weight <= 0 ||
      bodyFat <= 0 ||
      bodyFat >= 70 ||
      age <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter valid values."),
      ),
    );
    return;
  }

  final double heightMeters = height / 100;

  final double calculatedBMI =
      weight / (heightMeters * heightMeters);

  final double calculatedFatMass =
      weight * bodyFat / 100;

  final double calculatedLeanMass =
      weight - calculatedFatMass;

  final double calculatedFFMI =
      calculatedLeanMass /
      (heightMeters * heightMeters);

  //-----------------------------------
  // BMI Category
  //-----------------------------------

  String bmiCat;

  if (calculatedBMI < 18.5) {
    bmiCat = "Underweight";
  } else if (calculatedBMI < 25) {
    bmiCat = "Normal Weight";
  } else if (calculatedBMI < 30) {
    bmiCat = "Overweight";
  } else {
    bmiCat = "Obese";
  }

  //-----------------------------------
  // Healthy Body Fat Range
  //-----------------------------------

  double healthyMin;
  double healthyMax;

  if (selectedSex == "Male") {
    if (age < 40) {
      healthyMin = 8;
      healthyMax = 19;
    } else if (age < 60) {
      healthyMin = 11;
      healthyMax = 21;
    } else {
      healthyMin = 13;
      healthyMax = 24;
    }
  } else {
    if (age < 40) {
      healthyMin = 21;
      healthyMax = 32;
    } else if (age < 60) {
      healthyMin = 23;
      healthyMax = 33;
    } else {
      healthyMin = 24;
      healthyMax = 35;
    }
  }

  //-----------------------------------
  // Body Fat Category
  //-----------------------------------

  String bfCategory;

  if (bodyFat < healthyMin) {
    bfCategory = "Low Body Fat";
  } else if (bodyFat <= healthyMax) {
    bfCategory = "Healthy Body Fat";
  } else {
    bfCategory = "High Body Fat";
  }

  //-----------------------------------
  // Health Profile
  //-----------------------------------

  //-----------------------------------
// Body Composition Summary
//-----------------------------------

String summary;
String subtitle;
if ((bfCategory == "Healthy Body Fat" ||
     bfCategory == "Low Body Fat") &&
    calculatedFFMI >= 26) {
  physiqueImage = "assets/images/Sam-Suleks-Workout-Routine-Diet.png";
  summary = "dude, are you on steroids?🤨 Thats insane💪🔥";
  subtitle =
      "You have a very suspicious muscle mass while still staying lean. This is extremely rare and impressive";

}else if (bfCategory == "Low Body Fat" && calculatedFFMI >= 22) {
  physiqueImage = "assets/images/will.jpg";
  summary =
      "You are absolutely shredded twin🔥🔥💪";
  subtitle =
      "You are very muscular and insanely lean.";
}else if (bfCategory == "Healthy Body Fat" && calculatedFFMI >= 22) {
  physiqueImage = "assets/images/images.jpg";
  summary =
      "You are jacked as hell twin 🔥🔥💪";
  subtitle =
      "You are very muscular and lean.";

}else if (bfCategory == "Healthy Body Fat" &&
    calculatedFFMI >= 18) {
  physiqueImage = "assets/images/images.jpg";
  summary = "looking good bro, keep doing what you're doing🔥💪";
  subtitle =
      "You have a healthy balance of muscle and body fat.";
}else if (bfCategory == "High Body Fat" &&
    calculatedFFMI >= 26) {
  physiqueImage = "assets/images/ed.jpg";
  summary = "You deadlift 300kg let me guess?🔥💪";
  subtitle =
      "You are very muscular yet also have high body fat, common for a powerlifter";
}else if (bfCategory == "High Body Fat" &&
    calculatedFFMI >= 22) {
  physiqueImage = "assets/images/ed.jpg";
  summary = "You're already jacked, just need to lose those fats and we're getting there twin'🔥💪";
  subtitle =
      "You are muscular but still have some fats left to lose.";

} else if (bfCategory == "Healthy Body Fat" &&
    calculatedFFMI >= 16) {
  physiqueImage = "assets/images/avg.jpg";
  summary = "you're fine as you are but we could definitely get better, you got this twin💪🙏";
  subtitle =
      "you have a healthy body fats but average mass of muscle";

} else if (bfCategory == "High Body Fat") {
  physiqueImage = "assets/images/pet.jpg";
  summary = "can't lie bro, we need to lock in💔 its ok, you got this twin💪🙏";
  subtitle =
      "your body fats are really high";

} else if (bfCategory == "Low Body Fat") {
  physiqueImage = "assets/images/stick.jpg";
  summary = "yo we need to eat more twin💔 its ok, you got this twin💪🙏";
  subtitle =
      "You have very low body fat.";

} else {
  summary = "Healthy body composition.";
  subtitle =
      "Keep maintaining your current lifestyle.";
}
  //-----------------------------------
  // Recommendation
  //-----------------------------------

  String advice;

if ((bfCategory == "Healthy Body Fat" ||
     bfCategory == "Low Body Fat") &&
    calculatedFFMI >= 26) {
  advice =
      "• Your muscle mass is extremely high for your body fat level. You should become go on a bodybuilding show if you haven't already\n"
      "• I have nothing to tell you since you must already know your stuff at this point. Maintain your current training, but monitor recovery and health markers.\n"
      "• If you're using steriods and is at risk, please stop using it or atleast use less doses. You're health matters way mroe than your looks\n"
      "• please take care.";

} else if (bfCategory == "Low Body Fat" && calculatedFFMI >= 22) {
  advice =
      "• You are already very lean and muscular.\n"
      "• While you're looking good and shredded, your low body fat may cause some health issues and is at risks.\n"
      "• Maintain your calorie intake carefully or might even consider increasing the calories intake.\n"
      "• Focus on performance and recovery.\n"
      "• Avoid unnecessary cutting.";

} else if (bfCategory == "Healthy Body Fat" && calculatedFFMI >= 22) {
  advice =
      "• Excellent physique balance.\n"
      "• Continue strength training consistently.\n"
      "• Keep protein intake high.\n"
      "• Maintain current nutrition habits.";

} else if (bfCategory == "Healthy Body Fat" &&
    calculatedFFMI >= 18) {
  advice =
      "• You are progressing well.\n"
      "• Keep training consistently.\n"
      "• progressive overload will help further gains.\n"
      "• Maintain a balanced diet.";

} else if (bfCategory == "High Body Fat" &&
    calculatedFFMI >= 26) {
  advice =
      "• You have a very high muscle base.\n"
      "• Focus on gradual fat loss while maintaining strength.\n"
      "• Add steady cardio 2–3x per week.\n"
      "• Keep protein intake high.";

} else if (bfCategory == "High Body Fat" &&
    calculatedFFMI >= 22) {
  advice =
      "• Strong muscular base detected.\n"
      "• Start a controlled fat loss phase.\n"
      "• Prioritize resistance training.\n"
      "• Track calories more strictly.";

} else if (bfCategory == "Healthy Body Fat" &&
    calculatedFFMI >= 16) {
  advice =
      "• You are in a healthy range.\n"
      "• Build muscle gradually with resistance training.\n"
      "• Keep nutrition balanced.\n"
      "• Stay consistent.";

} else if (bfCategory == "High Body Fat") {
  advice =
      "• Focus on fat loss through diet and exercise.\n"
      "• Reduce processed foods and sugar intake.\n"
      "• Add regular cardio sessions.\n"
      "• Stay consistent over time.";

} else if (bfCategory == "Low Body Fat") {
  advice =
      "• Increase calorie intake gradually.\n"
      "• Prioritize strength training.\n"
      "• Ensure enough protein and recovery.\n"
      "• Avoid excessive cutting.";

} else {
  advice =
      "• Maintain your healthy lifestyle.\n"
      "• Stay active and consistent.\n"
      "• Keep a balanced diet.";
}

  //-----------------------------------
  // Update UI
  //-----------------------------------
  // FFMI Rating
if (calculatedFFMI < 15) {
  ffmiRating = "Below Average";
  ffmiColor = Colors.grey;

} else if (calculatedFFMI < 16) {
  ffmiRating = "Average";
  ffmiColor = Colors.blue;

} else if (calculatedFFMI < 20) {
  ffmiRating = "Good";
  ffmiColor = Colors.green;

} else if (calculatedFFMI < 26) {
  ffmiRating = "Athletic";
  ffmiColor = Colors.purple;

} else {
  ffmiRating = "Exceptional";
  ffmiColor = Colors.deepPurple;
}

  setState(() {
  bmi = calculatedBMI;
  fatMass = calculatedFatMass;
  leanMass = calculatedLeanMass;
  ffmi = calculatedFFMI;
  bmiCategory = bmiCat;
  bodyFatCategory = bfCategory;
  bodyCompositionSummary = summary;
  bodySubtitle = subtitle;
  recommendation = advice;
});
}

  Widget buildInput(
      TextEditingController controller,
      String label,
      String suffix,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Advanced BMI Calculator"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text(
              "Advanced BMI Calculator",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Uses body fat percentage, age and sex for a more accurate health assessment.",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 25),

            buildInput(heightController, "Height", "cm"),

            buildInput(weightController, "Weight", "kg"),

            buildInput(ageController, "Age", "yrs"),

            DropdownButtonFormField<String>(
              value: selectedSex,
              decoration: InputDecoration(
                labelText: "Sex",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Male",
                  child: Text("Male"),
                ),
                DropdownMenuItem(
                  value: "Female",
                  child: Text("Female"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSex = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            buildInput(bodyFatController, "Body Fat Percentage", "%"),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // Navigate to body fat guide later
                },
                icon: const Icon(Icons.help_outline),
                label: const Text("Don't know your body fat?"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  "Body fat percentage gives a much more accurate picture of your health than BMI alone. "
                  "People with the same BMI may have very different body compositions.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculateAdvancedBMI,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text(
                "Calculate",
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 30),

            if (bmi != 0) ...[
Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [

                      const Text(
                        "BMI",
                        style: TextStyle(fontSize: 18),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        bmi.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Chip(
  backgroundColor:
      bmiCategory == "Normal Weight"
          ? Colors.green
          : bmiCategory == "Overweight"
              ? Colors.orange
              : Colors.red,
  label: Text(
    bmiCategory,
    style: const TextStyle(
      color: Colors.white,
    ),
  ),
),
const SizedBox(height: 12),

Text(
  "Healthy BMI Range: 18.5 - 24.9",
  style: TextStyle(
    color: Colors.grey,
    fontSize: 14,
  ),
),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
Row(
  children: [

    Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const Text(
                "BODY FAT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "${bodyFatController.text}%",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Chip(
                backgroundColor:
                    bodyFatCategory == "Healthy Body Fat"
                        ? Colors.green
                        : bodyFatCategory == "Low Body Fat"
                            ? Colors.blue
                            : Colors.red,
                label: Text(
                  bodyFatCategory,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const Text(
                "FFMI",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                ffmi.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Chip(
                backgroundColor: ffmiColor,
                label: Text(
                  ffmiRating,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),

  ],
),
              

              Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Additional Metrics",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Divider(),

      

        ListTile(
          leading: const Icon(Icons.fitness_center),
          title: const Text("Lean Body Mass"),
          trailing: Text(
            "${leanMass.toStringAsFixed(1)} kg",
          ),
        ),

        ListTile(
          leading: const Icon(Icons.sports_gymnastics),
          title: const Text("Fat Mass"),
          trailing: Text(
            "${fatMass.toStringAsFixed(1)} kg",
          ),
        ),

      ],
    ),
  ),
),

              const SizedBox(height: 20),
              
              Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Your Physique",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 15),

        Center(
  child: Column(
    children: [

      if (physiqueImage.isNotEmpty)
        Image.asset(
          physiqueImage,
          height: 180,
          fit: BoxFit.cover,
        ),

      const SizedBox(height: 10),

      Text(
        bodyCompositionSummary,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 10),

      Text(
        bodySubtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
      ),
    ],
  ),
),

      ],
    ),
  ),
),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Recommendations",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        recommendation,
                        style:
                            const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ],
        ),
      ),
    );
  }
}