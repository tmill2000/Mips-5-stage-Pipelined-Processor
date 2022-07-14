-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dmem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains test bench for the dmem module
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dmem is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component mem
   generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);
   port(	            
                clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0));
  end component;

  -- Temporary signals to connect to the dff component.

  signal clk            : std_logic := '0';     -- Clock input
  signal addr           : std_logic_vector(9 downto 0)  := "0000000000";     -- Reset input
  signal data           : std_logic_vector(31 downto 0) := x"00000000";     -- Data value input
  signal we		: std_logic := '1';
  signal q              : std_logic_vector(31 downto 0);

begin

  dmem: mem
  port map(
	clk => clk,
	addr => addr,
	data => data,
	we => we,
	q => q
       );

  P_CLK: process
  begin
    clk <= '0';
    wait for gCLK_HPER;
    clk <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
--read initial values
   addr <= "0000000000";
   wait for gCLK_HPER*2;
   addr <= "0000000001";
   wait for gCLK_HPER*2;
   addr <= "0000000010";
   wait for gCLK_HPER*2;
   addr <= "0000000011";
   wait for gCLK_HPER*2;
   addr <= "0000000100";
   wait for gCLK_HPER*2;
   addr <= "0000000101";
   wait for gCLK_HPER*2;
   addr <= "0000000110";
   wait for gCLK_HPER*2;
   addr <= "0000000111";
   wait for gCLK_HPER*2;
   addr <= "0000001000";
   wait for gCLK_HPER*2;
   addr <= "0000001001";
   wait for gCLK_HPER*2;
   --add values starting ad 0x100
addr <= "0100000000";
   data <= x"FFFFFFFF";
   wait for gCLK_HPER*2;

addr <= "0100000001";
   data <= x"FFFFFFFE";
   wait for gCLK_HPER*2;

addr <= "0100000010";
   data <= x"FFFFFFFD";
   wait for gCLK_HPER*2;

addr <= "0100000011";
   data <= x"FFFFFFFC";
   wait for gCLK_HPER*2;

addr <= "0100000100";
   data <= x"FFFFFFFB";
   wait for gCLK_HPER*2;

addr <= "0100000101";
   data <= x"FFFFFFFA";
   wait for gCLK_HPER*2;

addr <= "0100000110";
   data <= x"FFFFFFF9";
   wait for gCLK_HPER*2;

addr <= "0100000111";
   data <= x"FFFFFFF8";
   wait for gCLK_HPER*2;

addr <= "0100001000";
   data <= x"FFFFFFF7";
   wait for gCLK_HPER*2;

addr <= "0100001001";
   data <= x"FFFFFFF6";
   wait for gCLK_HPER*2;
--Read values back
   addr <=  "0100000000";
   wait for gCLK_HPER*2;
   addr <=  "0100000001";
   wait for gCLK_HPER*2;
   addr <=  "0100000010";
   wait for gCLK_HPER*2;
   addr <=  "0100000011";
   wait for gCLK_HPER*2;
   addr <=  "0100000100";
   wait for gCLK_HPER*2;
   addr <=  "0100000101";
   wait for gCLK_HPER*2;
   addr <=  "0100000110";
   wait for gCLK_HPER*2;
   addr <=  "0100000111";
   wait for gCLK_HPER*2;
   addr <=  "0100001000";
   wait for gCLK_HPER*2;
   addr <=  "0100001001";
   wait for gCLK_HPER*2;


    wait;
  end process;
  
end behavior; 