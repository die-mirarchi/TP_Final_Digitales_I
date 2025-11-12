----------------------------------------------------------------------------------
-- Modulo: 		Voltimetro_toplevel
-- Descripcion: Voltimetro implementado con un modulador sigma-delta
-- Autor: 		Electronica Digital I
--        		Universidad de San Martin - Escuela de Ciencia y Tecnologia
--
-- Fecha: 		01/09/2020
--              Actualizado: 26/05/2025
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Paquetes para contador de 1's
----------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
package types_pkg is
  type matriz is array (0 to 5) of bit_vector(3 downto 0);
end package;
use work.types_pkg.all;

entity Voltimetro is
  port (
    clk_i           : in bit;
    rst_i           : in bit;
    data_volt_in_i  : in bit;
    data_volt_out_o : out bit;
    hs_o            : out bit;
    vs_o            : out bit;
    red_o           : out bit;
    grn_o           : out bit;
    blu_o           : out bit
  );

end Voltimetro;

architecture Voltimetro_arq of Voltimetro is

  -------------------------------------------------------------------------------------
  -- Declaracion del componente voltimetro
  --   Este componente incluye el bloque de procesamiento de datos y control y el
  --   flip-flop de entrada
  -------------------------------------------------------------------------------------
  component ffd_sinc is
    port (
      clk_i  : in bit;
      d_in   : in bit;
      srst_i : in bit;
      en_i   : in bit;
      q_out  : out bit
    );
  end component;

  -------------------------------------------------------------------------------------
  -- Declaracion del componente contador de n_bits
  --   Se implementa un contador de 2 bits, tomando el bit mas alto de su salida
  -------------------------------------------------------------------------------------
  component cont_nbit is
    port (
      enable_i : in bit;
      reset_i  : in bit;
      clock_i  : in bit;
      en_d_i   : in bit;
      q0_out   : out bit;
      next_out : out bit
    );
  end component;
  -------------------------------------------------------------------------------------
  -- Declaracion del componente contador cont_330000
  --   Cada 330000 ciclos se genera una señal de enable y reset para el contador de 1's.
  -------------------------------------------------------------------------------------
  component cont_330000 is
    port (
      clk_i   : in bit;
      rst_i   : in bit;
      en_i    : in bit;
      q_en_o  : out bit;
      q_rst_o : out bit;
      q_num   : out bit_vector(18 downto 0)
    );
  end component;
  -------------------------------------------------------------------------------------
  -- Declaracion del componente contador cont_1
  --   Contador de 1's de 6 digitos BCD con registros internos para los 3 digitos mas significativos
  -------------------------------------------------------------------------------------
  component cont_1 is
    port (
      clk_i    : in bit;
      rst_i    : in bit;
      reg_en_i : in bit;
      adc      : in bit;
      num_out  : out matriz;
      q0_out   : out bit_vector(3 downto 0);
      q1_out   : out bit_vector(3 downto 0);
      q2_out   : out bit_vector(3 downto 0)
    );
  end component;
  -------------------------------------------------------------------------------------
  -- Declaracion del componente mux_4b	
  --   Multiplexor de 3 entradas de 4 bits con seleccion de 3 bits dependiendo del digito a mostrar
  -------------------------------------------------------------------------------------
  component mux_4b is
    port (
      q0_i    : in bit_vector(3 downto 0);
      q1_i    : in bit_vector(3 downto 0);
      q2_i    : in bit_vector(3 downto 0);
      selec   : in bit_vector(2 downto 0);
      mux_out : out bit_vector(3 downto 0)
    );
  end component;
  -------------------------------------------------------------------------------------
  -- Declaracion del componente ROM
  --  Memoria de solo lectura que contiene la fuente de los caracteres a mostrar
  -------------------------------------------------------------------------------------
  component ROM is
    port (
      char_address : in bit_vector(3 downto 0);
      font_col     : in bit_vector(2 downto 0);
      font_row     : in bit_vector(2 downto 0);
      data_out     : out bit
    );
  end component;
  -------------------------------------------------------------------------------------
  -- Declaracion del componente vga_ctrl
  --   Controlador VGA para resolucion 800x600 a 60Hz
  -------------------------------------------------------------------------------------
  component vga_ctrl is
    port (
      clk     : in bit; -- Reloj de píxel (25.175 MHz típico)
      red_i   : in bit;
      grn_i   : in bit;
      blu_i   : in bit;
      hs      : out bit; -- HS activo en '0'
      vs      : out bit; -- VS activo en '0'
      red_o   : out bit;
      grn_o   : out bit;
      blu_o   : out bit;
      pixel_x : out bit_vector(9 downto 0); -- 0..799
      pixel_y : out bit_vector(9 downto 0) -- 0..524
    );
  end component;
  -------------------------------------------------------------------------------------
  -- Señales internas
  -------------------------------------------------------------------------------------
  signal ffd_volt_in_aux   : bit;
  signal q_en_o_33000_aux  : bit;
  signal q_rst_o_33000_aux : bit;
  signal q0_out_aux        : bit_vector(3 downto 0);
  signal q1_out_aux        : bit_vector(3 downto 0);
  signal q2_out_aux        : bit_vector(3 downto 0);
  signal mux_out_aux       : bit_vector(3 downto 0);
  signal data_rom_out_aux  : bit;
  signal red_o_aux         : bit;
  signal grn_o_aux         : bit;
  signal blu_o_aux         : bit;
  signal hs_o_aux          : bit;
  signal vs_o_aux          : bit;
  signal pixel_x_aux       : bit_vector(9 downto 0);
  signal pixel_y_aux       : bit_vector(9 downto 0);
  signal selec_aux         : bit_vector(2 downto 0);
  signal rom_char_aux      : bit_vector(3 downto 0);
  signal rom_sel_aux       : bit;
begin
  -- Instancia del flip-flop de entrada
  u_ffd_sinc : ffd_sinc
  port map
  (
    clk_i  => clk_i,
    d_in   => data_volt_in_i,
    srst_i => rst_i,
    en_i   => '1',
    q_out  => ffd_volt_in_aux
  );
  data_volt_out_o <= not ffd_volt_in_aux;

  -- Instancia de contador de 330000 ciclos
  u_cont_330000 : cont_330000
  port map
  (
    clk_i   => clk_i,
    rst_i   => rst_i,
    en_i    => '1',
    q_en_o  => q_en_o_33000_aux,
    q_rst_o => q_rst_o_33000_aux,
    q_num   => open
  );
  -- Instancia del contador de 1's
  u_cont_1 : cont_1
  port map
  (
    clk_i    => clk_i,
    rst_i    => (q_rst_o_33000_aux or rst_i),
    reg_en_i => q_en_o_33000_aux,
    adc      => data_volt_in_i,
    num_out  => open,
    q0_out   => q0_out_aux,
    q1_out   => q1_out_aux,
    q2_out   => q2_out_aux
  );
  -- Instancia del multiplexor de 4 bits
  selec_aux <= pixel_x_aux(9 downto 7); -- Selecciona el digito a mostrar dependiendo de la posicion X del pixel
  u_mux_4b : mux_4b
  port map
  (
    q0_i    => q0_out_aux,
    q1_i    => q1_out_aux,
    q2_i    => q2_out_aux,
    selec   => selec_aux,
    mux_out => mux_out_aux
  );
  --instancia de la ROM
  rom_sel_aux  <= (not pixel_y_aux(9)) and (not pixel_y_aux(8)) and pixel_y_aux(7); -- Activa la ROM solo en las filas de los caracteres
  rom_char_aux <= ((rom_sel_aux & rom_sel_aux & rom_sel_aux & rom_sel_aux) and mux_out_aux) or ((not(rom_sel_aux & rom_sel_aux & rom_sel_aux & rom_sel_aux))and "1100");
  u_ROM : ROM
  port map
  (
    char_address => rom_char_aux,
    font_col     => pixel_x_aux(6 downto 4),
    font_row     => pixel_y_aux(6 downto 4),
    data_out     => data_rom_out_aux
  );
  -- Instancia del controlador VGA
  u_vga_ctrl : vga_ctrl
  port map
  (
    clk     => clk_i,
    red_i   => data_rom_out_aux,
    grn_i   => data_rom_out_aux,
    blu_i   => '0',
    hs      => hs_o_aux,
    vs      => vs_o_aux,
    red_o   => red_o_aux,
    grn_o   => grn_o_aux,
    blu_o   => blu_o_aux,
    pixel_x => pixel_x_aux,
    pixel_y => pixel_y_aux
  );
  hs_o  <= hs_o_aux;
  vs_o  <= vs_o_aux;
  red_o <= red_o_aux;
  grn_o <= grn_o_aux;
  blu_o <= blu_o_aux;
end;