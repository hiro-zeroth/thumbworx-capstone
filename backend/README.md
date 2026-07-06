## 🧱 Full-Stack Architecture

This project uses a **modern monolithic full-stack architecture** that combines Laravel, React, Inertia, Vite, Docker, and shadcn/ui into a single, cohesive development experience.

Instead of separating backend and frontend into different repositories and APIs, this stack delivers a **single application** with an SPA-like user experience, powered by server-side routing and modern frontend tooling.

---

### 🧩 What each part does

| Layer | Technology | Role |
|---|---|---|
| Backend | **Laravel** | Business logic, authentication, database, queues, routing |
| Frontend | **React + TypeScript** | Interactive UI and client-side experience |
| Bridge | **Inertia.js** | Connects Laravel routes directly to React pages without REST/GraphQL |
| UI System | **shadcn/ui + Tailwind (Radix)** | Accessible, customizable component system without lock-in |
| Bundler | **Vite** | Fast dev server, HMR, and optimized production builds |
| Server | **Nginx** | Web server and reverse proxy |
| Database | **MySQL** | Persistent data storage |
| Environment | **Docker** | Consistent development and production environments |

---

### 🎯 Why this stack?

This setup is designed to remove common complexity found in typical SPA + API architectures.

#### ❌ What we avoid

- Separate frontend and backend repos
- REST/GraphQL boilerplate
- CORS configuration issues
- Authentication token handling between apps
- Environment mismatch between developers
- Heavy, opinionated UI frameworks

#### ✅ What we gain

- Server-side routing with SPA feel
- Faster development with fewer moving parts
- Clean separation of concerns inside one codebase
- Fully reproducible environments via Docker
- Modern, accessible UI without vendor lock-in
- Excellent developer experience with Vite HMR
- Easier onboarding for new developers

---

### 🏗 Architectural Philosophy

This is a **full-stack monolith with a modern frontend**, a pattern increasingly adopted by SaaS teams because it balances:

- Simplicity of a monolith
- UX of a single-page application
- Power of Laravel’s backend ecosystem
- Flexibility of React’s frontend ecosystem

You write less glue code and more actual product code.

---

### ✅ Suitable for

- SaaS platforms
- Internal tools and dashboards
- Admin panels
- Startup MVPs
- Production-grade web applications
- Teams that value speed, maintainability, and consistency
