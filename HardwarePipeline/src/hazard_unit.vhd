library ieee;
use ieee.std_logic_1164.all;

entity hazard_unit is

port(
	IF_instruction: in std_logic_vector(31 downto 0);
	ID_instruction: in std_logic_vector(31 downto 0);
	EX_instruction: in std_logic_vector(31 downto 0);
	WB_instruction: in std_logic_vector(31 downto 0);
	iMemInstruction: in std_logic_vector(31 downto 0);
	ID_EX_RD  : in std_logic_vector(4 downto 0);
	IF_ID_RS  : in std_logic_vector(4 downto 0);
	IF_ID_RT  : in std_logic_vector(4 downto 0);
        EX_MEM_RD : in std_logic_vector(4 downto 0);
	MEM_WB_RD : in std_logic_vector(4 downto 0);
	Jump      : in std_logic;
        Branch    : in std_logic;
	JR        : in std_logic;
	ID_jal    : in std_logic;
	EX_jal	  : in std_logic;
	WB_jal    : in std_logic;
	--mem_write : in std_logic;
	
	Stall_IF : out std_logic;
	Stall_ID : out std_logic;
	Stall_EX : out std_logic;
	Stall_WB : out std_logic;
	Stall_PC : out std_logic;
	Flush_IF : out std_logic;
	Flush_ID : out std_logic;
	Flush_EX : out std_logic;
	Flush_WB : out std_logic
	
);


end hazard_unit;


architecture structure of hazard_unit is

signal mem_write: std_logic;
signal mem_read: std_logic;
signal i_mem_rs: std_logic_vector(4 downto 0);
signal i_mem_rt: std_logic_vector(4 downto 0);


begin
	mem_write <= '1' when (IF_Instruction(31 downto 26) = "101011" or ID_Instruction(31 downto 26) = "101011" or EX_Instruction(31 downto 26) = "101011" or WB_Instruction(31 downto 26) = "101011") else '0';
	mem_read <= '1' when (IF_Instruction(31 downto 26) = "100011" or ID_Instruction(31 downto 26) = "100011" or EX_Instruction(31 downto 26) = "100011" or WB_Instruction(31 downto 26) = "100011") else '0';
	i_mem_rs <= iMemInstruction(25 downto 21);
	i_mem_rt <= iMemInstruction(20 downto 16);
	Stall_IF <= '1';

	Stall_PC <= '0' when (mem_write = '1' or mem_read = '1') else
		   		'0' when (ID_jal = '1' or (EX_jal = '1') or (WB_jal = '1')) else
		   		'1';

	Stall_ID <= '1';

	Stall_EX <= '1';

	Stall_WB <= '1';


	Flush_IF <= '1' when (Jump = '1') else
		    '1' when (Branch = '1') else
		    '1' when (JR = '1') else
		    '1' when ((ID_jal = '1') or (EX_jal = '1') or (WB_jal = '1')) else 
		    '1' when (mem_write = '1' or mem_read = '1') else
		    '0';
	
	Flush_ID <= '0';

	Flush_EX <= '0';

	Flush_WB <= '0';







end structure;
