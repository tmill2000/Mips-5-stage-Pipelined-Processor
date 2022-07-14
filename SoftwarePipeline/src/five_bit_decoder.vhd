-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- five_bit_decoder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: Implementation of a 2:1 multiplexer
--
-- NOTES:
-- 8/29/21
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity five_bit_decoder is

  port(i_S		            : in std_logic_vector(4 downto 0);
       o_O		            : out std_logic_vector(31 downto 0));

end five_bit_decoder;


architecture dataflow of five_bit_decoder is

begin

o_O <=  x"00000001" when (i_S = "00000") else
	x"00000002" when (i_S = "00001") else
	x"00000004" when (i_S = "00010") else
	x"00000008" when (i_S = "00011") else
	x"00000010" when (i_S = "00100") else
	x"00000020" when (i_S = "00101") else
	x"00000040" when (i_S = "00110") else
	x"00000080" when (i_S = "00111") else
	x"00000100" when (i_S = "01000") else
	x"00000200" when (i_S = "01001") else
	x"00000400" when (i_S = "01010") else
	x"00000800" when (i_S = "01011") else
	x"00001000" when (i_S = "01100") else
	x"00002000" when (i_S = "01101") else
	x"00004000" when (i_S = "01110") else
	x"00008000" when (i_S = "01111") else
	x"00010000" when (i_S = "10000") else
	x"00020000" when (i_S = "10001") else
	x"00040000" when (i_S = "10010") else
	x"00080000" when (i_S = "10011") else
	x"00100000" when (i_S = "10100") else
	x"00200000" when (i_S = "10101") else
	x"00400000" when (i_S = "10110") else
	x"00800000" when (i_S = "10111") else
	x"01000000" when (i_S = "11000") else
	x"02000000" when (i_S = "11001") else
	x"04000000" when (i_S = "11010") else
	x"08000000" when (i_S = "11011") else
	x"10000000" when (i_S = "11100") else
	x"20000000" when (i_S = "11101") else
	x"40000000" when (i_S = "11110") else
	x"80000000";

end dataflow;