# 한국어 UI

기준 소스: [OpenNBS/NoteBlockStudio의 development](https://github.com/OpenNBS/NoteBlockStudio/tree/development), 커밋 `1b396a980945533d1e358db1e6be40f3b0172592` (3.12.0-beta.5, NBS 형식 6).
Windows 배포본은 GameMaker 2022.0.3.99 LTS VM 64비트로 빌드합니다. `main`의 3.11.0/32비트 빌드와 다릅니다.

이 폴더의 프로젝트를 GameMaker에서 빌드한 뒤 **Settings → Preferences → Interface → Language → 한국어**를 선택합니다. 언어 설정은 즉시 저장됩니다. 저장된 언어 설정이 없는 한국어 운영체제에서는 한국어를 기본으로 사용합니다.

언어 번호는 영어 `0`, 중국어 간체 `1`, 한국어 `2`입니다. 기존 중국어 분기는 유지하고, 영어 분기의 고정 UI 문자열을 `localize_ko("English literal")`로 번역합니다. 알 수 없는 문구는 영어를 반환합니다. 사용자 입력, 파일 경로, 소리 파일명, NBT 필드 및 특수 악기 식별자에는 이 함수를 적용하지 않습니다. `Tempo Changer`, `Sound Stopper`, `Show Save Popup`은 곡 파일과 재생 로직에서 쓰는 이름이므로 유지합니다.

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

Windows 실행 파일은 포크 저장소 Releases의 `Windows.zip`으로 배포합니다. 전체 압축을 해제하고 EXE를 실행하세요.

빌드 시 Python 3.8.10 **64비트**와 `poetry.lock`에 지정된 nbswave 0.4.0, numpy 1.24.4, pydub 0.25.1, pynbs 1.1.0을 사용합니다. Python 하위 폴더의 기존 문서에 있는 32비트 안내는 이 브랜치의 64비트 DLL과 맞지 않습니다. `package.py`를 실행한 뒤, 별도 Windows 빌드 사본의 IncludedFiles에서 Python/Lib 항목을 실제 생성 파일로 갱신하고 macOS 전용 python38_darwin_universal 항목을 제외하세요. 이 생성 파일 목록은 공용 프로젝트에 커밋하지 않습니다.
