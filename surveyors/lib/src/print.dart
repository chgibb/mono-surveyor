import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/generated/engine.dart' show AnalysisErrorInfoImpl;
import 'package:analyzer/src/lint/linter.dart';
import 'package:path/path.dart' as path;
import 'package:surveyor/src/analysis.dart';
import 'package:surveyor/src/driver.dart';
import 'package:surveyor/src/visitors.dart';

class PrintSurveyor extends LintRule implements NodeLintRule {
  static const _desc = r'Avoid `print` calls in production code.';
  static const _details = r'''
**DO** avoid `print` calls in production code.

**BAD:**
```
void f(int x) {
  print('debug: $x');
  ...
}
```
''';
  PrintSurveyor()
      : super(
            name: 'avoid_print',
            description: _desc,
            details: _details,
            group: Group.errors);

  @override
  void registerNodeProcessors(NodeLintRegistry registry,
      [LinterContext context]) {
    var visitor = _Visitor(this);
    registry.addMethodInvocation(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor {
  final LintRule rule;

  _Visitor(this.rule);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    bool isDartCore(MethodInvocation node) =>
        node.methodName.staticElement?.library?.name == 'dart.core';

    if (node.methodName.name == 'print' && isDartCore(node)) {
      rule.reportLint(node.methodName);
    }
  }
}
