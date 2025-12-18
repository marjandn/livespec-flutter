import 'package:flutter/material.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/parameter_card.dart';
import '../../shared/widgets/parameter_category_header.dart';
import '../../shared/utils/parameter_utils.dart';

/// Widget for displaying parameters section
class ParametersSection extends StatelessWidget {
  final ParametersObjectEntity parameters;
  final int totalCount;

  const ParametersSection({
    super.key,
    required this.parameters,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Parameters',
      icon: Icons.tune,
      subtitle: '$totalCount parameter(s)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (parameters.path.isNotEmpty) ...[
            ParameterCategoryHeader(
              title: 'Path Parameters',
              color: ParameterUtils.getParameterLocationColor('path'),
            ),
            const SizedBox(height: 12),
            ...parameters.path.map((param) => ParameterCard(param: param)),
            const SizedBox(height: 16),
          ],
          if (parameters.query.isNotEmpty) ...[
            ParameterCategoryHeader(
              title: 'Query Parameters',
              color: ParameterUtils.getParameterLocationColor('query'),
            ),
            const SizedBox(height: 12),
            ...parameters.query.map((param) => ParameterCard(param: param)),
            const SizedBox(height: 16),
          ],
          if (parameters.header.isNotEmpty) ...[
            ParameterCategoryHeader(
              title: 'Header Parameters',
              color: ParameterUtils.getParameterLocationColor('header'),
            ),
            const SizedBox(height: 12),
            ...parameters.header.map((param) => ParameterCard(param: param)),
            const SizedBox(height: 16),
          ],
          if (parameters.cookie.isNotEmpty) ...[
            ParameterCategoryHeader(
              title: 'Cookie Parameters',
              color: ParameterUtils.getParameterLocationColor('cookie'),
            ),
            const SizedBox(height: 12),
            ...parameters.cookie.map((param) => ParameterCard(param: param)),
          ],
        ],
      ),
    );
  }
}

