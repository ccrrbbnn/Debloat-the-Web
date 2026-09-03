# Debloat the Web

Auto-updating collection of filter lists to strip AI upsells, nags, and other browsing annoyances.

## Subscribe

Add this URL as a custom filter list in uBlock Origin:

```
https://dtw.gev.au/list.txt
```

or, if you're not using the custom domain / it's not set up yet:

```
https://raw.githubusercontent.com/ccrrbbnn/Debloat-the-Web/main/list.txt
```

> Note: GitHub Pages always needs a filename on the end of the URL — it can't
> serve a raw text file at the bare domain root (`https://dtw.gev.au` with
> nothing after it will 404, since Pages looks for `index.html` there). If you
> want the truly bare domain to work, you'd need a redirect at the DNS/registrar
> level (e.g. Cloudflare) pointing `/` → `/list.txt`. `/list.txt` is as short
> as it gets with GitHub Pages alone.

## Layout

- `workspace/my-filters.txt` — your own custom rules, edited by hand.
- `workspace/external/sources.txt` — one blocklist URL per line; pulled in and merged on every build.
- `list.txt` — the generated, deduplicated output. This is what gets published and what people subscribe to. Don't edit by hand, it's overwritten on every build.
- `build.sh` — combines `workspace/my-filters.txt` + everything in `workspace/external/sources.txt` into `list.txt`.

## How it updates

`.github/workflows/update.yml` runs `build.sh` every 6 hours (and on any push
that touches `workspace/**` or `build.sh`), then commits `list.txt` back to
`main` if it changed.

## GitHub Pages setup (one-time)

1. Repo → **Settings → Pages**.
2. Source: **Deploy from a branch** → branch `main`, folder `/ (root)`.
3. Custom domain: enter `dtw.gev.au` (this repo already ships a `CNAME` file
   with that value, so GitHub should pick it up automatically) and enable
   **Enforce HTTPS** once the certificate is issued.
4. At your DNS provider, point `dtw.gev.au` at GitHub Pages — either a
   `CNAME` record to `ccrrbbnn.github.io`, or `A` records to GitHub's Pages
   IPs (see [GitHub's docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)).

Once DNS propagates, `https://dtw.gev.au/list.txt` is live.

## Local build

```
./build.sh
```

Writes/overwrites `list.txt` in the repo root.
