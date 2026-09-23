# 한국어 UI

이 폴더의 프로젝트를 GameMaker에서 빌드한 뒤 **Settings → Preferences → Interface → Language → 한국어**를 선택합니다. 언어 설정은 즉시 저장됩니다. 저장된 언어 설정이 없는 한국어 운영체제에서는 한국어를 기본으로 사용합니다.

언어 번호는 영어 `0`, 중국어 간체 `1`, 한국어 `2`입니다. 기존 중국어 분기는 유지하고, 영어 분기의 고정 UI 문자열을 `localize_ko("English literal")`로 번역합니다. 알 수 없는 문구는 영어를 반환합니다. 사용자 입력, 기존 파일 경로, 소리 파일명, NBT 필드 및 내부 식별자에는 이 함수를 적용하지 않습니다.

포크의 기존 `main` 소스와 GameMaker 2022 LTS를 기준으로 이식했습니다. 한글은 포함된 Source Han Sans OTF를 런타임에 불러와 표시하며, 측정과 그리기에 같은 폰트를 사용합니다. 폰트는 크기와 굵기별로 캐시하고 종료 시 해제합니다. [GameMaker의 font_add 문서](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Fonts/font_add.htm)에 따라 파일 폰트의 크기는 픽셀 단위로 지정합니다. 라이선스는 `datafiles/Data/Fonts/LICENSE.SourceHanSans.txt`에 포함되어 있습니다.

번역 원본은 UTF-8 `ko_KR.tsv`입니다. 두 열을 탭으로 구분하며 `\n`, `\"`, `\\` 등은 GML 문자열의 이스케이프 표기를 사용합니다. 메뉴 구분자와 단축키 표기는 생성기가 보존합니다. 문구를 추가할 때 표시용 문자열에만 `localize_ko()`를 적용하고 다음 명령을 실행하세요.

```sh
python tools/localization/generate_korean.py
python tools/localization/validate_korean.py
```

검증은 번역 누락, 문자열 이스케이프, 메뉴 구조, 파일 필터, 내부 식별자, 프로젝트 등록, 설정 연결 및 포함된 Source Han Sans 글꼴의 한글 지원을 확인합니다. GameMaker 빌드와 화면 검사를 대신하지는 않습니다.

실행 확인 항목:

- 영어 → 한국어 → 중국어 → 영어 전환 시 메뉴와 기본 악기 이름이 갱신되는지 확인합니다.
- 종료 후 다시 실행했을 때 선택한 언어가 유지되는지 확인합니다.
- 각 테마에서 환경 설정, MIDI 가져오기, 악기 설정, 저장 및 내보내기 화면의 한글이 잘리지 않는지 확인합니다.
- 사용자 지정 악기 이름과 기존 곡의 템포 변경·소리 정지가 유지되는지 확인합니다.

이 변경에는 실행 파일이 포함되지 않습니다. GameMaker가 없는 환경에서는 실행 검증을 할 수 없습니다.
