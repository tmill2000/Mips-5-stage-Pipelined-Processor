library IEEE;
use IEEE.std_logic_1164.all;

entity xorg_32 is 
	generic(N : integer := 32);
	port(
		i_D0 : in std_logic_vector(N-1 downto 0);
		i_D1 : in std_logic_vector(N-1 downto 0);
		o_O  : out std_logic_vector(N-1 downto 0)	
	);

end xorg_32;

architecture mixed of xorg_32 is 

component xorg2 is 
 port(
       i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic
 );

end component xorg2; 

 signal Xor_O : std_logic_vector(31 downto 0);

begin 

	G_NBIT_XOR: for i in 0 to N-1 generate 
		XORI: xorg2 port map(
		i_A => i_D0(i),
		i_B => i_D1(i),
		o_F => o_O(i));
	end generate G_NBIT_XOR;

end mixed; 

