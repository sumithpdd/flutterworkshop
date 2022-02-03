import 'package:foocafe_flutter_firebase_chat/models/app_user.dart';
import 'package:foocafe_flutter_firebase_chat/models/message.dart';

// YOU - current AppUser
final AppUser currentAppUser = AppUser(
  id: '0',
  name: 'Current AppUser',
  profileImageUrl: 'assets/images/greg.jpg',
);

// AppUserS
final AppUser sumith = AppUser(
  id: '1',
  name: 'Sumith',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);
final AppUser martin = AppUser(
  id: '2',
  name: 'martin',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);
final AppUser laura = AppUser(
  id: '3',
  name: 'laura',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);
final AppUser bilal = AppUser(
  id: '4',
  name: 'bilal',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);
final AppUser sam = AppUser(
  id: '5',
  name: 'Sam',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);
final AppUser sophia = AppUser(
  id: '6',
  name: 'Sophia',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);
final AppUser steven = AppUser(
  id: '7',
  name: 'Steven',
  profileImageUrl: 'assets/images/user_placeholder.jpg',
);

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    senderId: 'sumith',
    timestamp: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    senderId: 'laura',
    timestamp: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    senderId: 'martin',
    timestamp: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    senderId: 'sophia',
    timestamp: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    senderId: 'bilal',
    timestamp: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    senderId: 'sam',
    timestamp: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    senderId: 'bilal',
    timestamp: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    senderId: 'martin',
    timestamp: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    senderId: currentAppUser.id,
    timestamp: '4:30 PM',
    text: 'Just walked my dog. She was super duper cute. The best puppy!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    senderId: 'martin',
    timestamp: '3:45 PM',
    text: 'How\'s the doggie?',
    isLiked: false,
    unread: true,
  ),
  Message(
    senderId: 'martin',
    timestamp: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    senderId: currentAppUser.id,
    timestamp: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    senderId: 'martin',
    timestamp: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
