# Mango 🥭

A minimal, dark-mode, Android-first manga reader built in Flutter.

Mango isn't a manga catalog or scraper — it doesn't fetch listings from any site. You bring your own library as a JSON file (pasted in or hosted at a URL), and Mango stores it locally, tracks your reading progress, and lets you read online or download chapters for offline reading. It's a personal-use reader: clean, fast, and built around a single source of truth you control.

## What it does

- **Import your library** from a JSON document — paste it directly or point Mango at a URL.
- **Browse** your manga as a cover grid, split into Favorites and Library sections.
- **Track progress** automatically: which chapters you've read, and the exact page you stopped on mid-chapter. Resume picks up right where you left off.
- **Read** with a horizontal paged reader: right-to-left by default (configurable), pinch / double-tap zoom, swipe between pages, and swipe past the edges to move between chapters.
- **Download** chapters or whole series for offline reading, with a configurable, server-friendly download speed.
- **Favorite and reorder** the series you care about; anything you've started automatically floats to the top.
- **Favorite individual pages** and revisit them from a dedicated section on the series screen.
- **Save a page to your device gallery** straight from the reader.

## How to use it

1. **Add your library.** Tap the **+** button on the home screen. Either paste your JSON or enter a URL to a hosted JSON file, then import. Re-importing the same file later updates it in place (see *Updating* below).
2. **Open a series.** Tap a cover to see its chapters, how many you've read, and a **Continue / Start reading** button.
3. **Read.**
   - Swipe to turn pages. Paging is **right-to-left by default**; change the global default in Settings, or override it per series from the detail screen's ⋮ menu → "Reading direction…".
   - **Pinch** to zoom; **double-tap** to toggle between fit and 1.5× (centred on where you tapped). While zoomed in, dragging pans the image instead of turning the page.
   - Tap once to show the overlay (back button, page indicator, prev/next **page** buttons, and a ⋮ menu).
   - The reader's **⋮ menu** lets you favorite the current page, save it to your gallery, or download the current chapter.
   - At the **end of a chapter**, swipe past the last page to land on a "Next chapter" card. It won't switch automatically — swipe again to actually continue. The same applies going backwards (you'll land on the previous chapter's last page). This prevents an accidental over-swipe from jumping chapters.
4. **Favorites & sorting.** Tap the ⭐ on a cover (or in the detail screen) to favorite it. Use the reorder button in the top bar to drag favorites into your preferred order. Non-favorites you've started reading are automatically sorted to the top.
5. **Favorite pages.** Favorite a page from the reader's ⋮ menu; favorited pages appear in a "Favorite pages" strip at the top of that series' detail screen. Tap one to jump to it; long-press for a menu to open or remove it.
6. **Mark read/unread.** Long-press a chapter for options to mark it read, or mark it unread (which also clears its saved page position).

### Downloading for offline

- From a series' detail screen, use the overflow menu (**⋮**) for **Download chapters…**, **Cancel all downloads**, **Remove all downloads**, and **Download speed**. Long-press an individual chapter to download, cancel, or remove just that one.
- **Download chapters…** lets you pick a starting chapter — defaulting to the one right after your furthest-read chapter — and how many to download from there. Leave the start at chapter 1 and the count at its max to grab the whole series.
- Downloaded chapters read fully offline; the reader prefers local files over the network automatically.
- **Download speed** is configurable (also in **Settings**) and persists across restarts. It defaults to **1 file/second**, can go as fast as **2 files/second**, and as slow as **1 file every 5 seconds** — this exists to avoid hammering the server your images come from. Files are stored in the app's private storage (nothing lands in your gallery), so removing a download cleans them up completely.

## JSON format

The import document is a **JSON array of manga objects** (a single object is also accepted). Each manga has a stable `identifier`, display fields, and an ordered list of chapters; each chapter has an ordered list of page image URLs.

```json
[
  {
    "title": "Example manga",
    "identifier": "example-manga",
    "thumbnail": "https://example.com/example.webp",
    "chapters": [
      {
        "id": "1",
        "order": 1,
        "title": "The Day of Wonder",
        "pages": [
          "https://example.com/ex/ch1/01.jpg",
          "https://example.com/ex/ch1/02.jpg"
        ]
      },
      {
        "id": "2",
        "order": 2,
        "pages": [
          "https://example.com/ex/ch2/01.jpg"
        ]
      }
    ]
  }
]
```

### Fields

| Field | Where | Type | Notes |
|---|---|---|---|
| `title` | manga | string | Display name shown in the library and detail screen. |
| `identifier` | manga | string | **Stable unique key.** Drives new-vs-update on import — keep it constant for a series. |
| `thumbnail` | manga | string (URL) | Cover image. |
| `chapters` | manga | array | The chapters; order in the file doesn't matter (see `order`). |
| `id` | chapter | string | **Stable per-chapter key** within the manga. Used to match chapters on re-import. |
| `order` | chapter | integer | Sequence number; determines reading order and next/previous navigation. |
| `title` | chapter | string *(optional)* | Display name for the chapter. Falls back to `Chapter <id>` when omitted. |
| `pages` | chapter | array of strings (URLs) | Page images **in reading order**. |

Notes:

- Image URLs should be **HTTPS** (plain HTTP is blocked in release builds by default).
- `identifier` and chapter `id` are how Mango recognises things across imports — keep them stable so progress, favorites, and downloads survive updates.
- A sample document lives at [`reference.json`](reference.json) (also bundled at `assets/reference.json`).

### Updating an existing library

Re-import a document with the **same `identifier`** to update a series rather than duplicate it:

- `title`, `thumbnail`, and chapter metadata refresh.
- **New chapters** (new chapter `id`s) are added.
- Your **favorites, ordering, read state, and per-page progress are preserved.**
- Downloaded pages are kept where the page URL is unchanged.

So the typical workflow is: host/maintain one JSON file per source, and re-import it whenever new chapters drop.

## Building

Standard Flutter project. After cloning or after changing Drift tables / Freezed models, run code generation:

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run            # debug
flutter build apk --release   # release APK
```

Permissions (Android manifest): `INTERNET` for fetching/downloading, and a scoped `WRITE_EXTERNAL_STORAGE` (maxSdkVersion 29) so "Save page to gallery" works on Android 9 and below — Android 10+ saves via MediaStore with no permission. Downloaded chapters live in app-private storage and need no permission.

