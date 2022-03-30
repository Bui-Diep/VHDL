-- entity lcd_control is
	-- port (
		-- clk : in std_logic;
		-- bt, sw : in std_logic;
		-- rs, rw, e : out std_logic;
		-- data : out std_logic_vector (7 downto 0)
		-- );
-- end lcd_control;

-- entity buzzer_top is
	-- port (
		-- clk : in std_logic; -- 50mzh
		-- en : in std_logic; -- enable
		-- bz_out : out std_logic -- beep
		-- );
-- end buzzer_top;

library ieee;
use ieee.std_logic_1164.all;
entity lcd_control_top is
	port (
		clk : in std_logic;
		bt, sw : in std_logic;
		rs, rw, e : out std_logic;
		data : out std_logic_vector (7 downto 0);
		bz_out : out std_logic -- beep
		);
end lcd_control_top;
architecture datafollow of lcd_control_top is
component buzzer_top is
	port (
		clk : in std_logic; -- 50mzh
		en : in std_logic; -- enable
		bz_out : out std_logic -- beep
		);
end component;
component lcd_control is
	port (
		clk : in std_logic;
		bt, sw : in std_logic;
		rs, rw, e : out std_logic;
		data : out std_logic_vector (7 downto 0)
		);
end component;
signal en : std_logic;
begin

process (bt, sw)
begin
if bt = '0' then 
	en <= '0';
elsif sw = '0' then
	en <= '0';
else en <= '1';
end if;
end process
;
dut_3 : component buzzer_top 
	port map (clk, en, bz_out);
dut_4 : component lcd_control
	port map (clk, bt, sw, rs, rw, e, data);
end datafollow;


