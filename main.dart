import 'Controllers/AuthenticationController.dart';
import 'Controllers/FileController.dart';

void main() {
    FileController fileController = new FileController();
    AuthenticationController authorizationController = new AuthenticationController(fileController);
}