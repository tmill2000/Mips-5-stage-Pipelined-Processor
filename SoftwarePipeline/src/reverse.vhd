--Noah Peake
--reverse.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity reverse is
    generic(N : integer := 32);
    port(i_A : in std_logic_vector(N-1 downto 0);
         i_S: in std_logic; --when 1 then picks the reverse
         o_rev : out std_logic_vector(N-1 downto 0));         
         
end reverse;

architecture mixed of reverse is

  component mux2t1_N is
    generic(N : integer := 32);
    port(i_S                  : in std_logic;
         i_D0                 : in std_logic_vector(N-1 downto 0);
         i_D1                 : in std_logic_vector(N-1 downto 0);
         o_O                  : out std_logic_vector(N-1 downto 0));
  end component;
  
  signal s_revtmp : std_logic_vector(31 downto 0); 

  begin
    
   g_rev: for i in 0 to N-1 generate
     s_revtmp((N-1)-i) <= i_A(i); --rev goes 31 down to 0 as A goes 0 up to 31, reversing the order of each bit
   end generate g_rev;
 
  g_mux: mux2t1_N
    port map(i_S => i_S,
             i_D0 => i_A,
             i_D1 => s_revtmp,
             o_O => o_rev);

  end mixed;
