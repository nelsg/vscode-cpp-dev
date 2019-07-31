#!/usr/bin/env python3
import json
import os
import sys
with open(os.path.join(sys.argv[1], 'build', 'compile_commands.json')) as f:
    db = json.load(f)

    def replace_command(str):
        str = str.replace('nvcc', 'clang++')
        str = str.replace('-x cu', '-x cuda')
        return str

    for entry in db:
        if 'command' in entry:
            entry['command'] = replace_command(entry['command'])
        if 'arguments' in entry:
            entry['arguments'] = [replace_command(arg) for arg in entry['arguments']]
            
    json.dump(db, sys.stdout)
