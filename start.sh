#!/usr/bin/env bash

set -o pipefail;
set -o errexit;
set -o errtrace;
set -o nounset;

_main_src_dir="$(dirname "$(readlink -f "$0")")";
_jdk_dir="$_main_src_dir/jdk";
_jdk_link='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jdk_x64_linux_hotspot_16.0.1_9.tar.gz';
_paper_jar="$_main_src_dir/paper.jar";
_ngrok_bin="$_main_src_dir/ngrok.bin";
_cloudflared_bin="$_main_src_dir/cloudflared";
_paper_jar_link="https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/783/downloads/paper-1.16.5-783.jar"
_arg_mem="${2:-"3G"}";

if test ! -e "$_paper_jar"; then
	echo '------- Downloading paper server'
	curl -L "$_paper_jar_link" -o "$_paper_jar";
fi


if test ! -e "$_jdk_dir"; then
	echo '------- Downloading JDK'
	mkdir -p "$_jdk_dir";
	curl -L "$_jdk_link" | tar --strip-components=1 -C "$_jdk_dir" -xpzf -;
fi


# if test ! -e "$_ngrok_bin"; then
#         _ngrok_dw_link="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip";
#         curl -L "$_ngrok_dw_link" -o "$_main_src_dir/ngrok.zip";
#         unzip -p "$_main_src_dir/ngrok.zip" ngrok > "$_ngrok_bin";
# 	rm "$_main_src_dir/ngrok.zip";
# fi
if test ! -e "$_cloudflared_bin"; then {
	echo '------- Downloading Cloudflared';
	_cloudflared_dw_link="https://github.com/cloudflare/cloudflared/releases/download/2021.8.2/cloudflared-linux-arm64";
	curl -L "$_cloudflared_dw_link" -o "$_cloudflared_bin";
} fi

# chmod +x "$_ngrok_bin";
# "$_ngrok_bin" authtoken "${1}";
# "$_ngrok_bin" tcp --log "stdout" 25565 > "$_main_src_dir/ngrok.log" 2>&1 &

# while true; do {
# 	if _fetch="$(grep 'url=.*ngrok\.io.*' "$_main_src_dir/ngrok.log")"; then {
# 		echo -e "\n-------------------------------------------------"
# 		echo "+++ Server address for sharing: $(awk -F 'url=tcp://' '{print $2}' <<<"$_fetch")";
# 		echo -e "-------------------------------------------------\n"
# 		break;
# 	} else {
# 		sleep 1;
# 	} fi
# } done
pkill -9 cloudflared || true;
chmod +x "$_cloudflared_bin";
"$_cloudflared_bin" tunnel --url tcp://127.0.0.1:25565 > "$_main_src_dir/cloudflared.log" 2>&1 &
echo '------- Fetching adress for sharing....'
while true; do {
	if _fetch="$(grep -o -m1 'https://.*.trycloudflare.com' "$_main_src_dir/ngrok.log")"; then {
		echo -e "\n-------------------------------------------------"
		echo "+++ Server address for sharing: $(awk -F 'url=tcp://' '{print $2}' <<<"$_fetch")";
		echo -e "-------------------------------------------------\n"
		break;
	} else {
		sleep 1;
	} fi
} done

export PATH="$_jdk_dir/bin:$PATH";
java -Xms${_arg_mem} -Xmx${_arg_mem} -jar "$_paper_jar" --nogui;

