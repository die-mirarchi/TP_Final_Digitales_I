entity mux_4b_tb is
end;

architecture mux_4b_tb_arq of mux_4b_tb is
  component mux_4b is
    port (
      q0_i    : in bit_vector(3 downto 0);
      q1_i    : in bit_vector(3 downto 0);
      q2_i    : in bit_vector(3 downto 0);
      selec   : in bit_vector(2 downto 0);
      mux_out : out bit_vector(3 downto 0)
    );
  end component;

  signal q0_tb    : bit_vector(3 downto 0);
  signal q1_tb    : bit_vector(3 downto 0);
  signal q2_tb    : bit_vector(3 downto 0);
  signal selec_tb : bit_vector(2 downto 0) := "000";
  signal y_tb     : bit_vector(3 downto 0);
begin
  q0_tb <= "0001";
  q1_tb <= "0010";
  q2_tb <= "0100";

  selec_tb <= "000",
    "001" after 50 ns,
    "010" after 100 ns,
    "011" after 150 ns,
    "100" after 200 ns;

  DUT : mux_4b
  port map
  (
    q0_i    => q0_tb,
    q1_i    => q1_tb,
    q2_i    => q2_tb,
    selec   => selec_tb,
    mux_out => y_tb
  );
end architecture;
