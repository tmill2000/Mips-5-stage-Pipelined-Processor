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

entity add_sub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(A             : in std_logic_vector(N-1 downto 0);
       B             : in std_logic_vector(N-1 downto 0);
       nAdd_Sub	     : in std_logic;
       ALUSrc	     : in std_logic;
       immd          : in std_logic_vector(N-1 downto 0);
       o_S           : out std_logic_vector(N-1 downto 0);
       o_C	     : out std_logic;
       o_ovfl        : out std_logic);

end add_sub_N;

architecture structural of add_sub_N is

 component full_adder_N_ripple_carry is
   port(i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);
       i_C	     : in std_logic;
       o_S           : out std_logic_vector(N-1 downto 0);
       o_C	     : out std_logic;
       o_ovfl        : out std_logic);
 end component;

component onesComplement_N is
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component mux2t1_N is
generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   port(i_S         : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;


signal inv_B	      : std_logic_vector(N-1 downto 0);
signal mux_O          : std_logic_vector(N-1 downto 0); 
signal mux1_O	      : std_logic_vector(N-1 downto 0);
signal mux2_O          : std_logic_vector(N-1 downto 0); 
signal inv_immd		: std_logic_vector(N-1 downto 0);

begin


 
INVERTER: onesComplement_N port map(
i_A => B,
o_F => inv_B);

INVERTER_IMMD: onesComplement_N port map(
i_A => immd,
o_F => inv_immd);


MUX: mux2t1_N port map(
i_S     => nAdd_Sub,
i_D0    => B,
i_D1    => inv_B,
o_O      => mux_O); 

MUX1: mux2t1_N port map(
i_S     => nAdd_Sub,
i_D0    => immd,
i_D1    => inv_immd,
o_O      => mux1_O); 

MUX2: mux2t1_N port map(
i_S => ALUSrc,
i_D0 => mux_O,
i_D1 => mux1_O,
o_O => mux2_O
);

ADDER: full_adder_N_ripple_carry port map(
i_D0 => A,
i_D1 => mux2_O,
i_C => nAdd_Sub,
o_S => o_S,
o_C => o_C,
o_ovfl => o_ovfl
);



  
end structural;
