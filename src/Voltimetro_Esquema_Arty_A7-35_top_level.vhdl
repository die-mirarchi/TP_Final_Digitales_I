----------------------------------------------------------------------------------
-- Modulo: 		Voltimetro_toplevel
-- Descripcion: Voltimetro implementado con un modulador sigma-delta
-- Autor: 		Electronica Digital I
--        		Universidad de San Martin - Escuela de Ciencia y Tecnologia
--
-- Fecha: 		01/09/2020
--              Actualizado: 26/05/2025
----------------------------------------------------------------------------------

entity Voltimetro_toplevel is
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

end Voltimetro_toplevel;

architecture Voltimetro_toplevel_arq of Voltimetro_toplevel is

  -------------------------------------------------------------------------------------
  -- Declaracion del componente voltimetro
  --   Este componente incluye el bloque de procesamiento de datos y control y el
  --   flip-flop de entrada
  -------------------------------------------------------------------------------------
  component Voltimetro is
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
  end component Voltimetro;

  -------------------------------------------------------------------------------------
  -- Declaracion del componente generador de reloj
  --   Se implementa con un contador de 2 bits, tomando el bit mas alto de su salida
  -------------------------------------------------------------------------------------
  component cont_nbit is
    port (
      en_d_i   : in bit; -- Señal de habilitación del contador
      reset_i  : in bit; -- Señal de reinicio sincrónico
      clock_i  : in bit; -- Señal de reloj del sistema
      enable_i : in bit; -- Habilitación para el flip-flop D
      q0_out   : out bit; -- Salida del estado actual del contador
      next_out : out bit -- Señal para habilitar el siguiente bit del contador
    );
  end component;

  signal cuenta      : bit_vector(1 downto 0);
  signal clk25MHz    : bit;
  signal cuenta_d    : bit_vector(1 downto 0);
  signal cuenta_next : bit_vector(1 downto 0);

begin

  -- Generador del reloj lento
  cuenta_d(0) <= '1';
  gen_cuenta : for i in 0 to 1 generate
    u_cn : cont_nbit
    port map
    (
      en_d_i   => cuenta_d(i),
      reset_i  => rst_i,
      clock_i  => clk_i,
      enable_i => '1',
      q0_out   => cuenta(i),
      next_out => cuenta_next(i)
    );
  end generate gen_cuenta;
  cuenta_d(1) <= cuenta_next(0);
  clk25MHz    <= cuenta(1); -- reloj generado (25 MHz)
  -- Instancia del bloque voltimetro
  inst_voltimetro : Voltimetro
  port map
  (
    clk_i           => clk25MHz,
    rst_i           => rst_i,
    data_volt_in_i  => data_volt_in_i,
    data_volt_out_o => data_volt_out_o,
    hs_o            => hs_o,
    vs_o            => vs_o,
    red_o           => red_o,
    grn_o           => grn_o,
    blu_o           => blu_o
  );

end Voltimetro_toplevel_arq;