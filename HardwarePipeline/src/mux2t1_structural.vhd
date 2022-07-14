-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_structural.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: Implementation of a 2:1 multiplexer
--
-- NOTES:
-- 8/29/21
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity mux2t1_structural is

  port(i_D0		            : in std_logic;
       i_D1		            : in std_logic;
       i_S                          : in std_logic;
       o_O		            : out std_logic);


end mux2t1_structural;

architecture structure of mux2t1_structural is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).
  component andg2
    port(i_A            : in std_logic;
	 i_B		: in std_logic;
	 o_F		: out std_logic);
  end component;

  component invg
    port(i_A		: in std_logic;
	 o_F		: out std_logic);
  end component;

  component org2
    port(i_A		: in std_logic;
	 i_B		: in std_logic;
	 o_F		: out std_logic);
  end component;

  -- Signal to carry the inverted s signal
  signal s_S	        : std_logic;
  -- Signals to carry the anded values 
  signal s_D1, s_D2   	: std_logic;

begin

  ---------------------------------------------------------------------------
  -- Level 0: Invert s
  ---------------------------------------------------------------------------
 
  g_invert_select: invg
    port MAP(i_A	      => i_S,
             o_F              => s_S);


  ---------------------------------------------------------------------------
  -- Level 1: And D1 and D2 with s
  ---------------------------------------------------------------------------
  g_and_select0: andg2
    port MAP(i_A              => i_D0,
             i_B              => s_S,
             o_F              => s_D1);
  
  g_and_select1: andg2
    port MAP(i_A              => i_D1,
             i_B              => i_S,
             o_F              => s_D2);


    
  ---------------------------------------------------------------------------
  -- Level 2: Or gate
  ---------------------------------------------------------------------------
  g_or_final: org2
    port MAP(i_A              => s_D1,
             i_B              => s_D2,
             o_F              => o_O);

    

  end structure;