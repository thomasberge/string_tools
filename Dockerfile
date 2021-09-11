FROM google/dart-runtime
COPY ./lib/string_tools.dart /app/bin/string_tools.dart
COPY ./test/test.dart /app/bin/server.dart


