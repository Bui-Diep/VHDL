library ieee;
use ieee.std_logic_1164.all;
entity buzzer is
	port (
		clk : in std_logic;
		pause : in std_logic;
		bz_out : out std_logic
		);
end buzzer;
architecture behav of buzzer is
signal clk_temp : std_logic := '0';
begin	
process (clk, pause)
variable count : integer range 0 to 20000;
begin
if pause = '0' then
	if rising_edge (clk) then
		if count = 18500 then
			count := 0;
			clk_temp <= not (clk_temp);
		else count := count + 1;
		end if;
	end if;
else clk_temp <= '0';
		count := 0;
end if;
end process;
bz_out <= clk_temp;
end behav;
