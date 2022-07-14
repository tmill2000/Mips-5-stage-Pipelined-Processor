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

entity ALU is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port( 
        Control	     : in std_logic_vector(3 downto 0);
	ALUSrc	     : in std_logic;
        i_LR         : in std_logic;
        i_LA         : in std_logic;
        i_amt        : in std_logic_vector(4 downto 0);
	immd 	     : in std_logic_vector(31 downto 0);
	repl_qb	     : in std_logic_vector(7 downto 0);
	i_RS	     : in std_logic_vector(31 downto 0);
	i_RT         : in std_logic_vector(31 downto 0);
	i_ovfl	     : in std_logic;
        o_zero       : out std_logic;
        o_S          : out std_logic_vector(31 downto 0);
	o_ovfl	     : out std_logic
       );

end ALU;

architecture mixed of ALU is

component add_sub_N is
port(
       A             : in std_logic_vector(N-1 downto 0);
       B             : in std_logic_vector(N-1 downto 0);
       nAdd_Sub	     : in std_logic;
       ALUSrc	     : in std_logic;
       immd          : in std_logic_vector(N-1 downto 0);
       o_S           : out std_logic_vector(N-1 downto 0);
       o_C	     : out std_logic;
       o_ovfl	     : out std_logic);
end component;

component andg_32 is
port(
	i_D0 : in std_logic_vector(N-1 downto 0);
	i_D1 : in std_logic_vector(N-1 downto 0);
	o_O  : out std_logic_vector(N-1 downto 0));
end component;

component org_32 is
port(
	i_D0 : in std_logic_vector(N-1 downto 0);
	i_D1 : in std_logic_vector(N-1 downto 0);
	o_O  : out std_logic_vector(N-1 downto 0));
end component;

component xorg_32 is
port(
	i_D0 : in std_logic_vector(N-1 downto 0);
	i_D1 : in std_logic_vector(N-1 downto 0);
	o_O  : out std_logic_vector(N-1 downto 0));
end component;

component mux2t1_N is
generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   port(i_S         : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component nbit_barrelshifter is
generic(N : integer := 32);
    port(i_S_LR : in std_logic; --Left/Right select: 0 Left/ 1 Right
         i_S_LA : in std_logic; --Logical/Arithmetic select: 0 Log/1 Arith
         i_amt : in std_logic_vector(4 downto 0); --0 bit is no change 1 bit is change (decided per round)
         i_D : in std_logic_vector(N-1 downto 0);
         o_O : out std_logic_vector(N-1 downto 0));
end component;

component onesComplement_N is
  generic( N : integer:= 32);
	port(
	i_A          : in std_logic_vector(N-1 downto 0);
        o_F          : out std_logic_vector(N-1 downto 0)
	);
end component;


 signal immd_or_rt : std_logic_vector(31 downto 0);
 signal Add_O : std_logic_vector(31 downto 0);
 signal Sub_O : std_logic_vector(31 downto 0);
 signal And_O : std_logic_vector(31 downto 0);
 signal Or_O : std_logic_vector(31 downto 0);
 signal BS_O : std_logic_vector(31 downto 0);
 signal Beq_O: std_logic_vector(31 downto 0);
 signal Lui_O : std_logic_vector(31 downto 0);
 signal XOr_O : std_logic_vector(31 downto 0);
 signal less_than: std_logic_vector(31 downto 0);
 signal Nor_O: std_logic_vector(31 downto 0);
 signal repl_qb_O: std_logic_vector(31 downto 0);
 signal overflow_add : std_logic;
 signal overflow_sub : std_logic;


begin
	
	MUX: mux2t1_N port map(
		i_S     => ALUSrc,
		i_D0    => i_RT,
		i_D1    => immd,
		o_O     => immd_or_rt); 

	ADDER: add_sub_N port map(
		A => i_RS,
		B => i_RT,
		nAdd_Sub => '0',
		ALUSrc => ALUSrc,
		immd => immd,
		o_S => Add_O,
		o_C => open,
		o_ovfl => overflow_add
	);

	SUBTRACTOR: add_sub_N port map(
		A => i_RS,
		B => i_RT,
		nAdd_Sub => '1',
		ALUSrc => ALUSrc,
		immd => immd,
		o_S => Sub_O,
		o_C => open,
		o_ovfl => overflow_sub
	);

	BEQ: add_sub_N port map(
		A => i_RS,
		B => i_RT,
		nAdd_Sub => '1',
		ALUSrc => '0',
		immd => immd,
		o_S => Beq_O,
		o_C => open
	);

	ANDG: andg_32 port map(
		i_D0 => i_RS,
		i_D1 => immd_or_rt,
		o_O  => And_O
	);

	ORG : org_32 port map(
		i_D0 => i_Rs,
		i_D1 => immd_or_rt,
		o_O  => Or_O
	);
	
	XORG: xorg_32 port map(
		i_D0 => i_Rs,
		i_D1 => immd_or_rt,
		o_O  => XOr_O
	);
	

        Barrelshift: nbit_barrelshifter
          port map(i_S_LR => i_LR,
                   i_S_LA => i_LA,
                   i_amt => i_amt,
                   i_D => i_RT,
                   o_O => BS_O);

	NORG: onesComplement_N
	  port map(
		i_A => Or_O,
		o_F => Nor_O
		);






o_zero <= '1' when (Beq_O = x"00000000") else '0';
Lui_O <= immd(15 downto 0) & x"0000";
repl_qb_O <= repl_qb & repl_qb & repl_qb & repl_qb;

less_than <= x"00000001" when (Sub_O(31) = '1' and overflow_sub ='0') else 
	     x"00000001" when (Sub_O(31) = '0' and overflow_sub = '1') else
	     x"00000000";

o_ovfl <= overflow_add when(Control = "0010" and i_ovfl = '0') else
	  overflow_sub when(Control = "0110" and i_ovfl = '0') else
	  '0';

o_S <= Add_O when( Control = "0010" ) else
       Sub_O when (Control = "0110" ) else
       And_O when (Control = "1000" ) else
       Or_O when ( Control = "1010") else
       BS_O when ( Control = "1001") else
       Lui_O when (Control = "0101") else
       XOr_O when (Control = "1110") else
       Nor_O when (Control = "1100") else
       less_than when (Control = "0001") else
       repl_qb_O when (Control = "1111") else
       x"00000000";





  
end mixed;
