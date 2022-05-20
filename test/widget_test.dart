import 'package:about_canada/main.dart';
import 'package:about_canada/resource/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group(('Testing the widget in home screen for different scenarios'), (){

    //CASE 1 - Positive scenario - Search title
    testWidgets('Search title positive scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var txtForm = find.byKey(const Key(AppConstants.searchViewKey));
      await tester.enterText(txtForm, 'flag');
      expect(find.text('flag'), findsOneWidget); // alphabets are valid
    });

    //CASE 2 - Negative scenario - Search title
    testWidgets('Search title positive scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var txtForm = find.byKey(const Key(AppConstants.searchViewKey));
      await tester.enterText(txtForm, '123');
      expect(find.text('123'), findsNothing); // numbers shouldn't be allowed
    });

    //CASE 3 - Positive scenario - Find floating action button
    testWidgets('Find floating action button positive scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var buttonFinder = find.byKey(const Key(AppConstants.floatingButtonKey));
      expect(buttonFinder, findsOneWidget); // alphabets are valid
    });

    //CASE 4 - Negative scenario - Find loading widget
    testWidgets('Find loading widget negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var buttonFinder = find.byKey(const Key(AppConstants.loadingWidgetKey));
      expect(buttonFinder, findsNothing); // alphabets are valid
    });

    //CASE 4 - Negative scenario - Find error widget
    testWidgets('Find error widget negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var buttonFinder = find.byKey(const Key(AppConstants.searchListViewKey));
      expect(buttonFinder, findsNothing); // alphabets are valid
    });

    //CASE 5 - Negative scenario - Find list view widget
    testWidgets('Find list view negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var buttonFinder = find.byKey(const Key(AppConstants.normalListViewKey));
      expect(buttonFinder, findsNothing); // alphabets are valid
    });

  });
}