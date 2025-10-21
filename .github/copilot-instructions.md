The repository implements a small VHDL-based voltmeter and VGA demo targeted to the Arty A7-35 FPGA.

Key context for AI coding agents
- Project layout: top-level HDL is in `src/` (e.g. `Voltimetro_Esquema_Arty_A7-35_top_level.vhdl`).
- Synthesis and constraints are in `synth/final_dig1/` and `board_files/constrains/Arty-A7-35-Master.xdc`.
- Testbenches live in `tb/` and pre-generated Vivado simulation scripts are under `synth/final_dig1/final_dig1.sim/`.

Big-picture architecture
- The toplevel entity is `Voltimetro_toplevel` (see `src/Voltimetro_Esquema_Arty_A7-35_top_level.vhdl`) which instantiates:
  - a clock-divider `cont_bin` generating a 25 MHz pixel clock from the 100 MHz system clock, and
  - the `Voltimetro` block (in `src/`), which contains the data-processing, SD modulator and VGA output wiring.
- The VGA controller is implemented as `vga_ctrl` in `src/vga.vhdl` and follows a ripple-counter style using `cont_nbit` and `ffd_sinc` components.
- Small building-block components follow a style of single-bit or N-bit reusable modules (`ffd`, `ffd_sinc`, `cont_nbit`, `cont_330000`) composed with generate loops.

Developer workflows (what to run)
- Simulation (Vivado XSim): use the generated script in `synth/final_dig1/final_dig1.sim/sim_1/behav/xsim/compile.bat` to compile the simulation set, then launch XSim from Vivado or via the Vivado tools. The script calls `xvhdl` and expects the Vivado toolchain in PATH.
- Synthesis/implementation: open `synth/final_dig1/final_dig1.xpr` in Vivado (recommended Vivado 2018.3 per project file header) and run the synth/impl flows. Constraints are wired to the Arty A7-35 XDC under `board_files/constrains/`.

Project-specific conventions and patterns
- Types: this repo uses `bit` and `bit_vector` (not `std_logic`) everywhere — keep using those types when editing files for consistency.
- Naming: modules end with `_arq` for architectures (e.g. `vga_ctrl_arq`) and component instances use short prefixes (e.g. `u_hs`, `inst_voltimetro`).
- Counters: small counter cells (`cont_nbit`) are chained with generate loops; equality detection is done with explicit bitwise logic rather than integer conversions.
- Resets: many resets are synchronous (`srst_i`) and represented as `'1'` for active reset in `ffd_sinc` and similar modules. Search for `_srst` or `srst_i` to find examples.

Integration points & external dependencies
- Vivado toolchain (xvhdl, xelab, xsim) is required for build and simulation. The project file was generated with Vivado v2018.3; tool command-line scripts assume Vivado binaries are on PATH.
- Board constraints: `board_files/constrains/Arty-A7-35-Master.xdc` maps top-level ports to FPGA pins. Changes to IO names must keep XDC mapping in sync.

Quick examples for edits
- Add a new 1-bit synchronous signal: follow `ffd_sinc` usage (example in `src/vga.vhdl`) and instantiate with named port mapping.
- Add an N-bit counter: use `cont_nbit` in a generate loop like `cont_330000.vhdl` or `vga.vhdl`'s `gen_h`/`gen_v` patterns.
- Read ROM: `rom.vhdl` packs character rows as hex constants; use `conv_to_integer` helper when indexing bit_vector addresses.

When to ask the human
- If a change affects pinout or top-level port names — confirm updates to `board_files/constrains/Arty-A7-35-Master.xdc`.
- If you need to upgrade the Vivado project to a newer Vivado version: ask for a preferred target; upgrading can change synthesis results.

Files to reference when coding
- `src/Voltimetro_Esquema_Arty_A7-35_top_level.vhdl` — top-level wiring and clock generator example.
- `src/vga.vhdl` — VGA timing, ripple counters, visible-window logic.
- `src/cont_nbit.vhdl`, `src/ffd_s.vhdl`, `src/cont_330000.vhdl` — counter and flip-flop patterns.
- `synth/final_dig1/final_dig1.xpr` and `synth/final_dig1/final_dig1.sim/behav/xsim/compile.bat` — build/sim entry points.

If anything above is unclear or you'd like more specific examples (testbench patterns, how to run XSim locally, or conventions for adding new IP), tell me which area to expand.
