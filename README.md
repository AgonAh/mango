# Mango 🥭

A minimal, dark-mode, Android-first manga **and book** reader built in Flutter.

Mango isn't a catalog or scraper — it doesn't fetch listings from any site. You bring your own library: manga as a JSON document (pasted in, from a file, or hosted at a URL), and PDF/EPUB books from your device (or referenced by URL in that same JSON). Mango stores everything locally, tracks your reading position, and lets you read online or download for offline reading. It's a personal-use reader: clean, fast, and built around a single source of truth you control.

## What it does

- **Import your manga** from a JSON document — pick a file, paste it, or point Mango at a URL.
- **Add PDF & EPUB books** from your device (or via a URL in the JSON), stored right alongside your manga.
- **Browse** everything as one cover grid, split into Favorites and Library sections, with an All / Manga / Books filter and a PDF/EPUB badge on books.
- **Track progress** automatically: which chapters you've read, and the exact page you stopped on mid-chapter. Resume picks up right where you left off.
- **Read** with a horizontal paged reader: right-to-left by default (configurable), pinch / double-tap zoom, swipe between pages, and swipe past the edges to move between chapters.
- **Download** chapters or whole series for offline reading, with a configurable, server-friendly download speed.
- **Favorite and reorder** the series you care about; anything you've started automatically floats to the top.
- **Favorite individual pages** and browse through them from a dedicated section on the series screen.
- **Save a page to your device gallery** straight from the reader.
- **Read PDFs** in continuous-scroll (pinch-zoom) or paged mode, and **EPUBs** as free-flowing scroll with chapters and adjustable font size — both remember your position.
- **Export your library** (optionally with reading progress and favorite pages) to move to another device.

## How to use it

1. **Add to your library.** Tap the **+** button on the home screen and choose:
   - **Import manga (JSON)** — pick a `.json` file, paste JSON, or enter a URL. Re-importing the same document updates it in place (see *Updating* below).
   - **Add book (PDF / EPUB)** — pick a file from your device; Mango suggests a title/author/cover, which you can edit before saving.
2. **Open an item.** Tap a cover. A manga shows its chapters + a **Continue / Start reading** button; a book shows its metadata + a **Read / Continue** button (and edit/delete).
3. **Read.**
   - Swipe to turn pages. Paging is **right-to-left by default**; change the global default in Settings, or override it per series from the detail screen's ⋮ menu → "Reading direction…".
   - **Pinch** to zoom; **double-tap** to toggle between fit and 1.5× (centred on where you tapped). While zoomed in, dragging pans the image instead of turning the page.
   - Tap once to show the overlay (back button, page indicator, prev/next **page** buttons, and a ⋮ menu).
   - The reader's **⋮ menu** lets you favorite the current page, save it to your gallery, or download the current chapter.
   - At the **end of a chapter**, swipe past the last page to land on a "Next chapter" card. It won't switch automatically — swipe again to actually continue. The same applies going backwards (you'll land on the previous chapter's last page). This prevents an accidental over-swipe from jumping chapters.
4. **Favorites & sorting.** Tap the ⭐ on a cover (or in the detail screen) to favorite it. Use the reorder button in the top bar to drag favorites into your preferred order. Non-favorites you've started reading are automatically sorted to the top.
5. **Favorite pages.** Favorite a page from the reader's ⋮ menu; favorited pages appear in a "Favorite pages" strip at the top of that series' detail screen. Tap one to browse through your favorite pages (a book button jumps into that chapter); long-press for a menu to open it in its chapter or remove it.
6. **Mark read/unread.** Long-press a chapter for options to mark it read, or mark it unread (which also clears its saved page position).
7. **Move to another device.** Settings → "Export library" produces a JSON document of your whole library, with optional toggles for reading progress and favorite pages. Copy it or share it as a file, then import it on the other device. Manga and **URL-based books** are included; **locally-added books** (from a device file) are skipped, since their file can't move with the JSON — the export screen tells you how many were left out.

### Books (PDF / EPUB)

- Books live in the same library as manga (with a PDF/EPUB badge) and share favorites, sorting, and the All/Manga/Books filter.
- **PDF** opens in continuous scroll (pinch-zoom) or paged mode — chosen per book when you add it — and remembers your page.
- **EPUB** opens as one free-flowing scroll with a chapters button (⋮/book icon), A−/A+ font-size controls, and a dark theme; it remembers your position precisely (even across font changes).
- Files are copied into the app's private storage. Deleting a book removes its file too.

### Downloading for offline

- From a series' detail screen, use the overflow menu (**⋮**) for **Download chapters…**, **Cancel all downloads**, **Remove all downloads**, and **Download speed**. Long-press an individual chapter to download, cancel, or remove just that one.
- **Download chapters…** lets you pick a starting chapter — defaulting to the one right after your furthest-read chapter — and how many to download from there. Leave the start at chapter 1 and the count at its max to grab the whole series.
- Downloaded chapters read fully offline; the reader prefers local files over the network automatically.
- **Download speed** is configurable (also in **Settings**) and persists across restarts. It defaults to **1 file/second**, can go as fast as **2 files/second**, and as slow as **1 file every 5 seconds** — this exists to avoid hammering the server your images come from. Files are stored in the app's private storage (nothing lands in your gallery), so removing a download cleans them up completely.

## JSON format

The import document is a **JSON array of objects** (a single object is also accepted). An object is a **manga** by default (with an ordered list of chapters, each holding page image URLs), or a **book** when it has a `"type"` of `"pdf"` or `"epub"` (pointing at a file URL instead of chapters).

```json
[
  {
    "title": "Example manga",
    "identifier": "example-manga",
    "thumbnail": "https://example.com/example.webp",
    "progress": { "chapter": "2", "page": 5 },
    "favoritePages": [
      { "chapter": "1", "page": 12 }
    ],
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

A **book** object looks like this (no `chapters`; `type` + `url` make it a book):

```json
{
  "title": "Pride and Prejudice",
  "identifier": "pride-and-prejudice",
  "thumbnail": "https://example.com/pride-cover.jpg",
  "type": "epub",
  "url": "https://example.com/pride.epub",
  "author": "Jane Austen",
  "series": "Classics"
}
```

The book's file downloads on first read (then behaves like a locally added book); the cover comes from `thumbnail`.

### Fields

| Field | Where | Type | Notes |
|---|---|---|---|
| `title` | manga / book | string | Display name shown in the library and detail screen. |
| `type` | book | `"pdf"` \| `"epub"` *(optional)* | Marks the object as a book. Absent = manga. |
| `url` | book | string (URL) | The PDF/EPUB file; downloaded on first read. |
| `author` | book | string *(optional)* | Shown on the book's detail screen. |
| `series` | book | string *(optional)* | Series/tag label. |
| `identifier` | manga / book | string | **Stable unique key.** Drives new-vs-update on import — keep it constant. |
| `thumbnail` | manga / book | string (URL) | Cover image. |
| `progress` | manga | object *(optional)* | Resume marker: `{ "chapter": "<id>", "page": <1-based> }`. On import, restores the resume position and marks earlier chapters read. |
| `favoritePages` | manga | array *(optional)* | Favorited pages: `[{ "chapter": "<id>", "page": <1-based> }]`. |
| `chapters` | manga | array | The chapters; order in the file doesn't matter (see `order`). |
| `id` | chapter | string | **Stable per-chapter key** within the manga. Used to match chapters on re-import. |
| `order` | chapter | integer | Sequence number; determines reading order and next/previous navigation. |
| `title` | chapter | string *(optional)* | Display name for the chapter. Falls back to `Chapter <id>` when omitted. |
| `pages` | chapter | array of strings (URLs) | Page images **in reading order**. |

Notes:

- Image URLs should be **HTTPS** (plain HTTP is blocked in release builds by default).
- `identifier` and chapter `id` are how Mango recognises things across imports — keep them stable so progress, favorites, and downloads survive updates.
- `progress` and `favoritePages` are optional and primarily produced by **Export library** (Settings) for moving devices; `page` numbers are **1-based**. They're applied on import but never required.
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

