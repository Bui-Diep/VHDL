library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity pulse_without_circulation is
	port (
		clk_in : in std_logic; -- 50mhz
		bk : in std_logic;
		clk_out : out std_logic
		);
end pulse_without_circulation;

architecture behav of pulse_without_circulation is
signal clk_temp : std_logic := '0' ;
signal a : integer;
begin
process (clk_in)
variable coutn : integer range 0 to 30000000;
begin
if rising_edge (clk_in) then
	if coutn = 1000000 then
		coutn := 0;
		clk_temp <= not (clk_temp); -- 1 hz
	else coutn := coutn + 1;
	end if;
end if;
end process;
process (clk_temp, bk)
variable coutn_1 : integer range 0 to 6;
begin
if bk = '0' then		
	if rising_edge (clk_temp) then 
		if coutn_1 < 6 then
			coutn_1 := coutn_1 + 1;
		elsif coutn_1 = 6 then
			coutn_1 := 6 ;
		end if;
	end if;
else coutn_1 := 0 ;
end if;
-----------------------------------------
case coutn_1 is

	-- when 0 => clk_out <= 'Z';
	when 1 => clk_out <= '0';
	when 2 => clk_out <= '0';
	when 3 => clk_out <= 'Z';
	when 4 => clk_out <= '0';
	when 5 => clk_out <= '0';
	-- when 6 => clk_out <= 'Z';
	-- when 7 => clk_out <= 'Z';
	-- when 8 => clk_out <= 'Z';
	-- when 9 => clk_out <= 'Z';
	when others => clk_out <= 'Z';
end case;
end process;
end behav;
---------------------------------------------------------------
