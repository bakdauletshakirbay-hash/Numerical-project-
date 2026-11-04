# MATH 351 Group Project (Fall 2026): MATLAB code

## How to run

1. Open MATLAB and set the **Current Folder** to the `code` folder.
2. Type `main` in the Command Window.

All results are printed to the Command Window and saved in `code/results.txt`. All figures are saved as PNG files (300 dpi) in `code/figures/`. The full paths are printed at the end of the run.

## Repository layout

| Folder / file | Contents |
|---|---|
| `code/` | the 24 MATLAB `.m` files (this is what we submit as the code) |
| `figures/`, `results.txt` | output of our MATLAB run, used in the report |
| `report_template/` | empty LaTeX template with the NU title page (gold logo, Palatino 11pt) |
| `*.pdf` | project description and lecture slides |

Each task can also be run on its own (`task1_interpolation`, `task2_backtesting`, `task3_sensitivity`, `task4_rootfinding`, `task6_rural`, `task7_urban`). Task 5 is a literature discussion and has no code.

## Files

| File | What it is | Source |
|---|---|---|
| `population_data.m` | Data table from the project description | — |
| `LagrangeInterpolation.m` | Model 1: Lagrange interpolation polynomial | Written from Lecture 4, Thm 3.2 (slides 18–19); same name/call as the driver on slide 106 |
| `natural_spline_coef.m` | Natural cubic spline coefficients | Lecture 4, slide 86, **unchanged** |
| `natural_spline.m` | Model 2: natural cubic spline evaluation | Lecture 4, slide 87, **modified** (extrapolation) |
| `spline_piece.m` | Chooses which cubic piece to use at a point | Lecture search loop + **new** extrapolation rule |
| `natural_spline_deriv.m` | Spline derivative S'(t), for Newton's method | **New** |
| `LagrangeDerivative.m` | Lagrange derivative P'(t), for Newton's method if Lagrange is chosen | **New** |
| `bisect.m` | Bisection method | Lecture 3, slide 9, **modified** (stores iterations) |
| `secant.m` | Secant method | Written from Lecture 3, slide 35 |
| `newton.m` | Newton's method | Written from Lecture 3, Algorithm 2.3 (slide 28) |
| `model_eval.m`, `model_deriv.m` | Call either model by name (`'lagrange'` / `'spline'`) | Helper |
| `selected_model.m` | **The model chosen in Task 3** (used by Tasks 4, 6, 7) | Change here if the group decides differently |
| `year_to_date.m` | Converts t (years) to year + month | Helper |
| `project_population.m` | 2028/2030 projections + plot (Tasks 6, 7) | Helper |
| `save_figure.m` | Saves the current figure into `code/figures/` (300 dpi) | Helper |
| `format_figure.m` | Common figure style (Times 11 pt, 14 x 9 cm, light grid) | Helper |
| `task1_...m` to `task7_...m`, `main.m` | One script per task, `main` runs all | — |

## Modifications to the lecture code (explain these in the report)

1. **`natural_spline.m`: extrapolation.** The lecture version searches for `k` with `dataX(j) <= x <= dataX(j+1)`. For a prediction outside the data (e.g. 2026 from 2021–2025 data) no `k` is found and the code fails. We extend the **last cubic piece S_n** to the right (and the first piece S_1 to the left). This is in `spline_piece.m`.
2. **`bisect.m`: iteration table.** The algorithm is unchanged, including the a priori number of iterations `n = ceil(log2(b-a) - log2(2*atol))`. We only store `[k, a_k, b_k, p_k, F(p_k)]` at each iteration so the table with residuals can be printed. It also stops early if `F(p)` is exactly 0.
3. **`newton.m`, `secant.m`.** These are given only as pseudocode or formulas in the slides. We translated them directly to MATLAB, with the same stopping rule `|p_i - p_{i-1}| < TOL` and the same storage of iterations.
4. **`LagrangeInterpolation.m`.** The slides call this function but don't show its code, so it is written from the Lagrange formula.
5. **Derivatives for Newton.** For the spline, S_k'(t) = b_k + 2c_k(t - t_k) + 3d_k(t - t_k)^2, using the lecture coefficients.

## Choices made (the group can change them)

- **Spline type:** natural (S'' = 0 at the ends). There is no derivative data for a clamped spline; Lecture 4, slide 104 makes the same argument.
- **Time variable:** t = calendar year; population is on January 1, so t = 2026.94 is in December 2026.
- **Task 4:** TOL = 1e-6 years (about 30 seconds) for all three methods. Bisection interval [2026, 2027]. Secant p0 = 2026, p1 = 2027. Newton p0 = 2026. F(2026) < 0 < F(2027).
- **Selected model:** `'spline'`, chosen from the results of Tasks 2 and 3 (see below).

## Main results (from `results.txt`, MATLAB run)

- **Task 1 (2026 prediction):** spline relative errors 1.9e-3 (all), 1.0e-3 (urban), 3.4e-3 (rural). Lagrange: 1.8e-2, 3.3e-2, 7.2e-3.
- **Task 2:** the spline is better in **all 9** back-tests. Mean relative error is 3.4e-3 for the spline vs 2.9e-2 for Lagrange.
- **Task 3:** a 0.5% change in the 2024 value changes the 2026 Lagrange prediction by about 5% (about 10 times amplification). The spline changes by about 0.5% (about 1 times). Lagrange is about 10 times more sensitive.
- **Task 4:** all three methods give t* ≈ 2026.9412, which is **December 2026**. Bisection takes 19 iterations, secant 4, Newton 4.
- **Task 6 (rural, spline):** 7,230,079 (2028) and 7,114,449 (2030).
- **Task 7 (urban, spline):** 13,742,027 (2028) and 14,688,408 (2030).
