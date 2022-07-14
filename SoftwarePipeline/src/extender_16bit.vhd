-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mips_data_path.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit Register
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity extender_16bit is
  generic(N : integer := 32);
  port(
	signed_ext : in std_logic;
	i_D : in std_logic_vector(15 downto 0);
	o_O : out std_logic_vector(N-1 downto 0)
	);  
end extender_16bit;

architecture mixed of extender_16bit is



begin

o_O <= std_logic_vector(resize(signed(i_D), o_O'length)) when (i_D(15)='1' and signed_ext = '1') else
	std_logic_vector(resize(unsigned(i_D), o_O'length));





 end mixed;
