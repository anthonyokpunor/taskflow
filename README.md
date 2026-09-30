# TaskFlow Pro v2

A cloud-ready task manager built with React + Vite + Supabase.

## Included
- Auth with email/password
- Cloud task persistence
- Postgres Row Level Security
- Realtime task updates
- Today, Inbox, Upcoming, Completed
- Projects
- List and Kanban views
- Calendar
- Task drawer with priority, due date, estimate, notes and recurrence
- Focus timer
- Analytics
- Light/dark mode
- Responsive UI
- Demo mode when Supabase is not configured

## Supabase setup
1. Create a Supabase project.
2. Open SQL Editor and run `supabase.sql`.
3. Create `.env` from `.env.example` and add your project URL + anon key.
4. Run `npm install` then `npm run dev`.

## Vercel
Import this repository into Vercel and add the same `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` environment variables. Vercel will build the Vite app with `npm run build`.
