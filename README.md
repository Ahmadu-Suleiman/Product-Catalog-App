# Product Catalog App

A product catalog application that allows users to perform various CRUD operations on the products 
on the platform. This project is part of a **Technical Assessment**. 

## How to run this project
1. Clone this repo to your computer
2. Ensure that you have an emulator or a physical device connected for debugging
3. Open a terminal in the project's directory
4. Run `flutter pub get` in the terminal to download the required dependencies
5. Run `flutter run` to run the app on your device or emulator

## Notes
- This project follows a simple MVC-S (Model View Controller - Services), this allows a clear
modularization of it's components.
- Firebase firestore is used to store the project entities while Firebase storage is used for
storing media files associated with such entities.
- Streambuilders are used to provide a simple state management architecture in order to provide 
immediate changes made to the database.
- Both SOLID and DRY principles are adhered to, most noticeably in widget modularization.