-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- full_adder_N_ripple_carry.vhd
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

entity full_adder_N_ripple_carry is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D0          : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);
       i_C	     : in std_logic;
       o_S           : out std_logic_vector(N-1 downto 0);
       o_C	     : out std_logic;
       o_ovfl	     : out std_logic
      );

end full_adder_N_ripple_carry;

architecture structural of full_adder_N_ripple_carry is

 component full_adder is
   port(i_D0          : in std_logic;
	i_D1          : in std_logic;
	i_C           : in std_logic;
	o_S           : out std_logic;
        o_C           : out std_logic);
 end component;

 component xorg2 is
	port(
	i_A          : in std_logic;
        i_B          : in std_logic;
        o_F          : out std_logic
	);
 end component;

signal s_C	      : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate N adder instances.
u_full_adder: full_adder port map (	
     i_D0 => i_D0(0),
     i_D1 => i_D1(0),
     i_C  => i_C,
     o_S  => o_S(0),
     o_C  => s_C(0));

 G_NBit_Adder: for i in 1 to N-1 generate
   FULLADDERI: full_adder port map(
             i_D0     => i_D0(i), 
             i_D1     => i_D1(i),
	     i_C      => s_C(i-1),
	     o_S      => o_S(i),
	     o_C      => s_C(i)); 
  end generate G_NBit_Adder;


G_XOR_OVFL: xorg2 port map(
	i_A => s_C(N-2),
	i_B => s_C(N-1),
	o_F => o_ovfl
);

o_C <= s_C(N-1);




  
end structural;