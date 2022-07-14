-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- N_bit_register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit Register
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity N_Bit_Register is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));  -- Data value output

end N_Bit_Register;

architecture mixed of N_Bit_Register is

component dffg is
 port(
       i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

G_NBit_Reg: for i in 0 to N-1 generate
	RegI: dffg port map(
	i_CLK => i_CLK,
	i_RST => i_RST,
	i_WE =>  i_WE,
	i_D => i_D(i),
	o_Q => o_Q(i)
	);
end generate G_NBit_Reg;


  
end mixed;