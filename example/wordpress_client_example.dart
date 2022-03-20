// ignore_for_file: avoid_redundant_argument_values, omit_local_variable_types, avoid_print

import 'package:wordpress_client/authorization.dart';
import 'package:wordpress_client/requests.dart';
import 'package:wordpress_client/responses.dart';
import 'package:wordpress_client/wordpress_client.dart';

Future<void> main() async {
  WordpressClient client;

  // Simple Usage
  client = WordpressClient.initialize(
    'https://example.com/',
    'wp-json/wp/v2',
    bootstrapper: (bootstrapper) => bootstrapper
        .withDebugMode(true)
        .withDefaultAuthorization(
          UsefulJwtAuth(
            'username',
            'password',
            callback: WordpressCallback(
              unhandledExceptionCallback: (dynamic unhandledException) {
                print('Unhandled Exception: $unhandledException');
              },
              requestErrorCallback: (errorContainer) {
                print('Request Error: ${errorContainer.errorResponse}');
              },
              responseCallback: (dynamic response) {
                print('Response: $response');
              },
            ),
          ),
        )
        .build(),
  );

  WordpressResponse<List<User>?> userResponse = await client.users.list(
    WordpressRequest(
      requestData: ListUserRequest()
        ..page = 1
        ..perPage = 10
        ..order = Order.asc,
    ),
  );

  userResponse = await client.users.list(
    WordpressRequest(
      requestData: ListUserRequest()
        ..page = 1
        ..perPage = 10
        ..order = Order.asc,
    ),
  );

  print(userResponse.message);

  if (userResponse.isSuccess) {
    for (final user in userResponse.data!) {
      print(user.name);
    }
  }
}
