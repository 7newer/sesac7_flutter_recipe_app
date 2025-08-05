// presentation/component/bottomsheet/filter_search_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/presentation/component/bottomsheet/filter_search_bottom_sheet_state.dart';

// 이 클래스가 바텀 시트의 '내용물'이 됩니다.
class FilterSearchBottomSheet extends StatefulWidget {
  final FilterSearchBottomSheetState state;

  const FilterSearchBottomSheet({super.key, required this.state});

  @override
  State<FilterSearchBottomSheet> createState() =>
      _FilterSearchBottomSheetContentState();
}

class _FilterSearchBottomSheetContentState
    extends State<FilterSearchBottomSheet> {
  late FilterSearchBottomSheetState state;

  @override
  void initState() {
    super.initState();
    state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // 바텀 시트 높이 조절 (화면 높이의 80% 정도)
        //height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white, // 배경색 흰색
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ), // 상단 모서리 둥글게
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 내용을 왼쪽으로 정렬
          mainAxisSize: MainAxisSize.min, // 최소 크기로 설정
          children: [
            // 1. Filter Search 제목
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Filter Search',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // 2. Time 섹션
            _buildSectionTitle('Time'),
            _buildTimeFilterButtons(),
            const SizedBox(height: 20),

            // 3. Rate 섹션
            _buildSectionTitle('Rate'),
            _buildRateFilterButtons(),
            const SizedBox(height: 20),

            // 4. Category 섹션
            _buildSectionTitle('Category'),
            _buildCategoryFilterButtons(),
            const SizedBox(height: 30),

            // 5. Filter 버튼 (Flexible 또는 Expanded로 감싸면 더 유연하게 배치 가능)
            // 여기서는 BottomSheet의 하단에 고정하는 방법 대신 Column의 마지막 요소로 넣었습니다.
            _buildFilterButton(),
          ],
        ),
      ),
    );
  }

  // 각 섹션 제목을 위한 위젯
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  // 각 필터 버튼을 만드는 공통 함수 (디자인 맞춤)
  Widget _buildFilterButtonWidget({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
    IconData? icon, // 아이콘 추가
  }) {
    // 이미지에 보이는 버튼 스타일을 최대한 비슷하게 구현
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Material(
        // 터치 피드백을 위해 Material 위젯 사용
        color: Colors.transparent, // Material의 기본 색상 제거
        child: InkWell(
          // 터치 피드백을 위해 InkWell 사용
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF2196F3).withOpacity(0.8)
                  : const Color(0xFFE0F2F1), // 이미지 색상에 맞게 조정
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : Colors.grey.shade300, // 선택 안되면 회색 테두리
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // 내용물 크기만큼만 차지
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    // 선택 여부에 따라 텍스트 색상 변경
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                if (icon != null) ...[
                  // 아이콘이 있으면 아이콘 추가
                  const SizedBox(width: 4),
                  Icon(
                    icon,
                    size: 16,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Time 필터 버튼들 ---
  Widget _buildTimeFilterButtons() {
    final List<String> timeOptions = ['All', 'Newest', 'Oldest', 'Popularity'];
    return Row(
      children: timeOptions.map((option) {
        return _buildFilterButtonWidget(
          text: option,
          isSelected: _selectedTime == option,
          onPressed: () {
            setState(() {
              _selectedTime = option;
            });
          },
        );
      }).toList(),
    );
  }

  // --- Rate 필터 버튼들 ---
  Widget _buildRateFilterButtons() {
    final List<int> rateOptions = [5, 4, 3, 2, 1];
    return Row(
      children: rateOptions.map((rate) {
        return _buildFilterButtonWidget(
          text: rate.toString(),
          isSelected: _selectedRate == rate,
          onPressed: () {
            setState(() {
              _selectedRate = rate;
            });
          },
          icon: Icons.star, // 별 아이콘 추가
        );
      }).toList(),
    );
  }

  // --- Category 필터 버튼들 ---
  Widget _buildCategoryFilterButtons() {
    final List<String> categoryOptions = [
      'All',
      'Cereal',
      'Vegetables',
      'Dinner',
      'Chinese',
      'Local Dish',
      'Fruit',
      'Breakfast',
      'Spanish',
      'Chinese',
      'Lunch',
    ];
    return Wrap(
      // Wrap 위젯을 사용하여 자동 줄바꿈
      spacing: 8.0, // 가로 간격
      runSpacing: 8.0, // 세로 간격
      children: categoryOptions.map((category) {
        return _buildFilterButtonWidget(
          text: category,
          isSelected: _selectedCategories.contains(category),
          // List에 포함되어 있는지 확인
          onPressed: () {
            setState(() {
              if (category == 'All') {
                // 'All'을 선택하면 다른 모든 선택 해제
                _selectedCategories = ['All'];
              } else if (_selectedCategories.contains('All') &&
                  category != 'All') {
                // 'All'이 선택된 상태에서 다른 것을 선택하면 'All' 해제
                _selectedCategories = [category];
              } else if (_selectedCategories.contains(category)) {
                _selectedCategories.remove(category); // 이미 선택되어 있으면 해제
                if (_selectedCategories.isEmpty) {
                  // 아무것도 선택 안되면 'All' 선택
                  _selectedCategories.add('All');
                }
              } else {
                _selectedCategories.add(category); // 선택
              }
            });
          },
          icon: category == 'Dinner' ? Icons.star : null, // 'Dinner'에만 별 아이콘
        );
      }).toList(),
    );
  }

  // --- 하단 Filter 버튼 ---
  Widget _buildFilterButton() {
    return SizedBox(
      // 가로 전체를 차지하도록
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: 선택된 필터 값을 SearchRecipesViewModel에 전달하는 로직 추가
          print('Selected Time: $_selectedTime');
          print('Selected Rate: $_selectedRate');
          print('Selected Categories: $_selectedCategories');

          // 바텀 시트 닫기
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3).withOpacity(0.8),
          // 버튼 배경색
          foregroundColor: Colors.white,
          // 텍스트 색상
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 버튼 모서리 둥글게
          ),
          elevation: 5, // 그림자
        ),
        child: const Text(
          'Filter',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
