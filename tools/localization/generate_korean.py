"""Regenerate the Korean lookup from its TSV and the fixed UI call sites.

Run with Python 3 from any directory. This does not modify UI call sites.
TSV fields contain GML string-literal contents, including escaped newlines.
"""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
CATALOG = Path(__file__).with_name('ko_KR.tsv')
CALL = re.compile(r'localize_ko\("((?:[^"\\]|\\.)*)"\)')


def load_catalog():
    result = {}
    for line in CATALOG.read_text(encoding='utf-8').splitlines():
        if not line or line.startswith('#'):
            continue
        english, korean = line.split('\t', 1)
        if english in result:
            raise ValueError(f'Duplicate translation: {english}')
        result[english] = korean
    return result


def translate(value, catalog):
    if value in catalog:
        return catalog[value]
    stripped = value.strip()
    if stripped in catalog:
        return value[:len(value)-len(value.lstrip())] + catalog[stripped] + value[len(value.rstrip()):]
    if stripped.endswith('...') and stripped[:-3] in catalog:
        return value.replace(stripped, catalog[stripped[:-3]] + '...')
    if '|' in value or '$' in value or value.startswith('^!'):
        return ''.join(translate(p, catalog) if p not in ('|', '$', '^!') else p
                       for p in re.split(r'(\||\$|\^!)', value))
    return value


def render():
    catalog = load_catalog()
    used = set()
    for directory in ('scripts', 'objects'):
        for path in (ROOT / directory).rglob('*.gml'):
            if path.stem != 'localize_ko':
                used.update(CALL.findall(path.read_text(encoding='utf-8-sig')))
    lines = []
    for english in sorted(used):
        korean = translate(english, catalog)
        if korean == english:
            raise ValueError(f'Missing Korean translation: {english}')
        lines.append(f'        variable_struct_set(translations, "{english}", "{korean}");\n')
    return '''/// @description Translate a fixed UI literal; never pass user text or file data here.
// Generated from tools/localization/ko_KR.tsv by generate_korean.py.
function localize_ko(text) {
    if (!instance_exists(obj_controller)) return text;
    if (!variable_instance_exists(obj_controller, "language")) return text;
    if (obj_controller.language != 2) return text;

    static translations = undefined;
    if (is_undefined(translations)) {
        translations = {};
''' + ''.join(lines) + '''    }
    if (variable_struct_exists(translations, text)) return variable_struct_get(translations, text);
    return text;
}
'''


if __name__ == '__main__':
    output = ROOT / 'scripts/localize_ko/localize_ko.gml'
    output.write_text(render(), encoding='utf-8', newline='\n')
    print(f'Generated {output.name}')
