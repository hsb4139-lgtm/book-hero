-- 책의 용사: Supabase 표 만들기
-- Supabase 대시보드 > SQL Editor 에 전체를 붙여 넣고 Run 을 누르세요. 여러 번 실행해도 안전합니다.

create table if not exists public.bh_meta (
  class_code text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists public.bh_students (
  id text primary key,
  class_code text not null,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
create index if not exists bh_students_class_idx on public.bh_students (class_code);

create table if not exists public.bh_approvals (
  id text primary key,
  class_code text not null,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
create index if not exists bh_approvals_class_idx on public.bh_approvals (class_code);

-- 행 수준 보안(RLS): 게임(anon 키)이 이 세 표만 읽고 쓸 수 있게 합니다.
alter table public.bh_meta enable row level security;
alter table public.bh_students enable row level security;
alter table public.bh_approvals enable row level security;

drop policy if exists "bh_meta_game" on public.bh_meta;
create policy "bh_meta_game" on public.bh_meta for all to anon using (true) with check (true);
drop policy if exists "bh_students_game" on public.bh_students;
create policy "bh_students_game" on public.bh_students for all to anon using (true) with check (true);
drop policy if exists "bh_approvals_game" on public.bh_approvals;
create policy "bh_approvals_game" on public.bh_approvals for all to anon using (true) with check (true);

-- 실시간 동기화: 선생님 승인이 학생 화면에 바로 도착하게 합니다.
do $$ begin
  alter publication supabase_realtime add table public.bh_meta;
exception when duplicate_object then null; end $$;
do $$ begin
  alter publication supabase_realtime add table public.bh_students;
exception when duplicate_object then null; end $$;
do $$ begin
  alter publication supabase_realtime add table public.bh_approvals;
exception when duplicate_object then null; end $$;
