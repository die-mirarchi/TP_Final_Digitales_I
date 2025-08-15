-- Testbench elemental para mux_4b (sin when/assert)
entity mux_4b_tb is
end;

architecture mux_4b_tb_arq of mux_4b_tb is
  -- Declaración del componente (misma interfaz que el DUT)
  component mux_4b is
    port (
      q0_i    : in bit_vector(3 downto 0);
      q1_i    : in bit_vector(3 downto 0);
      q2_i    : in bit_vector(3 downto 0);
      selec   : in bit_vector(2 downto 0);
      mux_out : out bit_vector(3 downto 0)
    );
  end component;

  -- Señales de prueba
  signal q0_tb    : bit_vector(3 downto 0);
  signal q1_tb    : bit_vector(3 downto 0);
  signal q2_tb    : bit_vector(3 downto 0);
  signal selec_tb : bit_vector(2 downto 0) := "000";
  signal y_tb     : bit_vector(3 downto 0);
begin
  -- Valores fijos para las entradas de datos
  q0_tb <= "0001";
  q1_tb <= "0010";
  q2_tb <= "0100";

  -- Barrido del selector por las 5 opciones usadas en el DUT
  selec_tb <= "000", -- q0
    "001" after 50 ns, -- dot (1010 dentro del DUT)
    "010" after 100 ns, -- q1
    "011" after 150 ns, -- q2
    "100" after 200 ns; -- V (1011 dentro del DUT)

  -- Instanciación del DUT
  DUT : mux_4b
  port map
  (
    q0_i    => q0_tb,
    q1_i    => q1_tb,
    q2_i    => q2_tb,
    selec   => selec_tb,
    mux_out => y_tb
  );

  -- La simulación puede correr, por ejemplo, 250 ns para ver todas las transiciones.
end architecture;
