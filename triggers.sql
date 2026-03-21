-- AUTOMATIZACION DE TOTALES PARA EL DASHBOARD
-- Ejecuta este script en el SQL Editor de Supabase A

-- 1. Funcion para actualizar totales de Alcalde
CREATE OR REPLACE FUNCTION public.refresh_totales_alcalde()
RETURNS trigger AS $$
BEGIN
    UPDATE public.totales_alcalde
    SET 
        p01 = (SELECT COALESCE(SUM(p01), 0) FROM public.votos_alcalde),
        p02 = (SELECT COALESCE(SUM(p02), 0) FROM public.votos_alcalde),
        p03 = (SELECT COALESCE(SUM(p03), 0) FROM public.votos_alcalde),
        p04 = (SELECT COALESCE(SUM(p04), 0) FROM public.votos_alcalde),
        p05 = (SELECT COALESCE(SUM(p05), 0) FROM public.votos_alcalde),
        p06 = (SELECT COALESCE(SUM(p06), 0) FROM public.votos_alcalde),
        p07 = (SELECT COALESCE(SUM(p07), 0) FROM public.votos_alcalde),
        p08 = (SELECT COALESCE(SUM(p08), 0) FROM public.votos_alcalde),
        p09 = (SELECT COALESCE(SUM(p09), 0) FROM public.votos_alcalde),
        p10 = (SELECT COALESCE(SUM(p10), 0) FROM public.votos_alcalde),
        p11 = (SELECT COALESCE(SUM(p11), 0) FROM public.votos_alcalde),
        blancos = (SELECT COALESCE(SUM(blancos), 0) FROM public.votos_alcalde),
        nulos = (SELECT COALESCE(SUM(nulos), 0) FROM public.votos_alcalde),
        mesas_escrutadas = (SELECT COUNT(*) FROM public.votos_alcalde),
        updated_at = now()
    WHERE id = 1;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 2. Funcion para actualizar totales de Concejo
CREATE OR REPLACE FUNCTION public.refresh_totales_concejo()
RETURNS trigger AS $$
BEGIN
    UPDATE public.totales_concejo
    SET 
        p01 = (SELECT COALESCE(SUM(p01), 0) FROM public.votos_concejo),
        p02 = (SELECT COALESCE(SUM(p02), 0) FROM public.votos_concejo),
        p03 = (SELECT COALESCE(SUM(p03), 0) FROM public.votos_concejo),
        p04 = (SELECT COALESCE(SUM(p04), 0) FROM public.votos_concejo),
        p05 = (SELECT COALESCE(SUM(p05), 0) FROM public.votos_concejo),
        p06 = (SELECT COALESCE(SUM(p06), 0) FROM public.votos_concejo),
        p07 = (SELECT COALESCE(SUM(p07), 0) FROM public.votos_concejo),
        p08 = (SELECT COALESCE(SUM(p08), 0) FROM public.votos_concejo),
        p09 = (SELECT COALESCE(SUM(p09), 0) FROM public.votos_concejo),
        p10 = (SELECT COALESCE(SUM(p10), 0) FROM public.votos_concejo),
        p11 = (SELECT COALESCE(SUM(p11), 0) FROM public.votos_concejo),
        blancos = (SELECT COALESCE(SUM(blancos), 0) FROM public.votos_concejo),
        nulos = (SELECT COALESCE(SUM(nulos), 0) FROM public.votos_concejo),
        updated_at = now()
    WHERE id = 1;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 3. Triggers para Alcalde
DROP TRIGGER IF EXISTS tr_update_totales_alcalde ON public.votos_alcalde;
CREATE TRIGGER tr_update_totales_alcalde
AFTER INSERT OR UPDATE OR DELETE ON public.votos_alcalde
FOR EACH STATEMENT EXECUTE FUNCTION public.refresh_totales_alcalde();

-- 4. Triggers para Concejo
DROP TRIGGER IF EXISTS tr_update_totales_concejo ON public.votos_concejo;
CREATE TRIGGER tr_update_totales_concejo
AFTER INSERT OR UPDATE OR DELETE ON public.votos_concejo
FOR EACH STATEMENT EXECUTE FUNCTION public.refresh_totales_concejo();

-- 5. Inicializar totales (por si ya hay datos guardados)
SELECT public.refresh_totales_alcalde();
SELECT public.refresh_totales_concejo();
