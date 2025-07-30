entity cont_bcd_tb is
end;

architecture cont_bcd_tb_arq of cont_bcd_tb is
  -- Declaración del componente
  component cont_bcd is
    port (
      enab_i : in bit;
      rest_i : in bit;
      clck_i : in bit;
      q_o    : out bit_vector(3 downto 0);
      next_o : out bit
    );
  end component;

  -- Señales del banco de pruebas
  signal clk_tb    : bit := '0';
  signal rst_tb    : bit := '0';
  signal enable_tb : bit := '1';
  signal q_tb      : bit_vector(3 downto 0);
  signal next_tb   : bit;

begin
  -- Generación del reloj (periodo de 50ns)
  clk_tb <= not clk_tb after 5 ns;

  -- Escenario de prueba
  rst_tb    <= '1' after 10 ns, '0' after 60 ns;
  enable_tb <= not enable_tb after 78 ns;

  -- El enable se mantendrá en alto durante toda la prueba para permitir el conteo
  -- enable_tb permanece en '1' como se inicializó

  -- Instanciación del componente (Dispositivo Bajo Prueba)
  DUT : cont_bcd
  port map
  (
    enab_i => enable_tb,
    rest_i => rst_tb,
    clck_i => clk_tb,
    q_o    => q_tb,
    next_o => next_tb
  );

  -- El banco de pruebas mostrará el contador incrementando automáticamente de 0 a 9
  -- y luego reiniciándose a 0 debido a la lógica interna de reset en cont_bcd
end;