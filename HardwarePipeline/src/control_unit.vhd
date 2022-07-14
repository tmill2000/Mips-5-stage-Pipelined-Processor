-- Quartus Prime VHDL Template
-- Single-port RAM with single read/write address

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is

	

	port 
	(
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
		ovfl		: out std_logic;
		jr		: out std_logic;
		Halt		: out std_logic;
		repl_qb		: out std_logic_vector(7 downto 0)
	);

end control_unit;



architecture mixed of control_unit is

	signal opCode : std_logic_vector(31 downto 26);
	signal func : std_logic_vector(5 downto 0);

begin
	opCode <= instruction(31 downto 26);
	func <= instruction(5 downto 0);
	repl_qb <= instruction(23 downto 16);
        s_amt <= instruction(10 downto 6);
	mem_read <= '0'; --unused signal atm

	process(opCode, func) is
	begin
	if opCode = "000000" then  -- R format
		if func = "100000" then --ADD
			ALUSrc <= '0';
			ALUControl <= "0010";
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '1';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '1';

		elsif func = "100001" then --ADDU
			ALUSrc <= '0';
			ALUControl <= "0010";
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "100010" then --SUB
			ALUSrc <= '0';
			ALUControl <= "0110";
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
		        Jump <= '0';
			Branch <= '0';
			signed_ext <= '1';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '1';

		elsif func = "100011" then --SUBU
			ALUSrc <= '0';
			ALUControl <= "0110"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "100100" then --AND
			ALUSrc <= '0';
			ALUControl <= "1000"; -- change
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '1';

		elsif func = "100111" then --NOR
			ALUSrc <= '0';
			ALUControl <= "1100";
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "100110" then --XOR
			ALUSrc <= '0';
			ALUControl <= "1110"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "100101" then --OR
			ALUSrc <= '0';
			ALUControl <= "1010"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "101010" then --SLT
			ALUSrc <= '0';
			ALUControl <= "0001"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '1';
			Halt <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "000000" then --SLL
			ALUSrc <= '0';
			ALUControl <= "1001"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
                        s_LR <= '0';
                        s_LA <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		
		elsif func = "000011" then --SRA
			ALUSrc <= '0';
			ALUControl <= "1001"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
                        s_LR <= '1';
                        s_LA <= '1';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "000010" then --SRL
			ALUSrc <= '0';
			ALUControl <= "1001"; 
			MemtoReg <= '0';
			MemWr <= '0';
			s_RegWr <= '1';
			RegDst <= '1';
			Jump <= '0';
			Branch <= '0';
			signed_ext <= '0';
			Halt <= '0';
                        s_LR <= '1';
                        s_LA <= '0';
			beq <= '0';
			bne <= '0';
			jal <= '0';
			jr <= '0';
			ovfl <= '0';

		elsif func = "001000" then --JR
			ALUSrc <= '0';
			ALUControl <= "XXXX"; 
			MemtoReg <= 'X';
			MemWr <= '0';
			s_RegWr <= '0';
			RegDst <= 'X';
			Jump <= 'X';
			Branch <= 'X';
			signed_ext <= 'X';
			Halt <= '0';
                        s_LR <= 'X';
                        s_LA <= 'X';
			beq <= 'X';
			bne <= 'X';
			jal <= '0';
			jr <= '1';
			ovfl <= '0';

		end if;
		
		
	elsif opCode = "000010" then --J
		ALUSrc <= 'X';
		ALUControl <= "0010";
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '0';
		RegDst <= '0';
		Jump <= '1';
		Branch <= '0';
		signed_ext <= '0';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "000011" then --JAL
		ALUControl <= "XXXX";
		ALUSrc <= 'X';		
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '1';
		Branch <= '0';
		signed_ext <= '0';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '1';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "001000" then --ADDI
		ALUSrc <= '1';
		ALUControl <= "0010";
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '1';
	elsif opCode = "001001" then --ADDIU
		ALUSrc <= '1';
		ALUControl <= "0010"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';
	elsif opCode = "001100" then --ANDI
		ALUSrc <= '1';
		ALUControl <= "1000"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '0';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';
	elsif opCode = "001111" then --LUI
		ALUSrc <= '1';
		ALUControl <= "0101";
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '0';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';
	
	elsif opCode = "100011" then --LW
		ALUSrc <= '1';
		ALUControl <= "0010"; 
		MemtoReg <= '1';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "001110" then --XORI
		ALUSrc <= '1';
		ALUControl <= "1110"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '0';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "001101" then --ORI
		ALUSrc <= '1';
		ALUControl <= "1010"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '0';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "001010" then --SLTI
		ALUSrc <= '1';
		ALUControl <= "0001"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "101011" then --SW
		ALUSrc <= '1';
		ALUControl <= "0010"; 
		MemtoReg <= '0';
		MemWr <= '1';
		s_RegWr <= '0';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "000100" then --BEQ
		ALUSrc <= '1';
		ALUControl <= "0110"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '0';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '1';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '1';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	elsif opCode = "000101" then --BNE
		ALUSrc <= '1';
		ALUControl <= "0110"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '0';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '1';
		signed_ext <= '1';
		Halt <= '0';
		beq <= '0';
		bne <= '1';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';
	elsif opCode = "011111" then --repl_qb
		ALUSrc <= 'X';
		ALUControl <= "1111"; 
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '1';
		RegDst <= '1';
		Jump <= '0';
		Branch <= '0';
		signed_ext <= 'X';
		Halt <= '0';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';


	elsif opCode = "010100" then --HALT
		ALUSrc <= '1';
		ALUControl <= "XXXX";
		MemtoReg <= '0';
		MemWr <= '0';
		s_RegWr <= '0';
		RegDst <= '0';
		Jump <= '0';
		Branch <= '1';
		signed_ext <= '1';
		Halt <= '1';
		beq <= '0';
		bne <= '0';
		jal <= '0';
		jr <= '0';
		ovfl <= '0';

	end if;
	end process;

end mixed;
