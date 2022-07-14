-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- add_sub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity andg_32 is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port( 
        i_D0 : in std_logic_vector(N-1 downto 0);
	i_D1 : in std_logic_vector(N-1 downto 0);
	o_O  : out std_logic_vector(N-1 downto 0)
       );

end andg_32;

architecture mixed of andg_32 is

component andg2 is
port(
       i_A : in std_logic;
       i_B : in std_logic;
       o_F : out std_logic);
end component;

 signal And_O : std_logic_vector(31 downto 0);
 
begin

	G_NBIT_AND: for i in 0 to N-1 generate
		ANDI: andg2 port map(
		i_A => i_D0(i),
		i_B => i_D1(i),
		o_F => o_O(i));
	end generate G_NBIT_AND;


	
end mixed;