library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lcd_2_line is
port ( 
	clk : in std_logic;    							--clock i/p
    rw	: out std_logic;   						--read & write control
	e 	: out std_logic;   						--enable control
	rs	: out std_logic;   						--data or command control
	data  	: out std_logic_vector(7 downto 0));   	--data line
end lcd_2_line;

architecture Behavioral of lcd_2_line is
constant N: integer := 39; 
type arr is array (1 to N) of std_logic_vector(7 downto 0); 
constant datas : arr := (
						x"38", x"0c", x"06", x"01", x"80",
						x"57", x"65", x"6c", x"6c", x"63", x"6f", x"6d", x"65", x"20", x"74", x"6f", x"20", x"46", x"50", x"47", x"41",
						x"c0", -- xuong dong (22)
						x"70", x"72", x"6f", x"67", x"72", x"61", x"6d", x"20", x"74", x"65", x"73", x"74", x"5f", x"6b", x"69", x"74", x"20"
						); --command and data to display                                              

begin
rw <= '0';  --lcd write
process(clk)
variable i : integer := 0;
variable j : integer := 1;
begin

if clk'event and clk = '1' then
	if i <= 10000000 then
		i := i + 1;
		e <= '1';
		data <= datas(j)(7 downto 0);
	elsif i > 10000000 and i < 20000000 then
		i := i + 1;
		e <= '0';
	elsif i = 20000000 then
		j := j + 1;
		i := 0; 
	end if;
	if j <= 5  then
		rs <= '0'; 		--command signal
	elsif j = 22 then
		rs <= '0';
	else
		rs <= '1';   --data signal
	end if;
	if j > 39 then  --repeated display of data
		j := 5;
	end if;
end if;

end process;
end Behavioral;
