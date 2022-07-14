-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mips_data_path.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the n bit register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_andg_32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_andg_32;

architecture behavior of tb_andg_32 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component andg_32
   generic(N : integer := 32);
    port(	            
        i_D0 : in std_logic_vector(N-1 downto 0);
	i_D1 : in std_logic_vector(N-1 downto 0);
	o_O  : out std_logic_vector(N-1 downto 0)
      );
  end component;

  -- Temporary signals to connect to the dff component.


  signal i_D0      : std_logic_vector(31 downto 0);
  signal i_D1      : std_logic_vector(31 downto 0);
  signal o_O       : std_logic_vector(31 downto 0);
  
begin

  DUT: andg_32
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
	wait for gCLK_HPER*2; --expect 0x1

	i_D0 <= x"0000000F";
	i_D1 <= x"0000000F";
	wait for gCLK_HPER*2; --expect 0xF 

	i_D0 <= x"00000015";
	i_D1 <= x"0000000F";
	wait for gCLK_HPER*2; --expect 0x5

	i_D0 <= x"00000000";
	i_D1 <= x"11111111"; 
	wait for gCLK_HPER*2; --expect 0x0 

	i_D0 <= x"11110000";
	i_D1 <= x"00001111";
	wait for gCLK_HPER*2; --expect 0x0

	i_D0 <= x"11111111";
	i_D1 <= x"11110000";
	wait for gCLK_HPER*2; --expect 0x11110000
   
	i_D0 <= x"0000FF00";
	i_D1 <= x"11111111";
	wait for gCLK_HPER*2; --expect 0x00001100

    wait;
  end process;
  
end behavior;
