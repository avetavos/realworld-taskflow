// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import preact from '@astrojs/preact';

export default defineConfig({
  site: 'https://projects.avetavos.com',
  base: '/taskflow',
  output: 'static',
  integrations: [starlight({
    title: 'TaskFlow — Real-World Project',
    head: [
      { tag: 'script', attrs: { type: 'module', src: '/taskflow/mermaid-init.js' } },
      { tag: 'link', attrs: { rel: 'manifest', href: '/taskflow/manifest.webmanifest' } },
      { tag: 'link', attrs: { rel: 'apple-touch-icon', href: '/taskflow/apple-touch-icon.png' } },
      { tag: 'link', attrs: { rel: 'icon', type: 'image/png', sizes: '192x192', href: '/taskflow/icon-192.png' } },
      { tag: 'meta', attrs: { name: 'theme-color', content: '#2DB67D' } },
    ],
    defaultLocale: 'en',
    locales: {
      en: { label: 'English', lang: 'en' },
      th: { label: 'ไทย', lang: 'th' },
    },
    customCss: ['./src/styles/custom.css'],
    social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/avetavos/realworld-taskflow' }],
    sidebar: [
      { label: 'Introduction', items: [{ autogenerate: { directory: 'introduction' } }] },
      { label: '1 · Setup & Tooling', items: [{ autogenerate: { directory: 'setup' } }] },
      { label: '2 · Database Design', items: [{ autogenerate: { directory: 'database' } }] },
      { label: '3 · Backend Foundations', items: [{ autogenerate: { directory: 'backend-foundations' } }] },
      { label: '4 · Authentication', items: [{ autogenerate: { directory: 'auth' } }] },
      { label: '5 · REST API', items: [{ autogenerate: { directory: 'rest-api' } }] },
      { label: '6 · Caching (Redis)', items: [{ autogenerate: { directory: 'caching' } }] },
      { label: '7 · Realtime (WebSocket)', items: [{ autogenerate: { directory: 'realtime' } }] },
      { label: '8 · Frontend (Astro)', items: [{ autogenerate: { directory: 'frontend' } }] },
      { label: '9 · The Kanban Island', items: [{ autogenerate: { directory: 'kanban-island' } }] },
      { label: '10 · Testing', items: [{ autogenerate: { directory: 'testing' } }] },
      { label: '11 · Docker & Compose', items: [{ autogenerate: { directory: 'docker' } }] },
      { label: '12 · Wrap-up', items: [{ autogenerate: { directory: 'wrap-up' } }] },
    ],
  }), preact()],
});
