import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/theme_constants.dart';
import 'models/format_model.dart';
import 'models/template_model.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CosmoscribeApp());
}

class CosmoscribeApp extends StatelessWidget {
  const CosmoscribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemplateProvider()),
        ChangeNotifierProvider(create: (_) => FormatProvider()),
      ],
      child: MaterialApp(
        title: 'Cosmoscribe',
        theme: AppTheme.getTheme(),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class TemplateProvider extends ChangeNotifier {
  Template? _selectedTemplate;
  
  Template? get selectedTemplate => _selectedTemplate;
  
  void selectTemplate(Template template) {
    _selectedTemplate = template;
    notifyListeners();
  }
  
  void updateTemplateField(String fieldId, String value) {
    if (_selectedTemplate != null) {
      final fieldIndex = _selectedTemplate!.fields.indexWhere((field) => field.id == fieldId);
      if (fieldIndex != -1) {
        _selectedTemplate!.fields[fieldIndex].value = value;
        notifyListeners();
      }
    }
  }
  
  void clearSelectedTemplate() {
    _selectedTemplate = null;
    notifyListeners();
  }
}

class FormatProvider extends ChangeNotifier {
  FormatType _selectedFormatType = FormatType.markdown;
  
  FormatType get selectedFormatType => _selectedFormatType;
  FileFormat get selectedFormat => FileFormat.getFormatByType(_selectedFormatType);
  
  void selectFormat(FormatType formatType) {
    _selectedFormatType = formatType;
    notifyListeners();
  }
}
