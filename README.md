# RCMC Presentation & Canvas MCP Server
**Royal Commission for Makkah City and Holy Sites (الهيئة الملكية لمدينة مكة المكرمة والمشاعر المقدسة)**

This MCP server enables **Gemini Enterprise / Antigravity / MCP Clients** to generate 100% brand-compliant Arabic (`AR` - RTL) and English (`EN` - LTR) presentations directly from the official RCMC PowerPoint Master Templates, custom `Suisse Intl` fonts, and internal Makkah & Holy Sites asset bank.

---

## ✨ What We Did with Your Files

1. **Cleaned & Organized Directory Structure**:
   - Renamed `PowerPoint Arabic.pptx` ➔ [`assets/templates/RCMC_Template_AR.pptx`](file:///c:/Users/Amzaj/Documents/Antigravity/Presentation%20MCP/assets/templates/RCMC_Template_AR.pptx)
   - Renamed `Powerpoint English.pptx` ➔ [`assets/templates/RCMC_Template_EN.pptx`](file:///c:/Users/Amzaj/Documents/Antigravity/Presentation%20MCP/assets/templates/RCMC_Template_EN.pptx)
   - Renamed all 8 `Suisse Intl` font weights ➔ [`assets/fonts/SuisseIntl-*.otf`](file:///c:/Users/Amzaj/Documents/Antigravity/Presentation%20MCP/assets/fonts)
2. **Optimized 450 MB Master Templates Down to ~3.5 MB per Generated Deck**:
   - Your original `.pptx` templates contained uncompressed 40–60 MB RAW photography (~455 MB total), plus 30 gallery slides at the end of the deck.
   - We created 1080p HD optimized masters (`RCMC_Master_AR_Optimized.pptx` & `RCMC_Master_EN_Optimized.pptx`) and built an automatic **Media Pruner** in [`src/build_pptx.ps1`](file:///c:/Users/Amzaj/Documents/Antigravity/Presentation%20MCP/src/build_pptx.ps1) so every generated `.pptx` only bundles the exact photos used in that presentation (**~3.4 MB** instead of **457 MB**!).
3. **Cataloged All 25 Makkah/Holy Sites Photos & 18 Official RCMC Icons**:
   - Extracted and tagged all 25 internal photographs (`photo_01` to `photo_25`: Kaaba, Grand Mosque, Mount Arafat, Mina Tents, Clock Tower, Makkah Bus Fleet, Ring Roads, Ain Zubaydah Historic Aqueduct, Islamic Arches, Green Boulevards) and 18 official SVG icons (`icon_01` to `icon_18`) in [`src/catalog.json`](file:///c:/Users/Amzaj/Documents/Antigravity/Presentation%20MCP/src/catalog.json).
4. **Dual-Output Engine (Native `.pptx` + Interactive Gemini Canvas HTML5)**:
   - **Native PowerPoint Output**: Clones the exact XML slide layouts from your RCMC AR/EN templates, injects text into the exact shape IDs while preserving RTL/LTR direction, brand colors (`#016A40`, `#005242`, `#C2AB78`), and embedded `Suisse Intl` fonts.
   - **Native-Style Canvas View**: Simultaneously builds a self-contained interactive HTML5 Canvas slide deck (`ui://rcmc/canvas/<id>`) with embedded base64 `Suisse Intl` fonts, RCMC arch patterns, slide filmstrip navigator, keyboard controls, fullscreen mode, PDF print, and a one-click **Download Native `.PPTX`** button.

---

## 🛠️ Exposed MCP Tools

1. `list_rcmc_layouts` — Lists all 19 official RCMC slide layouts (Covers, Section Dividers, Split Photo Narrative, 3 Pillars with Icons, 3 Cards + Photo, 4-Item Numbered Agenda, 3 Feature Rows, Executive Highlight Banner, 3 KPI Metrics + Chart, 3-Horizon Timeline, 4-Quadrant Infographic, 4-Stage Process Roadmap, Data Table, and Closing Slide).
2. `search_rcmc_media_library` — Searches the 25 official Makkah/Haram/Mashair photos and 18 RCMC icons by keyword (`kaaba`, `arafat`, `bus`, `ain zubaydah`, `roads`, `kpi`, etc.).
3. `generate_rcmc_presentation` — Generates both the `.pptx` file and the interactive HTML5 Canvas deck in `output/`.
4. `update_rcmc_slide` — Replaces, inserts, or deletes any slide in an existing presentation and refreshes both the `.pptx` and Canvas view.

---

## 🚀 How to Connect to Gemini / MCP Client

Use the configuration in [`mcp_config.json`](file:///c:/Users/Amzaj/Documents/Antigravity/Presentation%20MCP/mcp_config.json):

```json
{
  "mcpServers": {
    "rcmc-presentations": {
      "command": "C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\MSBuild\\Microsoft\\VisualStudio\\NodeJs\\node.exe",
      "args": [
        "C:\\Users\\Amzaj\\Documents\\Antigravity\\Presentation MCP\\src\\mcp_server.js"
      ]
    }
  }
}
```
