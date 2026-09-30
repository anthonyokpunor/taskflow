create table if not exists public.tasks (
  id uuid primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  project text not null default 'Inbox',
  priority int not null default 4 check (priority between 1 and 4),
  due date,
  status text not null default 'todo' check (status in ('todo','doing','done')),
  estimate int not null default 30,
  notes text not null default '',
  labels jsonb not null default '[]'::jsonb,
  repeat text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.tasks enable row level security;
drop policy if exists "users read own tasks" on public.tasks;
drop policy if exists "users insert own tasks" on public.tasks;
drop policy if exists "users update own tasks" on public.tasks;
drop policy if exists "users delete own tasks" on public.tasks;
create policy "users read own tasks" on public.tasks for select to authenticated using ((select auth.uid()) = user_id);
create policy "users insert own tasks" on public.tasks for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "users update own tasks" on public.tasks for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "users delete own tasks" on public.tasks for delete to authenticated using ((select auth.uid()) = user_id);
create or replace function public.set_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=now(); return new; end; $$;
drop trigger if exists tasks_updated_at on public.tasks;
create trigger tasks_updated_at before update on public.tasks for each row execute function public.set_updated_at();
alter table public.tasks replica identity full;
