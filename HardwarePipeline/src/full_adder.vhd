-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- full_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a behavioral 
-- register that delays the input by one clock cycle. 
--
--
-- NOTES: Integer data type is not typically useful when doing hardware
-- design. We use it here for simplicity, but in future labs it will be
-- important to switch to std_logic_vector types and associated math
-- libraries (e.g. signed, unsigned). 


-- 1/14/18 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is

  port(
        i_D0               : in std_logic;
	i_D1               : in std_logic;
	i_C                : in std_logic;
        o_S                : out std_logic;
        o_C                : out std_logic);

end full_adder;

architecture structure of full_adder is

 component andg2
    port(i_A            : in std_logic;
	 i_B		: in std_logic;
	 o_F		: out std_logic);
  end component;

   component org2
    port(i_A		: in std_logic;
	 i_B		: in std_logic;
	 o_F		: out std_logic);
  end component;

 component xorg2
    port(i_A		: in std_logic;
	 i_B		: in std_logic;
	 o_F		: out std_logic);
  end component;

  --Signal to carry xor od D1 and D0
  signal s_xorD		: std_logic;
  --signal to carry the output of the and of D1 and D0
  signal s_andD	        : std_logic;
  --signal to carry the output of the carry bit and s_xorD
  signal s_andC        : std_logic;


begin

 --Level 0
g_xorD: xorg2
	port MAP(
		i_A	=> i_D0,
		i_B	=> i_D1,
		o_F	=> s_xorD
		);
g_xorSD: xorg2
	port MAP(
		i_A	=> s_xorD,
		i_B	=> i_C,
		o_F	=> o_S
		);
g_and2: andg2
	port MAP(
		i_A	=> i_D0,
		i_B	=> i_D1,
		o_F	=> s_andD
		);
g_andCsD: andg2
	port MAP(
		i_A	=> i_C,
		i_B	=> s_xorD,
		o_F	=> s_andC
		);
g_orC: org2
	port MAP(
		i_A	=> s_andC,
		i_B	=> s_andD,
		o_F	=> o_C
		);
  
end structure;