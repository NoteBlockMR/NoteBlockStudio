"""Offline localization checks. Does not replace building/running in GameMaker."""
import json
import re
import struct
import unittest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from generate_korean import ROOT, CALL, load_catalog, render, translate


def font_codepoints(path):
    """Read Unicode cmap format 4/12 from a bundled OpenType font."""
    data = path.read_bytes()
    u16 = lambda offset: struct.unpack_from('>H', data, offset)[0]
    u32 = lambda offset: struct.unpack_from('>I', data, offset)[0]
    table_count = u16(4)
    cmap = None
    for index in range(table_count):
        record = 12 + index * 16
        if data[record:record+4] == b'cmap':
            cmap = u32(record+8)
            break
    assert cmap is not None
    points = set()
    for index in range(u16(cmap+2)):
        record = cmap + 4 + index * 8
        platform, encoding = u16(record), u16(record+2)
        if platform != 0 and not (platform == 3 and encoding in (1, 10)):
            continue
        table = cmap + u32(record+4)
        form = u16(table)
        if form == 12:
            for group in range(u32(table+12)):
                start, end, glyph = struct.unpack_from('>III', data, table+16+group*12)
                points.update(range(start + (glyph == 0), end+1))
        elif form == 4:
            count = u16(table+6) // 2
            ends = table + 14
            starts = ends + count*2 + 2
            deltas = starts + count*2
            offsets = deltas + count*2
            for segment in range(count):
                start, end = u16(starts+segment*2), u16(ends+segment*2)
                delta, offset = u16(deltas+segment*2), u16(offsets+segment*2)
                for cp in range(start, end+1):
                    if offset:
                        gid = u16(offsets+segment*2+offset+(cp-start)*2)
                        if gid:
                            gid = (gid+delta) & 0xffff
                    else:
                        gid = (cp+delta) & 0xffff
                    if gid:
                        points.add(cp)
    return points


class KoreanLocalizationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.catalog = load_catalog()
        cls.sources = {p: p.read_text(encoding='utf-8-sig')
                       for directory in ('scripts', 'objects')
                       for p in (ROOT/directory).rglob('*.gml')}
        cls.used = {literal for p, text in cls.sources.items() if p.stem != 'localize_ko'
                    for literal in CALL.findall(text)}

    def test_generated_catalog_is_current(self):
        self.assertEqual((ROOT/'scripts/localize_ko/localize_ko.gml').read_text(encoding='utf-8'), render())

    def test_translations_are_valid_strings(self):
        for english in self.used:
            korean = translate(english, self.catalog)
            self.assertNotEqual(english, korean, english)
            for value in (english, korean):
                # The catalog uses JSON-compatible GML double-quoted escapes.
                self.assertIsInstance(json.loads('"'+value+'"'), str)

    def test_menu_structure_and_file_filters_unchanged(self):
        for english in self.used:
            korean = translate(english, self.catalog)
            en, ko = json.loads('"'+english+'"'), json.loads('"'+korean+'"')
            if '|' in en or '$' in en or '^!' in en:
                self.assertEqual(re.findall(r'\||\$|\^!|\\|/', en),
                                 re.findall(r'\||\$|\^!|\\|/', ko), english)
            self.assertEqual(re.findall(r'\*\.[a-zA-Z0-9]+', en),
                             re.findall(r'\*\.[a-zA-Z0-9]+', ko), english)

    def test_no_translation_in_serialization_calls(self):
        for path, source in self.sources.items():
            for line in source.splitlines():
                if re.search(r'\b(?:TAG_\w+|nbt_\w+|ini_\w+|buffer_write|file_text_write_string)\(', line):
                    self.assertNotIn('localize_ko(', line, str(path))

    def test_playback_and_visualizer_identifiers_are_not_translated(self):
        for path, source in self.sources.items():
            if path.stem == 'localize_ko':
                continue
            self.assertNotRegex(source, r'dat_vis_type\s*[=!]=?\s*localize_ko\(')
            self.assertNotRegex(source, r'(?:insname|\.name)\s*[=!]=?\s*localize_ko\("(?:Tempo Changer|Sound Stopper|Show Save Popup)"')
            self.assertNotRegex(source, r'new_instrument\(localize_ko\("(?:Tempo Changer|Sound Stopper|Show Save Popup)"')
            self.assertNotIn('localize_ko("Custom instrument #")', source)

    def test_language_selection_and_persistence(self):
        def script(name):
            return (ROOT/f'scripts/{name}/{name}.gml').read_text(encoding='utf-8')
        self.assertIn('check(language = 2) + "한국어"', script('draw_window_preferences'))
        self.assertIn('os_get_language() = "ko"', script('control_create'))
        language_case = script('menu_click').split('case "language": {', 1)[1].split('break', 2)[1]
        self.assertIn('language = sel', language_case)
        self.assertIn('localize_instrument_names()', language_case)
        self.assertIn('save_settings()', language_case)
        self.assertIn('"preferences", "language",', script('save_settings'))
        self.assertIn('string_byte_length(string)', script('draw_text_dynamic'))

    def test_hangul_font_used_for_measurement_and_drawing(self):
        for name in ('draw_text_dynamic', 'string_width_dynamic'):
            text = (ROOT/f'scripts/{name}/{name}.gml').read_text(encoding='utf-8')
            self.assertIn('draw_character_font(', text)
        project = (ROOT/'Minecraft Note Block Studio.yyp').read_text(encoding='utf-8')
        for name in ('draw_character_font', 'SourceHanSansSC-Normal.otf', 'SourceHanSansSC-Medium.otf', 'LICENSE.SourceHanSans.txt'):
            self.assertIn(name, project)

    def test_bundled_fonts_cover_korean_translation(self):
        text = ''.join(translate(english, self.catalog) for english in self.used) + '한국어'
        required = {ord(ch) for ch in text if '\uac00' <= ch <= '\ud7a3'}
        self.assertGreater(len(required), 300)
        for weight in ('Normal', 'Medium'):
            cmap = font_codepoints(ROOT/f'datafiles/Data/Fonts/SourceHanSansSC-{weight}.otf')
            missing = required - cmap
            self.assertFalse(missing, f'{weight}: {"".join(chr(cp) for cp in sorted(missing))}')

    def test_project_registers_translation_script(self):
        project = (ROOT/'Minecraft Note Block Studio.yyp').read_text(encoding='utf-8')
        project = json.loads(re.sub(r',\s*([}\]])', r'\1', project))
        entries = [r['id'] for r in project['resources'] if r['id']['name'] == 'localize_ko']
        self.assertEqual(len(entries), 1)
        self.assertTrue((ROOT/entries[0]['path']).is_file())


if __name__ == '__main__':
    unittest.main(verbosity=2)
