-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  component ALU is
	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  	port( 
        	Control	     : in std_logic_vector(3 downto 0);
		ALUSrc	     : in std_logic;
		immd 	     : in std_logic_vector(31 downto 0);
		i_RS	     : in std_logic_vector(31 downto 0);
		i_RT         : in std_logic_vector(31 downto 0);
		i_LR	     : in std_logic;
		i_LA	     : in std_logic;
		repl_qb	     : in std_logic_vector(7 downto 0);
		i_amt	     : in std_logic_vector(4 downto 0);
		i_ovfl 	     : in std_logic;
        	o_S          : out std_logic_vector(31 downto 0);
		o_zero	     : out std_logic;
		o_ovfl	     : out std_logic
       );
  end component;

component pc32Bit is
	generic(N : integer := 32);
	port(
	i_CLK        : in std_logic;     -- Clock input
        i_RST        : in std_logic;     -- Reset input
        i_wr         : in std_logic_vector(N-1 downto 0);
        i_we         : in std_logic;
        o_rt         : out std_logic_vector(N-1 downto 0)
	);
end component;

  component control_unit is 
	port(
	instruction     : in std_logic_vector(31 downto 0);
	RegDst		: out std_logic;
	Jump		: out std_logic;
	Branch		: out std_logic;
	mem_read	: out std_logic;
	MemtoReg	: out std_logic;
	MemWr		: out std_logic;
	ALUControl      : out std_logic_vector(3 downto 0);
	ALUSrc		: out std_logic;
	s_LR		: out std_logic;
	s_LA		: out std_logic;
	s_amt		: out std_logic_vector(4 downto 0);
	s_RegWr		: out std_logic;
	signed_ext	: out std_logic;
	ovfl		: out std_logic;
	Halt		: out std_logic;
	bne		: out std_logic;
	beq		: out std_logic;
	jal		: out std_logic;
	jr		: out std_logic;
	repl_qb		: out std_logic_vector(7 downto 0)
	);
  end component;

  component mux2t1_N is
    generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
    port(i_S          : in std_logic;
        i_D0         : in std_logic_vector(N-1 downto 0);
        i_D1         : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0));
  end component;

  component extender_16bit is
    generic(N : integer := 32);
    port(signed_ext : in std_logic;
	 i_D : in std_logic_vector(15 downto 0);
	 o_O : out std_logic_vector(N-1 downto 0)
	);  
  end component;

  component mips_register_file is
        generic(N : integer := 32);
        port(
		i_CLK           : in std_logic;     -- Clock input
       		i_RST        : in std_logic;     -- Reset input
       		i_WE	     : in std_logic;
       		i_rs	     : in std_logic_vector(4 downto 0);
       		i_rd         : in std_logic_vector(4 downto 0);
       		i_rt         : in std_logic_vector(4 downto 0);
       		i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       		o_Q1         : out std_logic_vector(N-1 downto 0);  -- Data value output
       		o_Q2         : out std_logic_vector(N-1 downto 0));
  end component;

   component n_bit_register is 
       generic(N : integer := 32);
       port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));  -- Data value output
 end component;

  component full_adder_N_ripple_carry is
      generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
       port(i_D0          : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);
       i_C	     : in std_logic;
       o_S           : out std_logic_vector(N-1 downto 0);
       o_C	     : out std_logic);
  end component;

  component andg2 is
	 port(i_A          : in std_logic;
              i_B          : in std_logic;
              o_F          : out std_logic);
  end component;

  component IF_ID_register is
	port(
	i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_WE         : in std_logic;
       i_upc        : in std_logic_vector(31 downto 0);
       i_imem       : in std_logic_vector(31 downto 0);
       o_upc        : out std_logic_vector(31 downto 0);          
       o_imem       : out std_logic_vector(31 downto 0)
  );
  end component;

 component invg is
	port(
	i_A: in std_logic;
	o_F: out std_logic
	);
 end component;

component ID_EX_register is
	port(
	i_CLK        : in std_logic;     -- Clock input
        i_RST        : in std_logic;
	i_WE         : in std_logic;
        i_RegDst       : in std_logic;
        i_mem_read     : in std_logic;
        i_MemtoReg     : in std_logic;
        i_MemWr        : in std_logic;
        i_ALUControl   : in std_logic_vector(3 downto 0);
        i_ALUSrc       : in std_logic;
        i_s_LR         : in std_logic;
        i_s_LA         : in std_logic;
        i_s_amt        : in std_logic_vector(4 downto 0);
        i_s_RegWr      : in std_logic;
        i_jal          : in std_logic;
        i_ovfl         : in std_logic;
        i_Halt         : in std_logic;
        i_repl_qb      : in std_logic_vector(7 downto 0);
        i_readrs       : in std_logic_vector(31 downto 0);
        i_readrt       : in std_logic_vector(31 downto 0);
        i_ext          : in std_logic_vector(31 downto 0);
        i_upc          : in std_logic_vector(31 downto 0);
        i_imem         : in std_logic_vector(31 downto 0);
	i_RegWrAddress : in std_logic_vector(4 downto 0);

        o_RegWrAddress : out std_logic_vector(4 downto 0);	
        o_RegDst       : out std_logic;
        o_mem_read     : out std_logic;
        o_MemtoReg     : out std_logic;
        o_MemWr        : out std_logic;
        o_ALUControl   : out std_logic_vector(3 downto 0);
        o_ALUSrc       : out std_logic;
        o_s_LR         : out std_logic;
        o_s_LA         : out std_logic;
        o_s_amt        : out std_logic_vector(4 downto 0);
        o_s_RegWr      : out std_logic;
        o_jal          : out std_logic;
        o_ovfl         : out std_logic;
        o_Halt         : out std_logic;
        o_repl_qb      : out std_logic_vector(7 downto 0);
        o_readrs       : out std_logic_vector(31 downto 0);
        o_readrt       : out std_logic_vector(31 downto 0);
        o_ext          : out std_logic_vector(31 downto 0);
        o_upc          : out std_logic_vector(31 downto 0);
        o_imem         : out std_logic_vector(31 downto 0)
	);
end component;


component EX_MEM_register is
  port(
	i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_WE         : in std_logic;
       i_RegDst       : in std_logic;
       i_mem_read     : in std_logic;
       i_MemtoReg     : in std_logic;
       i_MemWr        : in std_logic;
       i_s_RegWr      : in std_logic;
       i_jal          : in std_logic;
       i_Halt         : in std_logic;
       i_ALUOut       : in std_logic_vector(31 downto 0);
       i_readrt       : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);
       i_RegWrAddress : in std_logic_vector(4 downto 0);

       o_RegWrAddress : out std_logic_vector(4 downto 0);
       o_RegDst       : out std_logic;
       o_mem_read     : out std_logic;
       o_MemtoReg     : out std_logic;
       o_MemWr        : out std_logic;
       o_s_RegWr      : out std_logic;
       o_jal          : out std_logic;
       o_Halt         : out std_logic;
       o_ALUOut       : out std_logic_vector(31 downto 0);
       o_readrt       : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0)
  );
end component;

component MEM_WB_register is
  port(
       i_CLK          : in std_logic;     -- Clock input
       i_RST          : in std_logic;
       i_WE           : in std_logic;
       i_RegDst       : in std_logic;
       i_MemtoReg     : in std_logic;
       i_s_RegWr      : in std_logic;
       i_jal          : in std_logic;
       i_Halt         : in std_logic;
       i_ALUOut       : in std_logic_vector(31 downto 0);
       i_DmemOut      : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);
       i_RegWrAddress : in std_logic_vector(4 downto 0);

       o_RegWrAddress : out std_logic_vector(4 downto 0);
       o_RegDst       : out std_logic;
       o_MemtoReg     : out std_logic;
       o_s_RegWr      : out std_logic;
       o_jal          : out std_logic;
       o_Halt         : out std_logic;
       o_ALUOut       : out std_logic_vector(31 downto 0);
       o_DmemOut      : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0)
  );
end component;

component org2 is
  port(i_A : in std_logic;
       i_B : in std_logic;
       o_F : out std_logic
  );
end component;

component hazard_unit is
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
	JR	  : in std_logic;
	ID_jal    : in std_logic;
	EX_jal    : in std_logic;
	WB_jal	  : in std_logic;
	
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
end component;

component forwarding_unit is
  port(
    IF_ID_instruction : in std_logic_vector(31 downto 0);
    ID_EX_instruction : in std_logic_vector(31 downto 0);
    EX_MEM_instruction : in std_logic_vector(31 downto 0);
    MEM_WB_instruction : in std_logic_vector(31 downto 0);
    EX_MEM_RegWr: in std_logic;
    MEM_WB_RegWr: in std_logic;
    EX_MEM_RegWrAddress: in std_logic_vector(4 downto 0);
    MEM_WB_RegWrAddress: in std_logic_vector(4 downto 0);
    ID_EX_RegWrAddress: in std_logic_vector(4 downto 0);
    Branch : in std_logic;

	
    RS_mux_select : out std_logic_vector(1 downto 0); --forward B
    RT_mux_select : out std_logic_vector(1 downto 0); --forward A
    Equal_mux_select_RS: out std_logic_vector(1 downto 0);
    Equal_mux_select_Rt: out std_logic_vector(1 downto 0)
  );
end component;



  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment
signal s_RegDst         : std_logic;
signal s_Jump           : std_logic;
signal s_Branch         : std_logic;
signal s_MemtoReg       : std_logic;
signal s_ALUControl     : std_logic_vector(3 downto 0);
signal s_ALUSrc         : std_logic;
signal s_signed_ext     : std_logic;
signal s_immd 		: std_logic_vector(N-1 downto 0);
signal s_RS             : std_logic_vector(N-1 downto 0);
signal s_RT             : std_logic_vector(N-1 downto 0);
signal s_UpdatedPC	: std_logic_vector(N-1 downto 0);
signal s_PCData		: std_logic_vector(N-1 downto 0);
signal iPCData		: std_logic_vector(N-1 downto 0);
signal s_ALUOut 	: std_logic_vector(N-1 downto 0);
signal s_MemWr		: std_logic;
signal PCSrc		: std_logic;

signal branch_jump_amt  : std_logic_vector(N-1 downto 0);
signal s_BranchAdd 	: std_logic_vector(N-1 downto 0);
signal o_FetchMux1	: std_logic_vector(N-1 downto 0);
signal s_JumpInst	: std_logic_vector(N-1 downto 0);

signal s_shiftLR	: std_logic;
signal s_shiftArith	: std_logic;
signal s_shiftAmt	: std_logic_vector(4 downto 0);
signal s_zero		: std_logic;
signal s_beq		: std_logic;
signal s_bne		: std_logic;
signal should_branch	: std_logic;
signal s_jal		: std_logic;
signal s_JalAddress     : std_logic_vector(N-1 downto 0);
signal s_mux_dst	: std_logic_vector(4 downto 0);
signal s_mem_to_reg	: std_logic_vector(N-1 downto 0);
signal s_jr		: std_logic;
signal s_JumpInst2	: std_logic_vector(N-1 downto 0);
signal s_repl_qb	: std_logic_vector(7 downto 0);
signal s_ovfl_o		: std_logic;
signal ovfl_allowed 	: std_logic;
signal s_equal          : std_logic;

--TEMP

  signal temp_s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal temp_s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal temp_s_RegWrData    : std_logic_vector(N-1 downto 0);
  signal temp_Halt :std_logic;

--IF
signal IF_updatedPC :std_logic_vector(31 downto 0);
signal IF_instruction :std_logic_vector(31 downto 0);
signal IF_RegWrAddress :std_logic_vector(4 downto 0);

--ID
signal ID_RegDst :std_logic;
signal ID_MemRead :std_logic;
signal ID_MemToReg :std_logic;
signal ID_ALUControl :std_logic_vector(3 downto 0);
signal ID_MemWr :std_logic;
signal ID_ALUSrc :std_logic;
signal ID_s_RegWr :std_logic;
signal ID_jal :std_logic;
signal ID_Halt :std_logic;
signal ID_repl_qb :std_logic_vector(7 downto 0);
signal ID_s_LA :std_logic;
signal ID_s_amt :std_logic_vector(4 downto 0);
signal ID_s_LR :std_logic;
signal ID_ovfl_allowed :std_logic;
signal ID_RS :std_logic_vector(31 downto 0);
signal ID_RT :std_logic_vector(31 downto 0);
signal ID_updatedPC :std_logic_vector(31 downto 0);
signal ID_immd :std_logic_vector(31 downto 0);
signal ID_instruction :std_logic_vector(31 downto 0);
signal ID_RegWrAddress: std_logic_vector(4 downto 0);

--EX
signal EX_RegDst :std_logic;
signal EX_MemRead :std_logic;
signal EX_MemToReg :std_logic;
signal EX_MemWr :std_logic;
signal EX_s_RegWr :std_logic;
signal EX_Halt :std_logic;
signal EX_jal :std_logic;
signal EX_instruction :std_logic_vector(31 downto 0);
signal EX_ALUOut :std_logic_vector(31 downto 0);
signal EX_RT :std_logic_vector(31 downto 0);
signal EX_updatedPC :std_logic_vector(31 downto 0);
signal EX_RegWrAddress: std_logic_vector(4 downto 0);

--WB
signal WB_RegDst :std_logic;
signal WB_MemToReg :std_logic;
signal WB_s_RegWr :std_logic;
signal WB_Halt :std_logic;
signal WB_jal :std_logic;
signal WB_instruction :std_logic_vector(31 downto 0);
signal WB_ALUOut :std_logic_vector(31 downto 0);
signal WB_MemOut :std_logic_vector(31 downto 0);
signal WB_updatedPC :std_logic_vector(31 downto 0);
signal WB_RegWrAddress: std_logic_vector(4 downto 0);

--STALL
signal s_Stall_IF: std_logic;
signal s_Stall_ID: std_logic;
signal s_Stall_EX: std_logic;
signal s_Stall_WB: std_logic;
signal s_Stall_PC: std_logic;

--Flush
signal s_Flush_IF: std_logic;
signal s_Flush_ID: std_logic;
signal s_Flush_EX: std_logic;
signal s_Flush_WB: std_logic;

signal o_Flush_IF: std_logic;
signal o_Flush_ID: std_logic;
signal o_Flush_EX: std_logic;
signal o_Flush_WB: std_logic;


signal s_mux_updated_pc: std_logic_vector(31 downto 0);
signal s_mux_instruction: std_logic_vector(31 downto 0);

--FORWARDING
signal forward_a_select: std_logic_vector(1 downto 0);
signal forward_b_select: std_logic_vector(1 downto 0);
signal forwarded_equal_rs_select: std_logic_vector(1 downto 0);
signal forwarded_equal_rt_select: std_logic_vector(1 downto 0);


signal forwarded_rs: std_logic_vector(31 downto 0);
signal forwarded_rt: std_logic_vector(31 downto 0);
signal forwarded_equal_rs: std_logic_vector(31 downto 0);
signal forwarded_equal_rt: std_logic_vector(31 downto 0);

signal inverted_clock: std_logic;



begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
 

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 
------------------IF-------------


PCSrc <= '1' when s_Jump = '1' else
     	 '1' when s_Branch  = '1'else
	 '1' when s_jr = '1' else
         '0';

PCSrcMux: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => PCSrc,
		i_D0 => s_UpdatedPC,
		i_D1 => s_PCData,
		o_O => iPCData
	);

 PCReg : pc32Bit
 	port map(i_CLK => iCLK,
	  i_RST => iRST,
	  i_we => s_Stall_PC,
	  i_wr => iPCData, 
	  o_rt => s_NextInstAddr);

 PCAdder : full_adder_N_ripple_carry
 port map(i_D0 => s_NextInstAddr,
	  i_D1 => x"00000004",
	  i_C => '0',
	  o_S => s_UpdatedPC,
	  o_C => open);

--IF_ID_ORG_FLUSH: org2
--port map(
 -- i_A => iRST,
 -- i_B => s_Flush_IF,
 -- o_F => o_Flush_IF
--);
MUX_UPDATED_PC: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => s_Flush_IF,
		i_D0 => s_updatedPC,
		i_D1 => x"00400000",
		o_O => s_mux_updated_pc
	);

MUX_INST: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => s_Flush_IF,
		i_D0 => s_Inst,
		i_D1 => x"00000000",
		o_O => s_mux_instruction
	);

IF_REG: IF_ID_register

port map(
       i_CLK => iCLK,      
       i_RST => iRST,   
       i_WE => s_Stall_IF,    
       i_upc => s_mux_updated_pc,       
       i_imem => s_mux_instruction,      
       o_upc => IF_updatedPC,               
       o_imem => IF_instruction    
);


------------------ID---------------
  CONTROL: control_unit
	port map(
		instruction => IF_instruction,
		RegDst => s_RegDst,
		Jump => s_Jump,
		Branch => s_Branch,
		mem_read => open,
		MemtoReg => s_MemtoReg,
		MemWr => s_MemWr,
		ALUControl => s_ALUControl,
		ALUSrc => s_ALUSrc,
		s_RegWr => temp_s_RegWr,
		signed_ext => s_signed_ext,
		Halt => temp_Halt,
		s_LR => s_shiftLR,
		s_LA => s_shiftArith,
		s_amt => s_shiftAmt,
		bne => s_bne,
		beq => s_beq,
		jal => s_jal,
		jr => s_jr,
		ovfl => ovfl_allowed,
		repl_qb => s_repl_qb
	);


IF_RegWrAddress <= IF_instruction(15 downto 11) when s_RegDst = '1' else IF_instruction(20 downto 16);

INVERTED_CLOCKG: invg 
	port map(
	i_A => iCLK,
	o_F => inverted_clock
	);

  MIPS_REGISTER_FILE0: mips_register_file 
	port map(
		i_CLK => inverted_clock,
		i_RST => iRST,
		i_WE => s_RegWr,
		i_rs => IF_instruction(25 downto 21),
		i_rt => IF_instruction(20 downto 16),
		i_rd => s_RegWrAddr,
		i_D => s_RegWrData,
		o_Q1 => s_RS,
		o_Q2 => s_RT
		
	);


--HAZARD UNIT

HAZARD_DETECTION_UNIT: hazard_unit
	port map(
		IF_instruction => IF_instruction,
		ID_instruction => ID_instruction,
		EX_instruction => EX_instruction,
		WB_instruction => WB_instruction,
		ID_EX_RD  => ID_RegWrAddress,
		IF_ID_RS  => IF_instruction(25 downto 21),
		IF_ID_RT  => IF_instruction(20 downto 16),
		iMemInstruction => s_mux_instruction,
    		EX_MEM_RD => EX_RegWrAddress,
		MEM_WB_RD => WB_RegWrAddress,
		Jump      => s_Jump,
    		Branch    => s_Branch,
    		JR        => s_jr,
		ID_jal    => ID_jal,
		EX_jal    => EX_jal,
		WB_jal    => WB_jal,
	
		Stall_IF => s_Stall_IF,
		Stall_ID => s_Stall_ID,
		Stall_EX => s_Stall_EX,
		Stall_WB => s_Stall_WB,
		Stall_PC => s_Stall_PC,
		Flush_IF => s_Flush_IF,
		Flush_ID => s_Flush_ID,
		Flush_EX => s_Flush_EX,
		Flush_WB => s_Flush_WB
	);





-----

BIT_EXTENDER: extender_16bit
	port map(
		signed_ext => s_signed_ext,
		i_D => IF_instruction(15 downto 0),
		o_O => s_immd
	);

forwarded_equal_rs <= s_RS when forwarded_equal_rs_select = "00" else
	               s_ALUOut when forwarded_equal_rs_select = "10" else
		       EX_ALUOut when forwarded_equal_rs_select = "01" else
		       x"00000000";
forwarded_equal_rt <= s_RT when forwarded_equal_rt_select = "00" else
	               s_ALUOut when forwarded_equal_rt_select = "10" else
		       EX_ALUOut when forwarded_equal_rt_select = "01" else
		       x"00000000";
	               


s_equal <= '1' when (forwarded_equal_rt = forwarded_equal_rs) else '0';

branch_jump_amt(31 downto 0) <= s_immd(29 downto 0) & "00";



 JumpAdder : full_adder_N_ripple_carry
 port map(i_D0 => IF_updatedPC,
	  i_D1 => branch_jump_amt,
	  i_C => '0',
	  o_S => s_BranchAdd,
	  o_C => open);

should_branch <= '1' when((s_equal = '1' and s_beq = '1' and s_Branch = '1') or (s_equal = '0' and s_bne = '1' and s_Branch = '1')) 
else '0';


 FETCH_MUX_1: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => should_branch,
		i_D0 => IF_updatedPC,
		i_D1 => s_BranchAdd,
		o_O => o_FetchMux1
	);

 s_JumpInst(31 downto 0) <= (IF_updatedPC(31 downto 28) & (IF_instruction(25 downto 0) & "00"));

 FETCH_MUX_2: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => s_Jump,
		i_D0 => o_FetchMux1,
		i_D1 => s_JumpInst,
		o_O => s_JumpInst2
	);

 FETCH_MUX_3: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => s_jr,
		i_D0 => s_JumpInst2,
		i_D1 => s_RS,
		o_O => s_PCData
	);

 
ID_EX_ORG_FLUSH: org2
port map(
  i_A => iRST,
  i_B => s_Flush_ID,
  o_F => o_Flush_ID
);


ID_register: ID_EX_register
port map(
	i_CLK  => iCLK,      
        i_RST  => o_Flush_ID,   
        i_WE   => s_Stall_ID,  
        i_RegDst  => s_RegDst,    
        i_mem_read  => '0', --hardcoded don't use this signal atm   
        i_MemtoReg  => s_MemToReg,   
        i_MemWr   => s_MemWr,    
        i_ALUControl => s_ALUControl, 
        i_ALUSrc => s_ALUSrc,      
        i_s_LR   => s_shiftLR ,     
        i_s_LA   => s_shiftArith,      
        i_s_amt   => s_shiftAmt,    
        i_s_RegWr  => temp_s_RegWr,    
        i_jal    => s_jal, 
        i_ovfl     => ovfl_allowed,
        i_Halt      => temp_Halt ,  
        i_repl_qb  => s_repl_qb,    
        i_readrs   => s_RS,    
        i_readrt   => s_RT,    
        i_ext  	   => s_immd,        
        i_upc      => IF_updatedPC,   
        i_imem     => IF_instruction,   
	i_RegWrAddress => IF_RegWrAddress, 
        o_RegWrAddress => ID_RegWrAddress,
        o_RegDst   => ID_RegDst,    
        o_mem_read  => ID_MemRead,   
        o_MemtoReg   => ID_MemtoReg,  
        o_MemWr      => ID_MemWr,  
        o_ALUControl  => ID_ALUControl, 
        o_ALUSrc     => ID_ALUSrc,  
        o_s_LR       => ID_s_LR,  
        o_s_LA       => ID_s_LA,
        o_s_amt      => ID_s_amt, 
        o_s_RegWr    => ID_s_RegWr,  
        o_jal        => ID_jal, 
        o_ovfl       => ID_ovfl_allowed,  
        o_Halt        => ID_Halt, 
        o_repl_qb     => ID_repl_qb ,
        o_readrs       => ID_RS,
        o_readrt       => ID_RT,
        o_ext          => ID_immd,
        o_upc          => ID_updatedPC,
        o_imem         => ID_instruction
);



----------EX------------



DATA_FORWARDING_UNIT: forwarding_unit 
  port map(
    IF_ID_instruction => IF_instruction,
    ID_EX_instruction => ID_instruction,
    EX_MEM_instruction => EX_Instruction,
    MEM_WB_instruction => WB_instruction,
    EX_MEM_RegWr => EX_s_RegWr,
    MEM_WB_RegWR => WB_s_RegWr,
    MEM_WB_RegWrAddress => WB_RegWrAddress,
    EX_MEM_RegWrAddress => EX_RegWrAddress,
    ID_EX_RegWrAddress => ID_RegWrAddress,
    Branch             => s_Branch,
	
    RS_mux_select => forward_a_select,
    RT_mux_select => forward_b_select,
    Equal_mux_select_RS => forwarded_equal_rs_select,
    Equal_mux_select_RT => forwarded_equal_rt_select
  );

  forwarded_rs <= ID_RS     when (forward_a_select = "00") else
                  EX_ALUOut when (forward_a_select = "10") else
                  s_RegWrData when(forward_a_select = "01") else
                    x"00000000";


  forwarded_rt <= ID_RT when (forward_b_select = "00") else
                  EX_ALUOut when (forward_b_select = "10") else
                  s_RegWrData when(forward_b_select = "01") else
                  x"00000000";



  ALU_UNIT: ALU
	port map(
		Control => ID_ALUControl,
		ALUSrc => ID_ALUSrc,
		immd => ID_immd,
		i_RS => forwarded_rs,
		i_RT => forwarded_rt,
		i_LR => ID_s_LR,
		i_LA => ID_s_LA,
		i_amt => ID_s_amt,
		i_ovfl => ID_ovfl_allowed,
		o_S => s_ALUOut,
		o_zero => s_zero,
		repl_qb => ID_repl_qb,
		o_ovfl => s_ovfl_o
	);

s_Ovfl <= s_ovfl_o; 

--10 bit address signal from ALU
--s_DMemAddr <= s_ALUOut;

EX_MEM_ORG_FLUSH: org2
port map(
  i_A => iRST,
  i_B => s_Flush_EX,
  o_F => o_Flush_EX
);

EX_register: EX_MEM_register
port map(
       i_CLK  => iCLK,      
       i_RST   => o_Flush_EX,  
       i_WE    => s_Stall_EX,   
       i_RegDst  => ID_RegDst,     
       i_mem_read  => ID_MemRead,   
       i_MemtoReg  => ID_MemtoReg,   
       i_MemWr     => ID_MemWr,   
       i_s_RegWr   => ID_s_RegWr,   
       i_jal       => ID_jal,  
       i_Halt      => ID_Halt,   
       i_ALUOut    => s_ALUOut,   
       i_readrt    => forwarded_rt,   
       i_upc       => ID_updatedPC,   
       i_imem      => ID_instruction,
       i_RegWrAddress => ID_RegWrAddress,   
  
       o_RegWrAddress => EX_RegWrAddress,
       o_RegDst     => EX_RegDst,  
       o_mem_read   => EX_MemRead,  
       o_MemtoReg   => EX_MemtoReg,  
       o_MemWr      => EX_MemWr,  
       o_s_RegWr    => EX_s_RegWr,  
       o_jal        => EX_jal,  
       o_Halt       => EX_Halt,  
       o_ALUOut     => EX_ALUOut,  
       o_readrt     => EX_RT,  
       o_upc        => EX_updatedPC,  
       o_imem       => EX_instruction  
);

----------- MEM -----------

DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => EX_ALUOut(11 downto 2),
             data => EX_RT,
             we   => EX_MemWr,
             q    => s_DMemOut);
s_DMemWr <= EX_MemWr;
s_DMemAddr <= EX_ALUOut;
s_DMemData <= EX_RT;

MEM_WB_ORG_FLUSH: org2
port map(
  i_A => iRST,
  i_B => s_Flush_WB,
  o_F => o_Flush_WB
);

WB_register: MEM_WB_register
port map(
       i_CLK => iCLK,      
       i_RST => o_Flush_WB, 
       i_WE  => s_Stall_WB,      
       i_RegDst => EX_RegDst,      
       i_MemtoReg  => EX_MemtoReg,  
       i_s_RegWr   => EX_s_RegWr,  
       i_jal       => EX_jal,   
       i_Halt      => EX_Halt,  
       i_ALUOut    => EX_ALUOut,
       i_DmemOut   => s_DMemOut,  
       i_upc       => EX_updatedPC,   
       i_imem      => EX_instruction, 
       i_RegWrAddress => EX_RegWrAddress,
  
       o_RegWrAddress => WB_RegWrAddress,
       o_RegDst    => WB_RegDst,   
       o_MemtoReg  => WB_MemtoReg,   
       o_s_RegWr   => WB_s_RegWr,   
       o_jal       => WB_jal,   
       o_Halt      => WB_Halt,  
       o_ALUOut    => WB_ALUOut,
       o_DmemOut   => WB_MemOut,  
       o_upc       => WB_updatedPC,   
       o_imem      => WB_instruction   
);




-------------------WB--------------

 oALUOut <= WB_ALUOut;
  MUX_MEM_TO_REG: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => WB_MemToReg,
		i_D0 => WB_ALUOut,
		i_D1 => WB_MemOut,
		o_O => s_mem_to_reg
	);

    JAL_MUX_data: mux2t1_N
	generic map(N => 32)
	port map(
		i_S => WB_jal,
		i_D0 => s_mem_to_reg,
		i_D1 => WB_UpdatedPC,
		o_O => s_RegWrData
	);
	

  MUX_REG_DST: mux2t1_N
	generic map(N => 5)
	port map(
		i_S => WB_RegDst,
		i_D0 => WB_instruction(20 downto 16),
		i_D1 => WB_instruction(15 downto 11),
		o_O => s_mux_dst
	);

  JAL_MUX_DST: mux2t1_N
	generic map(N => 5)
	port map(
		i_S => WB_jal,
		i_D0 => s_mux_dst,
		i_D1 => "11111",
		o_O => s_RegWrAddr

	);
s_Halt <= WB_Halt;
s_RegWr <= WB_s_RegWr;



  

end structure;
