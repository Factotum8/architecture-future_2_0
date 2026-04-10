# AOE Tech Radar — «Будущее 2.0»

Готовый проект для генератора [AOE Technology Radar](https://github.com/AOEpeople/aoe_technology_radar) v4: **`config.json`**, **`about.md`**, **`public/logo.svg`**, все блипы в **`radar/2026-04-05/*.md`** (22 файла), синхронно с `../tech-radar.json`.

## Запуск

Требуется **Node.js** (LTS).

```bash
cd Task5/aoe-tech-radar
npm install
npm run serve
```

Откройте в браузере: **http://localhost:3000/techradar** (см. `basePath` в `config.json`).

Статическая сборка:

```bash
npm run build
```

Сайт появится в каталоге **`build/`** — его можно разместить на любом веб-хостинге.

## Структура

| Путь | Назначение |
|------|------------|
| `config.json` | Квадранты, кольца (Adopt / Trial / Assess / Hold), `basePath`, переключатели UI |
| `about.md` | Текст страницы «О радаре» |
| `public/logo.svg` | Логотип в шапке |
| `radar/2026-04-05/*.md` | Блипы: front-matter (`title`, `ring`, `quadrant`, `tags`) + описание |

При добавлении нового релиза создайте папку `radar/YYYY-MM-DD/` и перенесите/добавьте файлы блипов (см. документацию AOE).

## Кольца на диаграмме (`rings[].radius`)

В AOE **`radius` — не «толщина» кольца**, а **положение границы относительно центра** (0…1): внутреннее кольцо — меньшее значение, внешнее — большее. Если задать всем кольцам одно и то же число (например `0.24`), на картинке будет **одна** окружность. В `config.json` используются возрастающие значения по образцу `config.default.json` из пакета: **0.5 → 0.69 → 0.85 → 1**.

## Примечание

В репозитории в `public/` уже есть `favicon.ico` (копия из пакета AOE).
