# -*- mode: python ; coding: utf-8 -*-
import os
import shutil
from PyInstaller.utils.hooks import collect_all

datas = [
    ('j-pixel-logo-orange-v2.png', '.'),
    ('download-complete.wav', '.'),
    ('pixel-font.ttf', '.'),
    ('instagram-qr.png', '.'),
]
binaries = []
hiddenimports = []
for package in ('yt_dlp', 'imageio_ffmpeg', 'yt_dlp_ejs', 'curl_cffi', 'certifi', 'brotli', 'mutagen'):
    collected = collect_all(package)
    datas += collected[0]
    binaries += collected[1]
    hiddenimports += collected[2]

deno = shutil.which('deno')
if deno:
    binaries.append((deno, '.'))

a = Analysis(
    ['app.py'],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
)
pyz = PYZ(a.pure)
exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='全能下載王',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    console=False,
    icon='UniversalDownloadKing.icns',
)
coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=False,
    name='全能下載王',
)
app = BUNDLE(
    coll,
    name='全能下載王.app',
    icon='UniversalDownloadKing.icns',
    bundle_identifier='tw.junjiann.universal-download-king',
    info_plist={
        'CFBundleDisplayName': '全能下載王',
        'CFBundleShortVersionString': '24.2',
        'CFBundleVersion': '24.2',
        'NSHighResolutionCapable': True,
    },
)

