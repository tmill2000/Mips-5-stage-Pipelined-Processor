library IEEE;
use IEEE.std_logic_1164.all;

entity fetch_unit is 
	port(
		i_CLK	: in std_logic; 
		i_Reset	: in std_logic; 
		o_instruction	: out std_logic_vector(31 downto 0)
		
	);

end fetch_unit;

architecture structural of fetch_unit is 

 component full_adder_N_ripple_carry is 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D0          : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);
       i_C	     : in std_logic;
       o_S           : out std_logic_vector(N-1 downto 0);
       o_C	     : out std_logic);

 end component; 

 component mem is 
	generic 
	(DATA_WIDTH : natural := 32;
	 ADDR_WIDTH : natural := 10);
	port 
	(clk		: in std_logic;
	 addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
	 data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
	 we		: in std_logic := '1';
	 q		: out std_logic_vector((DATA_WIDTH -1) downto 0));

 end component; 

 component n_bit_register is 
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));  -- Data value output
 
 end component;

signal s_UpdatedPC	: std_logic_vector(31 downto 0);
signal s_PCoutput	: std_logic_vector(31 downto 0);

begin 

PCReg : n_bit_register 
 port map(i_CLK => i_CLK,
	  i_RST => i_Reset,
	  i_WE => '1',
	  i_D => s_UpdatedPC, 
	  o_Q => s_PCoutput);

Adder : full_adder_N_ripple_carry
 port map(i_D0 => s_PCoutput,
	  i_D1 => x"00000004",
	  i_C => '0',
	  o_S => s_UpdatedPC,
	  o_C => open);

Instruction_mem : mem
 port map(clk => i_CLK,
	  addr => s_PCoutput(9 downto 0), 
	  data => x"00000000",
	  we => '0',
	  q => o_instruction);

end structural; 












