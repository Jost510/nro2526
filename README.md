# DN2 - Interpolacija

**Temperatura v (0.403, 0.503):**
- scatteredInterpolant: 283.24 °C (3.83 s)
- griddedInterpolant: 283.24 °C (0.0005 s) 
- Moja bilinearna: 283.24 °C (0.0004 s)

**Najhitrejša:** Moja bilinearna metoda

**Naj toplejše:** 408.46 °C

Bilinearna je najhitrejša ker gre direktno v pravo celico in samo izračuna iz 4 točk.

griddedInterpolant je skoraj tako hiter, sam da rabi malo časa za pripravo.

scatteredInterpolant je pa počasen ker mora narediti triangulacijo za vse točke kar traja.
