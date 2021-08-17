#!/bin/bash

# Download go_client.wasm if not already downloaded
if [ ! -f `pwd`/tools/cache/go_client.wasm ]
then
	echo "[DEBUG]: Downloading go_client.wasm"
	wget https://mazean.com/go_client.wasm -O `pwd`/tools/cache/go_client.wasm.gz

	# Decompress go_client.wasm
	echo "[DEBUG]: Decompressing go_client.wasm"
	gzip -d -f `pwd`/tools/cache/go_client.wasm.gz
fi

# Convert go_client.wasm to from .wasm to .wat
echo "[DEBUG]: Converting go_client.wasm to from .wasm to .wat"
$HOME/wabt/bin/wasm2wat `pwd`/tools/cache/go_client.wasm -o `pwd`/tools/cache/go_client.wat

# Decompile the .wat file
echo "[DEBUG]: Decompiling go_client.wasm"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/wasmdec
$HOME/wasmdec/wasmdec -d -o `pwd`/tools/cache/go_client.c `pwd`/tools/cache/go_client.wasm