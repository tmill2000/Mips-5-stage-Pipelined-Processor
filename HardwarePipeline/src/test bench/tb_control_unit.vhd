-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mips_data_path.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the n bit register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_control_unit is
  generic(gCLK_HPER   : time := 50 ns);
end tb_control_unit;

architecture behavior of tb_control_unit is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component control_unit
    port(	            
       		instruction     : in std_logic_vector(31 downto 0);
		RegDst		: out std_logic;
		Jump		: out std_logic;
		Branch		: out std_logic;
		mem_read	: out std_logic;
		MemtoReg	: out std_logic;
		MemWr		: out std_logic;
		bne		: out std_logic;
		beq		: out std_logic;
		ALUControl      : out std_logic_vector(3 downto 0);
		ALUSrc		: out std_logic;
                s_LR            : out std_logic;
                s_LA            : out std_logic;
                s_amt           : out std_logic_vector(4 downto 0);
		s_RegWr		: out std_logic;
		signed_ext	: out std_logic;
		jal		: out std_logic;
		jr		: out std_logic;
		Halt		: out std_logic
      );
  end component;

  -- Temporary signals

        signal instruction      : std_logic_vector(31 downto 0);
	signal bne		: std_logic;
	signal beq		: std_logic;
	signal s_LR		: std_logic;
	signal s_LA		: std_logic;
	signal s_amt		: std_logic_vector(4 downto 0);
	signal jal		: std_logic;
	signal jr		: std_logic;
	signal Halt		: std_logic; 
	signal ALUSrc		: std_logic;
	signal ALUControl       : std_logic_vector(3 downto 0);
	signal MemtoReg	        : std_logic;
	signal MemWr		: std_logic;
	signal s_RegWr		: std_logic;
	signal RegDst		: std_logic;
	signal Jump		: std_logic;
	signal Branch		: std_logic;
	signal mem_read	        : std_logic;
	signal signed_ext	: std_logic;

	

  
begin

  DUT: control_unit
  port map(
	instruction => instruction,  
	ALUSrc => ALUSrc,
	ALUControl  => ALUControl,
	MemtoReg => MemtoReg,  
	s_RegWr	=> s_RegWr, 
	MemWr => MemWr,
	RegDst	=> RegDst,
	Jump => Jump,	
	Branch => Branch,	
	mem_read => mem_read,
	signed_ext => signed_ext,
	bne => bne,
	beq => beq,
	s_LR => s_LR,
	s_LA => s_LA,
	s_amt => s_amt,
	jal => jal,
	jr => jr,
	Halt => Halt
       );

  
  -- Testbench process  
  P_TB: process
  begin
    wait for gCLK_HPER;

	instruction <= x"00FFFF20"; --expect output of add instruction
	wait for gCLK_HPER;

	instruction <= x"00FFFF21"; --expect addu instruction 
	wait for gCLK_HPER;

	instruction <= x"00FFFF22"; --expect sub Output
	wait for gCLK_HPER;

	instruction <= x"00FFFF23"; --expect output of subu instruction
	wait for gCLK_HPER;

	instruction <= x"00FFFF24"; --expect output of AND instruction
	wait for gCLK_HPER;

	instruction <= x"00FFFF27"; --expect output of NOR instruction 
	wait for gCLK_HPER;

	instruction <= x"00FFFF26"; --expect output of XOR instruction
	wait for gCLK_HPER;

	instruction <= x"00FFFF25"; --expect output of OR instruction
	wait for gCLK_HPER;

	instruction <= x"00FFFF2A"; --expect output of SLT instruction 
	wait for gCLK_HPER;

	instruction <= x"00FFFF00"; --expect output of SLL instruction 
	wait for gCLK_HPER;

	instruction <= x"00FFFF03"; --expect output of SRA instruction 
	wait for gCLK_HPER;

	instruction <= x"00FFFF02"; --expect output of SRL instruction 
	wait for gCLK_HPER;

	instruction <= x"00FFFF08"; --expect output of JR instruction 
	wait for gCLK_HPER; 

	instruction <= x"08FFFFFF"; --expect output of j instruction
	wait for gCLK_HPER;

	instruction <= x"0CFFFFFF"; --expect output of jal instruction
	wait for gCLK_HPER;

	instruction <= x"20FFFF23";--expect output of addi instruction
	wait for gCLK_HPER; 

	instruction <= x"24FFFF23"; --expect output of addiu instruction
	wait for gCLK_HPER;

	instruction <= x"30FFFF23"; --expect output of ANDI instruction 
	wait for gCLK_HPER;

	instruction <= x"3CFFFF23"; --expect output of LUI instruction 
	wait for gCLK_HPER;

	instruction <= x"8CFFFF00"; --expect output of LW instruction
	wait for gCLK_HPER; 

	instruction <= x"38FFFF23"; --expect output of XORI instruction 
	wait for gCLK_HPER; 

	instruction <= x"34FFFF23"; --expect output of ORI instruction 
	wait for gCLK_HPER;

	instruction <= x"28FFFFFF"; --expect output of slti instruction
	wait for gCLK_HPER;

	instruction <= x"ACFFFF23"; --expect output of SW instruction 
	wait for gCLK_HPER;

	instruction <= x"10FFFF23"; --expect output of BEQ instruction 
	wait for gCLK_HPER;

	instruction <= x"14FFFF23"; --expect output of BNE instruction
	wait for gCLK_HPER;

	instruction <= x"7CFFFF23"; --expect output of repl_qb instruction 
	wait for gCLK_HPER;

	instruction <= x"50FFFFFF"; --expect output of halt instruction
	wait for gCLK_HPER;
	


	


    wait;
  end process;
  
end behavior;
