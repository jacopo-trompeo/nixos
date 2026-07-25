#!/usr/bin/env python3
import os
import yaml

BD = os.path.expanduser("~/.local/share/bottles/bottles/Visual-Novels")
LIB = os.path.expanduser("~/.local/share/bottles/library.yml")

d = yaml.safe_load(open(BD + "/bottle.yml"))
progs = d.get("External_Programs") or {}

cover = {}
try:
    lib = yaml.safe_load(open(LIB)) or {}
    for e in lib.values():
        if not isinstance(e, dict):
            continue
        b = e.get("bottle") or {}
        if b.get("path") != "Visual-Novels" and b.get("name") != "Visual Novels":
            continue
        t = e.get("thumbnail") or ""
        pid = e.get("id")
        if pid and t.startswith("grid:"):
            p = os.path.join(BD, "grids", t[5:])
            if os.path.exists(p):
                cover[pid] = p
except Exception:
    pass

for p in progs.values():
    n = (p.get("name") or "").strip()
    if not n or n == "Textractor":
        continue
    print(n + "\t" + cover.get(p.get("id"), ""))
