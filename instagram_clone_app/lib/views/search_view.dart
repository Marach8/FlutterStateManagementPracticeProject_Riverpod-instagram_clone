import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/views/search_result_view.dart';

class SearchView extends HookConsumerWidget {

  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');
    useEffect((){
      controller.addListener(() {
        searchTerm.value = controller.text;
      });
      return (){};
    }, [controller]);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: 'Enter your search term here',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    dismissKeyboard();
                  },
                )
              ),
            ),
          ),
        ),
        SearchResultView(searchTerm: searchTerm.value)
      ]
    );
  }
}