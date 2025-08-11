import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class ErrorNotFoundPage extends StatelessWidget {
  const ErrorNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page Not Found",
          style: TextStyleConfig.body1,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/not_found.png"),
            Text(
              "I am sorry but the point you're looking for, is not available. Please try again later",
              style: TextStyleConfig.heading1bold,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}