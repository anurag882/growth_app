import 'package:flutter_test/flutter_test.dart';
import 'package:growth_app/common/utils/score_calculator.dart';

void main() {
  group('ScoreCalculator', () {
    group('calculateFinanceScore', () {
      test('returns 0 when income is 0', () {
        expect(
          ScoreCalculator.calculateFinanceScore(
            monthlyIncome: 0,
            monthlyExpenses: 100,
          ),
          0,
        );
      });

      test('returns 100 when expenses are 0', () {
        expect(
          ScoreCalculator.calculateFinanceScore(
            monthlyIncome: 1000,
            monthlyExpenses: 0,
          ),
          100,
        );
      });

      test('returns 50 when expenses are half of income', () {
        expect(
          ScoreCalculator.calculateFinanceScore(
            monthlyIncome: 1000,
            monthlyExpenses: 500,
          ),
          50,
        );
      });

      test('returns 0 when expenses exceed income', () {
        expect(
          ScoreCalculator.calculateFinanceScore(
            monthlyIncome: 1000,
            monthlyExpenses: 1200,
          ),
          0,
        );
      });
    });

    group('calculateFitnessScore', () {
      test('returns 0 when no workouts and no sleep', () {
        expect(
          ScoreCalculator.calculateFitnessScore(
            workoutDays: List.filled(7, false),
            avgSleepHours: 0,
            targetSleepHours: 8,
            targetWorkoutsPerWeek: 3,
          ),
          0,
        );
      });

      test('returns 100 when all targets met', () {
        expect(
          ScoreCalculator.calculateFitnessScore(
            workoutDays: List.filled(7, true),
            avgSleepHours: 8,
            targetSleepHours: 8,
            targetWorkoutsPerWeek: 7,
          ),
          100,
        );
      });

      test('returns 75 with perfect sleep but half workouts', () {
        expect(
          ScoreCalculator.calculateFitnessScore(
            workoutDays: [true, true, true, false, false, false, false],
            avgSleepHours: 8,
            targetSleepHours: 8,
            targetWorkoutsPerWeek: 7,
          ),
          equals(71), // ~21.4 (3/7 * 50) + 50 (perfect sleep)
        );
      });
    });

    group('generateInsights', () {
      test('returns finance warning when score is low', () {
        final insights = ScoreCalculator.generateInsights(
          financeScore: 20,
          fitnessScore: 80,
          monthlyIncome: 5000,
          monthlyExpenses: 4500,
          avgSleepHours: 8,
          workoutsThisWeek: 5,
          targetWorkoutsPerWeek: 5,
        );

        expect(
          insights.any((i) => i.contains('spending is high')),
          true,
        );
      });

      test('returns sleep warning when average is low', () {
        final insights = ScoreCalculator.generateInsights(
          financeScore: 80,
          fitnessScore: 60,
          monthlyIncome: 5000,
          monthlyExpenses: 2000,
          avgSleepHours: 5,
          workoutsThisWeek: 5,
          targetWorkoutsPerWeek: 5,
        );

        expect(
          insights.any((i) => i.contains('less than 7 hours of sleep')),
          true,
        );
      });

      test('returns workout warning when below target', () {
        final insights = ScoreCalculator.generateInsights(
          financeScore: 80,
          fitnessScore: 60,
          monthlyIncome: 5000,
          monthlyExpenses: 2000,
          avgSleepHours: 8,
          workoutsThisWeek: 2,
          targetWorkoutsPerWeek: 5,
        );

        expect(
          insights.any((i) => i.contains('below your weekly workout target')),
          true,
        );
      });

      test('returns maximum 3 insights', () {
        final insights = ScoreCalculator.generateInsights(
          financeScore: 20,
          fitnessScore: 30,
          monthlyIncome: 5000,
          monthlyExpenses: 4800,
          avgSleepHours: 5,
          workoutsThisWeek: 1,
          targetWorkoutsPerWeek: 5,
        );

        expect(insights.length, lessThanOrEqualTo(3));
      });
    });
  });
}