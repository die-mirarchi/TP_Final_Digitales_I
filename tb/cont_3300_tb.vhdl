entity cont_3300_tb is
end;

architecture cont_3300_tb_arq of cont_3300_tb is
  -- Declaración del componente
  component cont_3300 is
    port (
      clk_i   : in bit;
      rst_i   : in bit;
      en_i    : in bit;
      q_en_o  : out bit;
      q_rst_o : out bit;
      q_num   : out bit_vector(11 downto 0)
    );
  end component;

  -- Señales del banco de pruebas
  signal clk_tb   : bit := '0';
  signal rst_tb   : bit := '0';
  signal en_tb    : bit := '1';
  signal q_en_tb  : bit;
  signal q_rst_tb : bit;
  signal q_num_tb : bit_vector(11 downto 0);

  -- Señales auxiliares para monitoreo
  signal contador_decimal : integer := 0;

begin
  -- Generación del reloj (periodo de 20ns = 50MHz)
  clk_tb <= not clk_tb after 1 ns;

  -- Escenario de prueba
  -- Reset inicial por 100ns, luego liberar para permitir el conteo
  rst_tb <= '1' after 10 ns, '0' after 100 ns;

  en_tb <= '0' after 8000 ns;

  -- Instanciación del componente (Dispositivo Bajo Prueba)
  DUT : cont_3300
  port map
  (
    clk_i   => clk_tb,
    rst_i   => rst_tb,
    en_i    => en_tb,
    q_en_o  => q_en_tb,
    q_rst_o => q_rst_tb,
    q_num   => q_num_tb
  );
end;