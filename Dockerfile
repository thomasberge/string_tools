FROM google/dart-runtime
COPY ./string_tools.dart /app/bin/string_tools.dart
COPY ./test/server.dart /app/bin/server.dart


