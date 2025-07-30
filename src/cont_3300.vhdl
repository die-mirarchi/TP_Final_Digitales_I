entity cont_3300 is
  port (
    clk_i   : in bit;
    rst_i   : in bit;
    en_i    : in bit;
    q_en_o  : out bit;
    q_rst_o : out bit;
    q_num   : out bit_vector(11 downto 0)
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

  signal d_vec, q_vec, next_vec : bit_vector(11 downto 0);
  signal rst_total, rst_cont    : bit;
begin
  rst_total <= rst_cont or rst_i;
  d_vec(0)  <= '1';
  cont_nbin_gen : for i in 0 to 11 generate
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
  cont_out_gen : for i in 1 to 11 generate
    d_vec(i) <= next_vec(i - 1);
  end generate cont_out_gen;
  -- Reset when q_vec is 3301
  rst_cont <= q_vec(11) and q_vec(10) and (not q_vec(9)) and (not q_vec(8)) and
    q_vec(7) and q_vec(6) and q_vec(5) and (not q_vec(4)) and
    (not q_vec(3)) and q_vec(2) and (not q_vec(1)) and q_vec(0);
  q_rst_o <= rst_cont;
  -- Reset when q_vec is 3300
  q_en_o <= q_vec(11) and q_vec(10) and (not q_vec(9)) and (not q_vec(8)) and
    q_vec(7) and q_vec(6) and q_vec(5) and (not q_vec(4)) and
    (not q_vec(3)) and q_vec(2) and (not q_vec(1)) and (not q_vec(0));
end;