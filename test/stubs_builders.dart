import 'package:code_checker/metrics.dart';
import 'package:dart_code_metrics/src/models/component_record.dart';
import 'package:dart_code_metrics/src/models/component_report.dart';
import 'package:dart_code_metrics/src/models/function_record.dart';
import 'package:dart_code_metrics/src/models/function_report.dart';

ComponentRecord buildComponentRecordStub({
  int firstLine = 0,
  int lastLine = 0,
  int methodsCount = 0,
  double weightOfClass = 1,
}) =>
    ComponentRecord(
      firstLine: firstLine,
      lastLine: lastLine,
      methodsCount: methodsCount,
      weightOfClass: weightOfClass,
    );

FunctionRecord buildFunctionRecordStub({
  int firstLine = 0,
  int lastLine = 0,
  int argumentsCount = 0,
  Map<int, int> cyclomaticLinesComplexity = const <int, int>{},
  Iterable<int> linesWithCode = const <int>[],
  Iterable<Iterable<int>> nestingLines = const [<int>[]],
  Map<int, int> operators = const <int, int>{},
  Map<int, int> operands = const <int, int>{},
}) =>
    FunctionRecord(
      firstLine: firstLine,
      lastLine: lastLine,
      argumentsCount: argumentsCount,
      cyclomaticComplexityLines: Map.unmodifiable(cyclomaticLinesComplexity),
      linesWithCode: linesWithCode,
      nestingLines: nestingLines,
      operators: Map.unmodifiable(operators),
      operands: Map.unmodifiable(operands),
    );

ComponentReport buildComponentReportStub({
  int methodsCount = 0,
  MetricValueLevel methodsCountViolationLevel = MetricValueLevel.none,
  double weightOfClass = 1,
  MetricValueLevel weightOfClassViolationLevel = MetricValueLevel.none,
}) =>
    ComponentReport(
      methodsCount: MetricValue<int>(
        metricsId: '',
        value: methodsCount,
        level: methodsCountViolationLevel,
        comment: '',
      ),
      weightOfClass: MetricValue<double>(
        metricsId: '',
        value: weightOfClass,
        level: weightOfClassViolationLevel,
        comment: '',
      ),
    );

FunctionReport buildFunctionReportStub({
  int cyclomaticComplexity = 0,
  MetricValueLevel cyclomaticComplexityViolationLevel = MetricValueLevel.none,
  int linesOfExecutableCode = 0,
  MetricValueLevel linesOfExecutableCodeViolationLevel = MetricValueLevel.none,
  double maintainabilityIndex = 0,
  MetricValueLevel maintainabilityIndexViolationLevel = MetricValueLevel.none,
  int argumentsCount = 0,
  MetricValueLevel argumentsCountViolationLevel = MetricValueLevel.none,
  int maximumNestingLevel = 0,
  MetricValueLevel maximumNestingLevelViolationLevel = MetricValueLevel.none,
}) =>
    FunctionReport(
      cyclomaticComplexity: MetricValue<int>(
        metricsId: '',
        value: cyclomaticComplexity,
        level: cyclomaticComplexityViolationLevel,
        comment: '',
      ),
      linesOfExecutableCode: MetricValue<int>(
        metricsId: '',
        value: linesOfExecutableCode,
        level: linesOfExecutableCodeViolationLevel,
        comment: '',
      ),
      maintainabilityIndex: MetricValue<double>(
        metricsId: '',
        value: maintainabilityIndex,
        level: maintainabilityIndexViolationLevel,
        comment: '',
      ),
      argumentsCount: MetricValue<int>(
        metricsId: '',
        value: argumentsCount,
        level: argumentsCountViolationLevel,
        comment: '',
      ),
      maximumNestingLevel: MetricValue<int>(
        metricsId: '',
        value: maximumNestingLevel,
        level: maximumNestingLevelViolationLevel,
        comment: '',
      ),
    );
