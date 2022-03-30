library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lcd_control is
port ( 
	clk : in std_logic;    							--clock i/p
	sw, bt : in std_logic;
    rw	: out std_logic;   						--read & write control
	e 	: out std_logic;   						--enable control
	rs	: out std_logic;   						--data or command control
	data  	: out std_logic_vector(7 downto 0));   	--data line
end lcd_control;

architecture Behavioral of lcd_control is
type arr_0 is array (1 to 21) of std_logic_vector (7 downto 0);
type arr_1 is array (1 to 21) of std_logic_vector (7 downto 0);
type arr_2 is array (1 to 21) of std_logic_vector (7 downto 0);
type arr_3 is array (1 to 21) of std_logic_vector (7 downto 0);

constant data_0 : arr_0 := ( 
							x"38", x"0c", x"06", x"01", x"80", -- command (5)
							x"57", x"65", x"6c", x"6c", x"63", x"6f", x"6d", x"65", x"20", x"74", x"6f", x"20", x"46", x"50", x"47", x"41" -- Wellcome to FPGA (16)
						);
constant data_1 : arr_1 := (
							x"38", x"0c", x"06", x"01", x"80", -- command (5)
							x"43", x"6c", x"69", x"63", x"6b", x"69", x"6e", x"67", x"20", x"42", x"75", x"74", x"74", x"6f", x"6e", x"20"		-- Clicking Button (15)
						);
constant data_2 : arr_2 := (
							x"38", x"0c", x"06", x"01", x"80", -- command (5)
							x"4f", x"70", x"65", x"6e", x"69", x"6e", x"67", x"20", x"53", x"77", x"69", x"74", x"63", x"68", x"20", x"20"			-- Opening Switch (14)
						);
constant data_3 : arr_3 := (
							x"38", x"0c", x"06", x"01", x"80", -- command (5)
							x"4e", x"6f", x"20", x"73", x"69", x"67", x"6e", x"61", x"6c", x"20", x"21", x"20", x"20", x"20", x"20", x"20" -- No signal ! (11)
							);
signal t : std_logic := '0';
begin

rw <= '0';  --lcd write
process (clk, t)
variable count : integer := 0;
begin 
if rising_edge (clk) then
	if count = 100000000 then -- 2s
		t <= '1' ;
	else count := count + 1;
	end if;
end if;
end process;			
	
process(clk, t, sw, bt)
variable i_0 : integer := 0;
variable j_0 : integer := 1;
variable i_1 : integer := 0;
variable j_1 : integer := 1;
variable i_2 : integer := 0;
variable j_2 : integer := 1;
variable i_3 : integer := 0;
variable j_3 : integer := 1;
begin


if t = '0' then
	if clk'event and clk = '1' then
		if i_0 <= 1000000 then
			i_0 := i_0 + 1;
			e <= '1';
			data <= data_0(j_0)(7 downto 0);
		elsif i_0 > 1000000 and i_0 < 2000000 then
			i_0 := i_0 + 1;
			e <= '0';
		elsif i_0 = 2000000 then
			j_0 := j_0 + 1;
			i_0 := 0; 
		end if;
		if j_0 <= 5  then
			rs <= '0'; 		--command signal
		else
			rs <= '1';   --data signal
		end if;
		if j_0 > 21 then  --repeated display of data
			j_0 := 5;
		end if;
	end if;
----------------------------------------------------------------------------------
elsif t = '1' then
	if bt = '0' then
		if clk'event and clk = '1' then
			if i_1 <= 1000 then
				i_1 := i_1 + 1;
				e <= '1';
				data <= data_1(j_1)(7 downto 0);
			elsif i_1 > 1000 and i_1 < 2000 then
				i_1 := i_1 + 1;
				e <= '0';
			elsif i_1 = 2000 then
				j_1 := j_1 + 1;
				i_1 := 0; 
			end if;
			if j_1 <= 5  then
				rs <= '0'; 		--command signal
			else
				rs <= '1';   --data signal
			end if;
			if j_1 > 21 then  --repeated display of data
				j_1 := 5;
			end if;
		end if;
-------------------------------------------------------------------
	elsif sw = '0' then
	
		if clk'event and clk = '1' then
			if i_2 <= 1000 then
				i_2 := i_2 + 1;
				e <= '1';
				data <= data_2(j_2)(7 downto 0);
			elsif i_2 > 1000 and i_2 < 2000 then
				i_2 := i_2 + 1;
				e <= '0';
			elsif i_2 = 2000 then
				j_2 := j_2 + 1;
				i_2 := 0;
			end if;
			if j_2 <= 5  then
				rs <= '0'; 		--command signal
			else
				rs <= '1';   --data signal
			end if;
			if j_2 > 21 then  --repeated display of data
				j_2 := 5;
			end if;
		end if;
------------------------------------------------------------------------------
	else 

		if clk'event and clk = '1' then
			
			if i_3 <= 1000 then
				i_3 := i_3 + 1;
				e <= '1';
				data <= data_3(j_3)(7 downto 0);
			elsif i_3 > 1000 and i_3 < 2000 then
				i_3 := i_3 + 1;
				e <= '0';
			elsif i_3 = 2000 then
				j_3 := j_3 + 1;
				i_3 := 0; 
			end if;
			if j_3 <= 5  then
				rs <= '0'; 		--command signal
			else
				rs <= '1';   --data signal
			end if;
			if j_3 > 21 then  --repeated display of data
				j_3 := 5;
			end if;
		end if;
	end if;
end if;

end process;
end Behavioral;
