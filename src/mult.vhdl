entity mult is
  port (
    entrs_i : in BIT_VECTOR(1 downto 0);
    selec   : in bit;
    s_o     : out bit
  );
end;

architecture mult_arq of mult is
  -- parte declarativa
begin
  s_o <= (selec and entrs_i(0)) or (not selec and entrs_i(1));
end;