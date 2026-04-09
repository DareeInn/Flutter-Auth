🔐 Flutter Firebase Auth App

This project is a Flutter application that implements Firebase Authentication using email and password. It allows users to register, log in, view their profile, update their password, and log out.

🚀 Features
User Registration (Email & Password)
User Login
User Logout
Profile Screen with Current User Email
Change Password Functionality
Navigation between Authentication and Profile screens
Custom UI styling with background images
📱 Screens
Authentication Screen
Email & Password input
Sign in / Create account
Styled UI with custom background
Profile Screen
Displays current user email
Change password field
Logout button
Different background image from auth screen
🛠️ Tech Stack
Flutter
Dart
Firebase Authentication
Firebase Core
🔧 Setup Instructions
Clone the repository:
git clone https://github.com/DareeInn/Flutter-Auth.git
cd Flutter-Auth
Install dependencies:
flutter pub get
Configure Firebase:
Add your google-services.json file to:
android/app/
Run the app:
flutter run
🧪 Testing

The following flows were tested successfully:

Register a new user
Login
Logout
Login again
Change password
Logout
Login with new password

🐛 Challenges & Fixes
Fixed Firebase configuration issues (package name & JSON placement)
Resolved Flutter syntax errors in UI widgets
Fixed asset path issues in pubspec.yaml
Ensured proper navigation after login/logout
📈 Future Improvements
Add Firebase Auth state listener for automatic navigation
Improve error handling and validation messages
Add form validation for better UX
Separate UI and business logic for scalability
🔗 Repository

GitHub Repo:
https://github.com/DareeInn/Flutter-Auth

👤 Author

Darin Ward

✅ Submission Summary

This project demonstrates a complete Firebase Authentication flow in Flutter, including user registration, login, logout, profile management, and password updates. All required features were implemented and tested successfully.


Final Development Note (IMPORTANT ADDITION)

Before submission, I made a final refactor commit where I split main.dart into multiple files:

app.dart
authentication_screen.dart
profile_screen.dart

This improved code readability, modularity, and maintainability. It also demonstrates version control progress and proper project structure in my GitHub repository.
