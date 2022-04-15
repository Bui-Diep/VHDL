library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity button is
	port (
		clk_in : in std_logic;
		btn : in std_logic;
		clk_out : out std_logic;
		led : out std_logic_vector (3 downto 0)
		);
end button;
architecture behavioral of button is
signal en : std_logic := '1';
signal clk_temp : std_logic;
begin
process (clk_in, btn, clk_temp, en)
variable count : integer range 0 to 15000000; -- 0.3S
begin
if en = '0' then
	clk_temp <= '0';
elsif en = '1' then
	if rising_edge (btn) then
		clk_temp <= '1';
	end if;
end if;

if clk_temp = '1' then
	if rising_edge (clk_in) then
		if count < 15000000 then
			count := count + 1;
		elsif count = 15000000 then  -- 0,3S
			count := 0;
			en <= '0';
		end if;
	end if;
end if;
		
end process;
clk_out <= clk_temp;
process (clk_temp)
variable count : integer range 0 to 5;
begin
if clk_temp'event and clk_temp = '1' then
	if count < 5 then 
		count := count + 1;
	elsif count = 5 then
		count := 0;
	end if;
end if;
case count is
	when 1 => led(3 downto 0) <= "0111";
	when 2 => led(3 downto 0) <= "1011";
	when 3 => led(3 downto 0) <= "1101";
	when 4 => led(3 downto 0) <= "1110";
	when others => led(3 downto 0) <= "1111";
end case;
end process;	
end behavioral;


