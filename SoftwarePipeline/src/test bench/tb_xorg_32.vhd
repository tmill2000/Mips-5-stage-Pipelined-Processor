library IEEE;
use IEEE.std_logic_1164.all;

entity tb_xorg_32 is 
 generic(gCLK_HPER	: time := 50 ns);
end tb_xorg_32;

architecture behavior of tb_xorg_32 is 

 -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

 component xorg_32 
  generic(N : integer := 32);
   port(
	i_D0 : in std_logic_vector(N-1 downto 0);
	i_D1 : in std_logic_vector(N-1 downto 0);
	o_O  : out std_logic_vector(N-1 downto 0)
	);
 end component; 

 signal i_D0	: std_logic_vector(31 downto 0);
 signal i_D1	: std_logic_vector(31 downto 0);
 signal o_O	: std_logic_vector(31 downto 0);

begin 

 DUT1: xorg_32 
 port map(
	i_D0 => i_D0,
	i_D1 => i_D1,
	o_O => o_O
	);

  -- Testbench process  
  P_TB: process
  begin
    wait for gCLK_HPER/2;

	i_D0 <= x"0000000F";
	i_D1 <= x"00000001";
	wait for gCLK_HPER*2; --expect 0xF

	i_D0 <= x"000000FF";
	i_D1 <= x"00000001";
	wait for gCLK_HPER*2; --expect 0xFF

	i_D0 <= x"00000002";
	i_D1 <= x"00000001";
	wait for gCLK_HPER*2; --expect 0x3
   
    wait;
  end process;
  
end behavior;
