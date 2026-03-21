import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_A_URL || 'https://ickgrwyipbkrenfbpvyh.supabase.co'
const SUPABASE_KEY = import.meta.env.VITE_SUPABASE_A_ANON_KEY || 'sb_publishable_i3CvaFoEd_hNf7joo4pMvQ_Gn1q7Pak'

export const supabaseA = createClient(SUPABASE_URL, SUPABASE_KEY)
