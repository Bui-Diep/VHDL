-- entity pulse_without_circulation is
	-- port (
		-- clk_in : in std_logic; -- 50mhz
		-- clk_out : out std_logic
		-- );
-- end pulse_without_circulation;

-- entity buzzer is
	-- port (
		-- clk : in std_logic;
		-- pause : in std_logic;
		-- bz_out : out std_logic
		-- );
-- end buzzer;

-- modul_buzzer_top
library ieee;
use ieee.std_logic_1164.all;
entity buzzer_top is
	port (
		clk : in std_logic; -- 50mzh
		en : in std_logic; -- enable
		bz_out : out std_logic -- beep
		);
end buzzer_top;
architecture structure of buzzer_top is
component pulse_without_circulation is
	port (
		clk_in : in std_logic; -- 50mhz
		bk : in std_logic;
		clk_out : out std_logic -- pulse_without_circulation
		);
end component;
component buzzer is
	port (
		clk : in std_logic; -- 50mhz
		pause : in std_logic; -- active '0'
		bz_out : out std_logic --beep
		);
end component;
signal reg : std_logic ;

begin


Dut_1 : component pulse_without_circulation
	port map (clk, en, reg);
Dut_2 : component buzzer 
	port map (clk, reg, bz_out);
end structure;
