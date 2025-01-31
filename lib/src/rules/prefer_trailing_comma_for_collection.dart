import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:code_checker/rules.dart';

class PreferTrailingCommaForCollectionRule extends Rule {
  static const String ruleId = 'prefer-trailing-comma-for-collection';
  static const _documentationUrl = 'https://git.io/JJwmu';

  static const _failure = 'A trailing comma should end this line';
  static const _correctionComment = 'Add trailing comma';

  PreferTrailingCommaForCollectionRule({Map<String, Object> config = const {}})
      : super(
          id: ruleId,
          documentation: Uri.parse(_documentationUrl),
          severity: readSeverity(config, Severity.style),
        );

  @override
  Iterable<Issue> check(ProcessedFile file) {
    final visitor = _Visitor(
      file.parsedContent.lineInfo,
    );

    file.parsedContent.visitChildren(visitor);

    return visitor.nodes
        .map((node) => createIssue(
              this,
              nodeLocation(node, file),
              _failure,
              Replacement(
                comment: _correctionComment,
                replacement:
                    '${file.content.substring(node.offset, node.end)},',
              ),
            ))
        .toList(growable: false);
  }
}

class _Visitor extends GeneralizingAstVisitor<void> {
  final _nodes = <AstNode>[];
  final LineInfo _lineInfo;

  Iterable<AstNode> get nodes => _nodes;

  _Visitor(this._lineInfo);

  @override
  void visitListLiteral(ListLiteral node) {
    _visitNodeList(node.elements, node.leftBracket, node.rightBracket);
    super.visitListLiteral(node);
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    _visitNodeList(node.elements, node.leftBracket, node.rightBracket);
    super.visitSetOrMapLiteral(node);
  }

  void _visitNodeList(
    Iterable<AstNode> iterable,
    Token leftBracket,
    Token rightBracket,
  ) {
    if (iterable.isEmpty ||
        (_getLineNumber(leftBracket) == _getLineNumber(rightBracket))) {
      return;
    }

    final first = iterable.first;
    final last = iterable.last;

    if (last.endToken?.next?.type != TokenType.COMMA &&
        (_getLineNumber(leftBracket) != _getLineNumber(first) ||
            _getLineNumber(rightBracket) != _getLineNumber(last))) {
      _nodes.add(last);
    }
  }

  int _getLineNumber(SyntacticEntity entity) =>
      _lineInfo.getLocation(entity.offset).lineNumber;
}
