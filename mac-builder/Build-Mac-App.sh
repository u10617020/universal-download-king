#!/bin/bash
set -euo pipefail
cd -- "$(dirname -- "$0")"

printf '全能下載王｜Mac 本機 App 建置\n'

if ! command -v python3 >/dev/null 2>&1; then
  printf '找不到 Python。請先安裝 Python 3.11 以上（需包含 Tkinter）。\n'
  exit 1
fi

python3 - <<'PY'
import sys
if sys.version_info < (3, 11):
    raise SystemExit('需要 Python 3.11 以上。')
try:
    import tkinter
except ImportError:
    raise SystemExit('目前的 Python 沒有 Tkinter，請改用 python.org 的 Mac 安裝包。')
PY

BUILD_ENV="$HOME/Library/Application Support/UniversalDownloadKing/app-builder-v24.2"
python3 -m venv "$BUILD_ENV"
"$BUILD_ENV/bin/python" -m pip install --upgrade pip
"$BUILD_ENV/bin/python" -m pip install -r requirements.txt 'pyinstaller>=6.0,<7'

rm -rf build dist mac-icon.iconset UniversalDownloadKing.icns
mkdir -p mac-icon.iconset
for size in 16 32 128 256 512; do
  sips -z "$size" "$size" j-pixel-logo-orange-v2.png --out "mac-icon.iconset/icon_${size}x${size}.png" >/dev/null
  double=$((size * 2))
  sips -z "$double" "$double" j-pixel-logo-orange-v2.png --out "mac-icon.iconset/icon_${size}x${size}@2x.png" >/dev/null
done
iconutil -c icns mac-icon.iconset -o UniversalDownloadKing.icns

"$BUILD_ENV/bin/pyinstaller" --noconfirm --clean Mac-App.spec
codesign --force --deep --sign - 'dist/全能下載王.app'
codesign --verify --deep --strict --verbose=2 'dist/全能下載王.app'

printf '\n建置完成：%s/dist/全能下載王.app\n' "$PWD"
printf '這是本機私人使用版本，未經 Apple 公證，不適合轉傳到其他 Mac。\n'
if [[ "${CI:-}" != "true" ]]; then
  open dist
fi

