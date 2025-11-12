-- Contador genérico de N bits (ripple)
entity cont_nbit is
  port (
    en_d_i   : in bit; -- Habilitación de entrada
    reset_i  : in bit; -- Reset sincrónico
    clock_i  : in bit; -- Reloj
    enable_i : in bit; -- Enable
    q0_out   : out bit; -- Salida del bit
    next_out : out bit -- Carry para siguiente bit
  );
end;

architecture cont_nbit_arq of cont_nbit is
  component ffd_sinc is
    port (
      clk_i  : in bit;
      d_in   : in bit;
      srst_i : in bit;
      en_i   : in bit;
      q_out  : out bit
    );
  end component;
  signal q0_aux : bit; -- Estado actual
  signal salXor : bit; -- Próximo estado (toggle)
begin
  -- FF sincrónico para almacenar el bit
  ffd0 : ffd_sinc
  port map
  (
    clk_i  => clock_i,
    d_in   => salXor,
    srst_i => reset_i,
    en_i   => enable_i,
    q_out  => q0_aux
  );

  salXor   <= q0_aux xor en_d_i; -- Toggle cuando habilitado
  q0_out   <= q0_aux; -- Salida del bit
  next_out <= en_d_i and q0_aux; -- Carry para ripple
end;