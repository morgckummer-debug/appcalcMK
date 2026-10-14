-- Função usada pelo workflow .github/workflows/supabase-keepalive.yml.
-- Executa uma query real no Postgres (contornando o RLS), gerando atividade
-- no banco para o Supabase não pausar o projeto por inatividade.
-- Rode uma vez no SQL Editor do projeto ustajtfcwnlrloutfrrt.

create or replace function public.keepalive()
returns timestamptz
language plpgsql
security definer
set search_path = public
as $$
begin
  perform 1 from public.pregnancy_profiles limit 1;
  return now();
end;
$$;

revoke all on function public.keepalive() from public;
grant execute on function public.keepalive() to anon, authenticated;
