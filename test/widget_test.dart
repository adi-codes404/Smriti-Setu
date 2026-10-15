import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smriti_setu/app/theme/app_theme.dart';
import 'package:smriti_setu/features/archive/data/demo_memories.dart';
import 'package:smriti_setu/features/archive/presentation/memory_archive_screen.dart';
import 'package:smriti_setu/features/archive/presentation/memory_detail_screen.dart';
import 'package:smriti_setu/features/onboarding/presentation/role_selection_screen.dart';
import 'package:smriti_setu/features/onboarding/presentation/splash_screen.dart';
import 'package:smriti_setu/features/sender/presentation/elderly_home_screen.dart';
import 'package:smriti_setu/features/sender/presentation/record_message_screen.dart';
import 'package:smriti_setu/features/sender/presentation/review_message_screen.dart';
import 'package:smriti_setu/features/sender/presentation/send_confirmation_screen.dart';
import 'package:smriti_setu/main.dart';

void main() {
  testWidgets('SmritiSetuApp loads without error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Smriti Setu'), findsOneWidget);
    expect(
      find.text('A bridge for voices, memories and people.'),
      findsOneWidget,
    );
  });

  testWidgets('SplashScreen renders and displays branding', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: SplashScreen()),
    );
    expect(find.text('Smriti Setu'), findsOneWidget);
    expect(
      find.text('A bridge for voices, memories and people.'),
      findsOneWidget,
    );
  });

  testWidgets('RoleSelectionScreen renders accessible options', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RoleSelectionScreen(),
      ),
    );
    expect(find.text('How will you use Smriti Setu?'), findsOneWidget);
    expect(find.text('SEND A MESSAGE'), findsOneWidget);
    expect(find.text('RECEIVE & REMEMBER'), findsOneWidget);
    expect(find.text('HELP SOMEONE'), findsOneWidget);
  });

  testWidgets('ElderlyHomeScreen renders RECORD and LISTEN cards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ElderlyHomeScreen(),
      ),
    );
    expect(find.text('Namaste'), findsOneWidget);
    expect(find.text('RECORD'), findsOneWidget);
    expect(find.text('LISTEN'), findsOneWidget);
    expect(find.text('Hear this screen'), findsOneWidget);
  });

  testWidgets('RecordMessageScreen renders demo flow and sample message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RecordMessageScreen(),
      ),
    );
    expect(find.text('Record a Message'), findsWidgets);
    expect(find.text('START RECORDING'), findsOneWidget);
    expect(find.text('CONTINUE TO REVIEW'), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(
      find.text('“${RecordMessageScreen.sampleMessage}”'),
      findsOneWidget,
    );

    // Tap Start Recording
    await tester.tap(find.text('START RECORDING'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('STOP RECORDING'), findsOneWidget);

    // Tap Stop Recording
    await tester.tap(find.text('STOP RECORDING'));
    await tester.pump();
    expect(find.text('RECORD AGAIN'), findsOneWidget);
  });

  testWidgets('ReviewMessageScreen renders preview card and actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ReviewMessageScreen(),
      ),
    );
    expect(find.text('Review Your Message'), findsOneWidget);
    expect(find.text('Demo message'), findsOneWidget);
    expect(find.text('SEND MESSAGE'), findsOneWidget);
    expect(find.text('EDIT MESSAGE'), findsOneWidget);
    expect(find.text('BACK'), findsOneWidget);
    expect(
      find.text('“${RecordMessageScreen.sampleMessage}”'),
      findsOneWidget,
    );
  });

  testWidgets('SendConfirmationScreen renders confirmation and return home button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const SendConfirmationScreen(),
      ),
    );
    expect(
      find.text('Your message is ready for your family.'),
      findsOneWidget,
    );
    expect(find.text('RETURN HOME'), findsOneWidget);
    expect(find.text('Local Demo Notice'), findsOneWidget);
  });

  testWidgets('MemoryArchiveScreen renders sample memory cards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const MemoryArchiveScreen(),
      ),
    );
    expect(find.text('Memory Archive'), findsWidgets);
    for (final memory in kDemoMemories) {
      expect(find.text(memory.title), findsOneWidget);
      expect(find.text(memory.sender), findsOneWidget);
    }
  });

  testWidgets('MemoryDetailScreen renders full message and player', (
    WidgetTester tester,
  ) async {
    final sample = kDemoMemories.first;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: MemoryDetailScreen(memory: sample),
      ),
    );
    expect(find.text('Memory Details'), findsOneWidget);
    expect(find.text(sample.sender), findsOneWidget);
    expect(find.text(sample.fullText), findsOneWidget);
    expect(find.text('BACK TO ARCHIVE'), findsOneWidget);
  });
}
