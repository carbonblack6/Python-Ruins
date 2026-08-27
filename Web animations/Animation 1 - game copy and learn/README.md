# Ruins Python

Static HTML5 game ready for GitHub Pages. No build step or server-side runtime is required.

## GitHub Pages

1. Push this directory to a GitHub repository.
2. Open **Settings > Pages**.
3. Choose **Deploy from a branch**, select the branch and `/ (root)`, then save.

Player names, lifetime mice, unlocked levels, and deaths per level are stored in the player's browser with `localStorage`. This data persists on the same browser and GitHub Pages origin; it is not shared between devices.

For development and testing, append `?level=6&dev=1` to open the bonus level and unlock every replay tile for that browser session.

Append `?level=6&dev=1&preview=1` for an unobscured stationary Level 6 board preview.
