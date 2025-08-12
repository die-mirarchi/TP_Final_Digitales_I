entity cont_3300 is
  port (
    clk_i   : in bit;
    rst_i   : in bit;
    en_i    : in bit;
    q_en_o  : out bit;
    q_rst_o : out bit;
    q_num   : out bit_vector(18 downto 0) -- Changed from 11 to 18 (19 bits)
  );
end;

architecture cont_3300_arq of cont_3300 is
  component cont_nbit is
    port (
      enable_i : in bit; -- Habilitación del contador
      reset_i  : in bit; -- Reset del contador
      clock_i  : in bit; -- Reloj
      en_d_i   : in bit; -- Habilitación de datos
      q0_out   : out bit; -- Salida del bit
      next_out : out bit -- Señal de carry
    );
  end component;

  signal d_vec, q_vec, next_vec : bit_vector(18 downto 0); -- Changed from 11 to 18 for 19 bits
  signal rst_total, rst_cont    : bit;

begin
  rst_total <= rst_cont or rst_i;
  d_vec(0)  <= '1';
  cont_nbin_gen : for i in 0 to 18 generate -- Changed from 11 to 18
    cont_nbin_gen_i : cont_nbit
    port map
    (
      enable_i => en_i,
      reset_i  => rst_total,
      clock_i  => clk_i,
      en_d_i   => d_vec(i),
      q0_out   => q_vec(i),
      next_out => next_vec(i)
    );
    q_num(i) <= q_vec(i);
  end generate cont_nbin_gen;
  cont_out_gen : for i in 1 to 18 generate -- Changed from 11 to 18
    d_vec(i) <= next_vec(i - 1);
  end generate cont_out_gen;

  -- Reset at 330001 (binary: 1010000100100010001)
  rst_cont <= q_vec(18) and (not q_vec(17)) and q_vec(16) and (not q_vec(15)) and
    (not q_vec(14)) and (not q_vec(13)) and (not q_vec(12)) and q_vec(11) and
    (not q_vec(10)) and (not q_vec(9)) and q_vec(8) and (not q_vec(7)) and
    (not q_vec(6)) and (not q_vec(5)) and q_vec(4) and
    (not q_vec(3)) and (not q_vec(2)) and (not q_vec(1)) and q_vec(0);
  q_rst_o <= rst_cont;

  -- Enable at 330000 (binary: 1010000100100010000)
  q_en_o <= q_vec(18) and (not q_vec(17)) and q_vec(16) and (not q_vec(15)) and
    (not q_vec(14)) and (not q_vec(13)) and (not q_vec(12)) and q_vec(11) and
    (not q_vec(10)) and (not q_vec(9)) and q_vec(8) and (not q_vec(7)) and
    (not q_vec(6)) and (not q_vec(5)) and q_vec(4) and
    (not q_vec(3)) and (not q_vec(2)) and (not q_vec(1)) and (not q_vec(0));
end;