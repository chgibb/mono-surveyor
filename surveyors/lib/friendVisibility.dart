import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/src/lint/linter.dart';
import 'package:meta/meta.dart';
import 'package:surveyors/src/package.dart';

class FriendVisibilitySurveyor extends LintRule implements NodeLintRule {
  final List<Package> packages;

  FriendVisibilitySurveyor({@required this.packages})
      : super(
            name: 'avoid_non_friends',
            description: "Avoid using symbols in non-friend packages",
            details: "",
            group: Group.errors);

  @override
  void registerNodeProcessors(NodeLintRegistry registry,
      [LinterContext context]) {
    var visitor = _Visitor(rule: this, packages: packages);
    registry.addMethodInvocation(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor {
  final LintRule rule;
  final List<Package> packages;

  _Visitor({@required this.rule, @required this.packages});

  @override
  void visitMethodInvocation(MethodInvocation node) {
    try {
      String invokeeLibrarySource =
          node.methodName.staticElement?.librarySource?.fullName;

      Package invokeePackage;

      invokeePackage = packages.firstWhere(
          (x) =>
              RegExp(RegExp.escape(x.dir), caseSensitive: false)
                  .stringMatch(invokeeLibrarySource ?? "")
                  ?.isNotEmpty ??
              false,
          orElse: () => null);

      if (invokeePackage != null) {
        CompilationUnit invokingCompilationUnit =
            node.thisOrAncestorMatching<CompilationUnit>(
                (argument) => argument is CompilationUnit);

        Package invokerPackage = packages.firstWhere(
            (x) =>
                RegExp(RegExp.escape(x.dir), caseSensitive: false)
                    .stringMatch(invokingCompilationUnit
                        .declaredElement?.librarySource?.fullName)
                    ?.isNotEmpty ??
                false,
            orElse: () => null);

        bool isLegalReference = invokeePackage.friends.firstWhere(
                (element) => element == invokerPackage.dir,
                orElse: () => null) !=
            null;

        if (!isLegalReference) {
          rule.reportLint(node.methodName);
        }
      }
    } catch (err, stack) {
      print(err);
      print(stack);
    }
  }
}
