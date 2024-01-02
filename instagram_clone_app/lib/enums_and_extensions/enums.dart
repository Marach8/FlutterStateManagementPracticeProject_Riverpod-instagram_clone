enum FileType{image, video}

enum DateSorting{newestOnTop, oldestOnTop}

enum PostSettings{
  allowLikes(
    title: 'Allow Likes',
    description: 'Likes Description',
    storageKey: 'Likes StorageKey'
  ),

  allowComments(
    title: 'Allow Comments',
    description: 'Comments Description',
    storageKey: 'Comments StorageKey'
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSettings({required this.title, required this.description, required this.storageKey});
}