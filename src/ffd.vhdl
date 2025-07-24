entity ffd is
  port (
    clk_i  : in bit;
    d_i    : in bit;
    arst_i : in bit;
    q_o    : out bit
  );
end;

architecture ffd_arq of ffd is
  -- parte declarativa
begin
  process (clk_i, arst_i)
  begin
    if arst_i = '1' then
      q_o <= '0';
    elsif clk_i'event and clk_i = '1' then
      q_o <= d_i;
    end if;
  end process;
end;