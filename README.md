# Film Log

A small browser tool for getting photos ready to post — automatic color correction, instant-film and margin frames, and batch export at Instagram-friendly sizes.

**Live:** https://ivyonearth.xyz/film/

Everything runs locally in the browser. Photos are never uploaded anywhere.

## What it does

**Color**
- Auto levels, white balance, exposure and vibrance, tuned for landscapes
- Presets: Natural, Clear, Vivid, Warm film, Cool, Original
- Strength slider plus fine-tune for exposure, contrast, saturation and warmth
- Per-photo override, and hold-to-compare with the original

**Frames**
- *Instant film*: real card proportions for Instax Mini (54 × 86 mm), Instax Square, Instax Wide and Polaroid 600, or a custom border.
  Paper texture, recessed print window, soft shading, optional handwritten note.
  Auto mode picks Mini / Square / Wide from each photo's orientation.
- *Margin*: the full photo, uncropped, centered on a 1:1, 4:5 or 3:4 canvas
- Border color: any color, eyedropper, the photo's own palette, or a blurred backdrop

**Export**
- Standard (1080 wide), high-res (1440 wide) or original resolution
- *Carousel format*: export a whole batch at one shared ratio (1:1, 4:5 or 3:4) so mixed portrait and landscape shots aren't cropped in a multi-photo post
- Keeps EXIF camera data, fixes orientation, optionally strips GPS
- Single JPG or a zip of the whole batch

## Run locally

It's a single static file:

```bash
open index.html
# or
python3 -m http.server 8000   # then visit http://localhost:8000
```

## Deploy

`deploy.sh` uploads `index.html` to the server and, the first time, adds a `/film` route to Caddy (backed up and validated before reload).

```bash
bash deploy.sh                 # defaults to root@138.199.208.197
```

## Credits

Instant-film proportions follow published Polaroid and Instax print dimensions.
Handwriting fonts: [Caveat](https://fonts.google.com/specimen/Caveat) and [Ma Shan Zheng](https://fonts.google.com/specimen/Ma+Shan+Zheng) via Google Fonts.
