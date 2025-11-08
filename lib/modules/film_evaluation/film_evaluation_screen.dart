import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_colors.dart';
import 'components/upload_step.dart';
import 'components/evaluating_step.dart';
import 'components/results_step.dart';

class FilmEvaluationScreen extends StatefulWidget {
  const FilmEvaluationScreen({super.key});

  @override
  State<FilmEvaluationScreen> createState() => _FilmEvaluationScreenState();
}

class _FilmEvaluationScreenState extends State<FilmEvaluationScreen> {
  int _currentStep = 0;
  Map<String, dynamic> _evaluationResult = {};

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void _resetEvaluation() {
    setState(() {
      _currentStep = 0;
      _evaluationResult = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Film Evaluation',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_currentStep) {
      case 0:
        return UploadStep(
          onUpload: (url) => _handleUpload(url),
        );
      case 1:
        return const EvaluatingStep();
      case 2:
        return ResultsStep(
          result: _evaluationResult,
          onReset: _resetEvaluation,
        );
      default:
        return UploadStep(
          onUpload: (url) => _handleUpload(url),
        );
    }
  }

  void _handleUpload(String url) {
    _goToStep(1);
    // Simulate evaluation
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _evaluationResult = {
            'score': 82,
            'feedback': 'Great effort! Focus on positioning and decision making.',
            'drillSuggestion': 'Work on defensive positioning drills',
            'tokensEarned': 15,
          };
          _currentStep = 2;
        });
      }
    });
  }
}

