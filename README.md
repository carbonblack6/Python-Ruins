# Ruins Python

A six-level HTML5 snake adventure set in overgrown ruins. The game is fully static and needs no build step, package install, or server-side runtime.

## Play locally

Open `index.html` in a modern desktop or mobile browser. Use the arrow keys or WASD on desktop and the directional controls on touch devices. Press Space to pause and R to retry.

## Publish with GitHub Pages

1. Create a GitHub repository and upload the contents of this directory to its root.
2. Open the repository's **Settings > Pages**.
3. Under **Build and deployment**, choose **Deploy from a branch**.
4. Select the `main` branch and `/ (root)`, then save.
5. Wait for the Pages deployment to complete.

The shareable URL will normally be:

```text
https://YOUR-USERNAME.github.io/YOUR-REPOSITORY/
```

If the repository is named `YOUR-USERNAME.github.io`, the URL is simply `https://YOUR-USERNAME.github.io/`.

## Saved progress

Player names, lifetime mice, unlocked levels, scores, and deaths per level are stored with browser `localStorage`. Progress persists for the same browser and GitHub Pages URL, but it is not synchronized between devices or players.

## Developer preview

Append `?level=6&dev=1` to open the bonus level and unlock every replay tile for the current session. Append `&preview=1` for an unobscured stationary board preview.
