#!/usr/bin/env python3
"""Update the wallpaperPath in DMS session.json."""

import json
import sys

if len(sys.argv) != 3:
    print(f"Usage: {sys.argv[0]} <session.json> <wallpaper-path>")
    sys.exit(1)

session_file, wallpaper = sys.argv[1], sys.argv[2]

with open(session_file) as f:
    data = json.load(f)

data["wallpaperPath"] = wallpaper

with open(session_file, "w") as f:
    json.dump(data, f, indent=2)
