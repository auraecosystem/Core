# Compile with gcc
gcc -o websocket-ping websocket-ping.c -lcurl

# Run against a WebSocket echo server
./websocket-ping wss://echo.websocket.events
