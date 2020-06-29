import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
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
    registry.addImportDirective(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor {
  final LintRule rule;
  final List<Package> packages;

  _Visitor({@required this.rule, @required this.packages});

  void verifyVisibility(
      {@required Element staticElement,
      @required AstNode astNode,
      @required CompilationUnit compilationUnit}) {
    try {
      String invokeeLibrarySource = staticElement?.librarySource?.fullName;

      Package invokeePackage;

      invokeePackage = packages.firstWhere(
          (x) =>
              RegExp(RegExp.escape(x.relativePath), caseSensitive: false)
                  .stringMatch(invokeeLibrarySource ?? "")
                  ?.isNotEmpty ??
              false,
          orElse: () => null);

      if (invokeePackage != null) {
        if (compilationUnit.declaredElement?.librarySource?.fullName !=
            invokeeLibrarySource) {
          Package invokerPackage = packages.firstWhere(
              (x) =>
                  RegExp(RegExp.escape(x.relativePath), caseSensitive: false)
                      .stringMatch(compilationUnit
                          .declaredElement?.librarySource?.fullName)
                      ?.isNotEmpty ??
                  false,
              orElse: () => null);

          if (invokeePackage.relativePath != invokerPackage.relativePath) {
            bool isLegalReference = invokeePackage.friends.firstWhere(
                    (element) => element == invokerPackage.relativePath,
                    orElse: () => null) !=
                null;

            if (!isLegalReference) {
              rule.reportLint(astNode);
            }
          }
        }
      }
    } catch (err, stack) {
      print(err);
      print(stack);
    }
  }

  @override
  void visitImportDirective(ImportDirective node) {
    verifyVisibility(
        astNode: node,
        staticElement: node.uriElement,
        compilationUnit: node.thisOrAncestorMatching<CompilationUnit>(
            (argument) => argument is CompilationUnit));
  }
}
