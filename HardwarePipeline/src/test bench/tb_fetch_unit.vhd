library IEEE;
use IEEE.std_logic_1164.all;

entity tb_fetch_unit is 
 generic(gCLK_HPER  : time := 50 ns);
end tb_fetch_unit;

architecture structural of tb_fetch_unit is 

 constant cCLK_PER : time := gCLK_HPER * 2;

 component fetch_unit 
	port(i_CLK	: in std_logic; 
	     i_Reset	: in std_logic;
	     o_instruction	: out std_logic_vector(31 downto 0));
 end component; 

 signal i_CLK : std_logic;
 signal i_Reset : std_logic; 
 signal o_instruction : std_logic_vector(31 downto 0);

begin 

 Fetch : fetch_unit
 port map(
	i_CLK => i_CLK,
	i_Reset => i_Reset, 
	o_instruction => o_instruction);

 P_CLK: process
 begin
	i_CLK <= '0';
	wait for gCLK_HPER;
	i_CLK <= '1';
	wait for gCLK_HPER;
 end process; 

 P_TB: process
 begin 
  wait for gCLK_HPER/2; 

  i_Reset <= '1';
  wait for gCLK_HPER*2;
  i_Reset <= '0';
	
  wait;
  end process;
end structural; 
 

