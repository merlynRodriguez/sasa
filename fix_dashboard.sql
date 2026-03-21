-- CORRECCION Y SINCRONIZACION DEL DASHBOARD
-- Ejecuta este script en el SQL Editor de Supabase A

-- 1. Asegurar que las filas de totales existan
INSERT INTO public.totales_alcalde (id) VALUES (1) ON CONFLICT DO NOTHING;
INSERT INTO public.totales_concejo (id) VALUES (1) ON CONFLICT DO NOTHING;

-- 2. Logica de actualizacion para Alcalde (Funcion Normal)
CREATE OR REPLACE FUNCTION public.fn_sync_totales_alcalde()
RETURNS void AS $$
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
END;
$$ LANGUAGE plpgsql;

-- 3. Logica de actualizacion para Concejo (Funcion Normal)
CREATE OR REPLACE FUNCTION public.fn_sync_totales_concejo()
RETURNS void AS $$
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
END;
$$ LANGUAGE plpgsql;

-- 4. Funciones Wrapper para Triggers (Piden retornar trigger)
CREATE OR REPLACE FUNCTION public.tg_refresh_alcalde()
RETURNS trigger AS $$
BEGIN
    PERFORM public.fn_sync_totales_alcalde();
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.tg_refresh_concejo()
RETURNS trigger AS $$
BEGIN
    PERFORM public.fn_sync_totales_concejo();
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 5. Re-crear Triggers
DROP TRIGGER IF EXISTS tr_sync_alcalde ON public.votos_alcalde;
CREATE TRIGGER tr_sync_alcalde
AFTER INSERT OR UPDATE OR DELETE ON public.votos_alcalde
FOR EACH STATEMENT EXECUTE FUNCTION public.tg_refresh_alcalde();

DROP TRIGGER IF EXISTS tr_sync_concejo ON public.votos_concejo;
CREATE TRIGGER tr_sync_concejo
AFTER INSERT OR UPDATE OR DELETE ON public.votos_concejo
FOR EACH STATEMENT EXECUTE FUNCTION public.tg_refresh_concejo();

-- 6. SINCRONIZACION MANUAL INICIAL (Llamada a funcion normal)
SELECT public.fn_sync_totales_alcalde();
SELECT public.fn_sync_totales_concejo();

-- 7. Asegurar Politicas de Seguridad (RLS) para el Dashboard
ALTER TABLE public.totales_alcalde ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.totales_concejo ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Permitir lectura anonima totales_alcalde" ON public.totales_alcalde;
CREATE POLICY "Permitir lectura anonima totales_alcalde" 
ON public.totales_alcalde FOR SELECT USING (true);

DROP POLICY IF EXISTS "Permitir lectura anonima totales_concejo" ON public.totales_concejo;
CREATE POLICY "Permitir lectura anonima totales_concejo" 
ON public.totales_concejo FOR SELECT USING (true);
