library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity rom_tb is
end rom_tb;

architecture rom_arq of rom_tb is
  -- Component declaration
  component ROM is
    port (
      char_address : in bit_vector(3 downto 0);
      font_col     : in bit_vector(2 downto 0);
      font_row     : in bit_vector(2 downto 0);
      data_out     : out bit
    );
  end component;

  -- Signals
  signal clk          : std_logic              := '0';
  signal char_address : bit_vector(3 downto 0) := "1010";
  signal font_col     : bit_vector(2 downto 0) := "000";
  signal font_row     : bit_vector(2 downto 0) := "000";
  signal data_out     : bit;

  -- Clock period definition (25MHz = 40ns period)
  constant clk_period : time := 40 ns;

begin
  -- Instantiate the Unit Under Test (UUT)
  uut : ROM
  port map
  (
    char_address => char_address,
    font_col     => font_col,
    font_row     => font_row,
    data_out     => data_out
  );

  -- Clock process
  clk_process : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

  -- Stimulus process
  stim_proc : process (clk)
  begin
    if rising_edge(clk) then
      -- Increment font_col
      case font_col is
        when "000" => font_col <= "001";
        when "001" => font_col <= "010";
        when "010" => font_col <= "011";
        when "011" => font_col <= "100";
        when "100" => font_col <= "101";
        when "101" => font_col <= "110";
        when "110" => font_col <= "111";
        when "111" =>
          font_col <= "000";
          -- When font_col reaches maximum, increment font_row
          case font_row is
            when "000" => font_row <= "001";
            when "001" => font_row <= "010";
            when "010" => font_row <= "011";
            when "011" => font_row <= "100";
            when "100" => font_row <= "101";
            when "101" => font_row <= "110";
            when "110" => font_row <= "111";
            when "111" =>
              font_row <= "000";
              -- When both reach maximum, increment char_address
              case char_address is
                when "0000" => char_address <= "0001";
                when "0001" => char_address <= "0010";
                when "0010" => char_address <= "0011";
                when "0011" => char_address <= "0100";
                when "0100" => char_address <= "0101";
                when "0101" => char_address <= "0110";
                when "0110" => char_address <= "0111";
                when "0111" => char_address <= "1000";
                when "1000" => char_address <= "1001";
                when "1001" => char_address <= "1010";
                when "1010" => char_address <= "1011";
                when "1011" => char_address <= "1100";
                when "1100" => char_address <= "1101";
                when "1101" => char_address <= "1110";
                when "1110" => char_address <= "1111";
                when "1111" => char_address <= "0000";
                when others => char_address <= "0000";
              end case;
            when others => font_row <= "000";
          end case;
        when others => font_col <= "000";
      end case;
    end if;
  end process;

end;