# TaskFlow — Real-World Project Guide

A bilingual (English / ไทย) step-by-step guide that teaches you to build **TaskFlow**, a realtime, multi-user **Kanban board**, from an empty repo to a running `docker compose up` stack.

It is project **#1** of the Learn Hub [Real-World Projects](https://projects.avetavos.com/taskflow/en/introduction/roadmap/) series — each project rebuilds a real application while adapting a different slice of the Learn Hub courses.

**Live:** https://projects.avetavos.com/taskflow/en/

## What you build

| Layer | Tech |
|-------|------|
| Backend | Rust · Axum · SQLx · Tokio (REST API + WebSocket) |
| Database | PostgreSQL |
| Cache / bus | Redis (token store, cache-aside, pub/sub backplane) |
| Frontend | Astro (static shell) + a Preact Kanban island |
| Realtime | WebSocket over a Redis `board:{id}` backplane |
| Runtime | Docker Compose (multi-stage images, one-command up) |

Features: register/login (argon2 + JWT), boards → columns → cards, drag-and-drop with fractional-position ordering, labels, per-board realtime sync with optimistic UI, Redis caching + rate limiting, integration and unit tests.

## The guide itself

This repo is an [Astro Starlight](https://starlight.astro.build/) site. The lessons live in `src/content/docs/en/**` and `src/content/docs/th/**`, grouped into 13 modules (Introduction → Setup → Database → Backend Foundations → Auth → REST API → Caching → Realtime → Frontend → Kanban Island → Testing → Docker → Wrap-up). Each lesson follows the same shape: *what we're building → why → pros & cons → build it → verify → recap*, with full copy-pasteable code.

## Run the guide locally

```bash
npm install
npm run dev      # http://localhost:4321/taskflow/
npm run build    # static build to dist/
```

## Deployment

Static site (`output: 'static'`, `base: '/taskflow'`) intended for `projects.avetavos.com/taskflow`. No server needed for the guide. Build with `npm run build` and serve `dist/`.
