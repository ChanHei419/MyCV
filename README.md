# HeiChan — Personal CV / Portfolio Platform

![Nuxt](https://img.shields.io/badge/Nuxt-3-00DC82?logo=nuxtdotjs&logoColor=white)
![Vue](https://img.shields.io/badge/Vue-3-4FC08D?logo=vuedotjs&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?logo=bootstrap&logoColor=white)
![SCSS](https://img.shields.io/badge/Styles-SCSS-C6538C?logo=sass&logoColor=white)

An interactive, multi-page CV / portfolio built with **Nuxt 3** — engineered as a real product rather than a static page.

> Built by **HeiChan (Chan Hei Lun)** — BEng in Information Engineering, The Chinese University of Hong Kong.
> Software Engineering · Cloud & AI Automation · Data

---

## Highlights

- **Multi-page Nuxt 3 architecture** — file-based routing, layout system, and component auto-imports
- **Live GitHub integration** — project cards pull real repo stats from the GitHub REST API with graceful offline fallbacks
- **Dark / light mode** — persisted per visitor, with reactive styling across every page
- **Animated hero** — typewriter loop, rotating taglines, floating background shapes
- **Interactive project grid** — category filters, SVG-generated project covers (no stock photos)
- **Skills portfolio** — 20+ skills across four domains, live dashboard statistics, flip cards, filtering, add / remove, JSON export
- **Experience timeline** — expandable cards, search, filters, highlight, export and native share
- **Interactive forms** — contact form that composes a real `mailto:` message, comments, toast notifications

## Pages

| Route         | Description                                                        |
| ------------- | ------------------------------------------------------------------ |
| `/`           | Hero, about, skills, featured projects, comments, contact          |
| `/about`      | Mission statement and career journey timeline                      |
| `/education`  | CUHK Information Engineering degree, coursework, and highlights    |
| `/experience` | Professional experience — role outcomes and skills built           |
| `/skills`     | Full skills portfolio with dashboard statistics and interactivity  |

## Tech Stack

- **Framework:** Nuxt 3 (Vue 3, Vue Router, Vite)
- **Styling:** SCSS + Bootstrap 5, Font Awesome, Animate.css
- **Data:** GitHub REST API (live repo stats)
- **Rendering:** SSR / static generation ready (`nuxt generate`)

## Project Structure

```
.
├── app.vue                 # Root component
├── nuxt.config.ts          # Nuxt configuration & head meta
├── layouts/
│   └── default.vue         # Global layout (header + footer)
├── components/
│   ├── TheHeader.vue       # Navigation bar with theme handling
│   └── TheFooter.vue       # Footer with contact links
├── pages/
│   ├── index.vue           # Home (hero, skills, projects, contact)
│   ├── about.vue           # Mission & journey timeline
│   ├── education.vue       # CUHK degree & coursework
│   ├── experience.vue      # Professional experience timeline
│   └── skills.vue          # Skills portfolio
└── public/
    ├── profile.jpg         # Profile photo
    └── favicon.svg         # Site icon
```

## Getting Started

```bash
# install dependencies
npm install

# start dev server (http://localhost:3000)
npm run dev

# production build
npm run build

# static generation
npm run generate
```

## Notes

- Employer names are intentionally omitted from the experience page — it focuses on role outcomes and the skills each experience built.
- Project covers are generated as inline SVG at runtime, so the grid has no external image dependencies.

## Contact

- GitHub: [@ChanHei419](https://github.com/ChanHei419)
- LinkedIn: [helon-chan](https://www.linkedin.com/in/helon-chan/)
- Email: cccheilllun4129@gmail.com
