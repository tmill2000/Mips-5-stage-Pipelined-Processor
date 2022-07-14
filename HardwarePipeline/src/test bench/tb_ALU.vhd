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

entity tb_ALU is
  generic(gCLK_HPER   : time := 50 ns);
end tb_ALU;

architecture behavior of tb_ALU is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component ALU
   generic(N : integer := 32);
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
        o_zero       : out std_logic;
        o_S          : out std_logic_vector(31 downto 0);
	o_ovfl 	     : out std_logic
      );
  end component;

  -- Temporary signals to connect to the dff component.

  signal Control   : std_logic_vector(3 downto 0);
  signal ALUSrc    : std_logic;
  signal LR        : std_logic;
  signal LA        : std_logic;
  signal amt       : std_logic_vector(4 downto 0);
  signal o_zero    : std_logic;
  signal immd      : std_logic_vector(31 downto 0);
  signal i_RS      : std_logic_vector(31 downto 0);
  signal i_RT      : std_logic_vector(31 downto 0);
  signal o_S       : std_logic_vector(31 downto 0);
  signal o_ovfl    : std_logic;
  signal repl_qb   : std_logic_vector(7 downto 0);
  
begin

  DUT: ALU
  port map(
	Control => Control,
	ALUSrc => ALUSrc,
	immd => immd,
	i_RS => i_RS,
	i_RT => i_RT,
        i_LR => LR,
        i_LA => LA,
	i_amt => amt, 
	repl_qb => repl_qb,
        o_zero => o_zero,
	o_S => o_S,
	o_ovfl => o_ovfl
       );

  
  -- Testbench process  
  P_TB: process
  begin
    wait for gCLK_HPER/2;

	--addi instruction
	Control  <= "0010";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000000";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- Addi, expect 1 out 

	--addu instruction
	Control  <= "0010";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000001";
	i_RT     <= x"00000001";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- Addu, expect 2 out 

	--add instruction
	Control  <= "0010";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000004";
	i_RT     <= x"00000005";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- Add, expect 9 out 

	--addiu instruction
	Control  <= "0010";
	ALUSrc   <= '1';
	immd     <= x"0000000a";
	i_RS     <= x"00000001";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- Addiu, expect 11 out

	--and instruction
	Control  <= "1000";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000001";
	i_RT     <= x"00000001";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- And, expect 1 out 

	--andi instruction
	Control  <= "1000";
	ALUSrc   <= '1';
	immd     <= x"00000011";
	i_RS     <= x"00000011";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- Andi, expect 0x11 out 

	--lui instruction
	Control  <= "0101";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000000";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- lui, expect  out 

	--lw instruction
	Control  <= "0010";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000000";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- lw, expect  out

	--nor instruction
	Control  <= "1100";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000001";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- nor, expect 0 out  

	--xor instruction
	Control  <= "1110";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000011";
	i_RT     <= x"00000010";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- xor, expect 0x01 out 

	--xori instruction
	Control  <= "1110";
	ALUSrc   <= '1';
	immd     <= x"00000011";
	i_RS     <= x"00000010";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- xori, expect 0x01 out 

	--or instruction
	Control  <= "1010";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000101";
	i_RT     <= x"00000110";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- or, expect 0x111 out 

	--ori instruction
	Control  <= "1010";
	ALUSrc   <= '1';
	immd     <= x"00000101";
	i_RS     <= x"00000110";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- ori, expect 0x111 out 
 
	--slt instruction
	Control  <= "0001";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000001";
	i_RT     <= x"00000002";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- slt, expect 1 out 

	--slti instruction
	Control  <= "0001";
	ALUSrc   <= '1';
	immd     <= x"00000002";
	i_RS     <= x"00000001";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- slti, expect 1 out 

	--sll instruction
	Control  <= "1001";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000000";
	i_RT     <= x"00000001";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00001";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- sll, expect 2 out 

	--sra instruction
	Control  <= "1001";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000000";
	i_RT     <= x"00000001";  
        LR     <= '1';   
        LA     <= '1';
        amt    <="00001";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- sra, expect 0 out 

	--srl instruction
	Control  <= "1001";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000000";
	i_RT     <= x"00000001";  
        LR     <= '1';   
        LA     <= '0';
        amt    <="00001";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- srl, expect 0 out 

	--sw instruction
	Control  <= "0010";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000001";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- sw, expect  out 

	--sub instruction
	Control  <= "0110";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000004";
	i_RT     <= x"00000002";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- sub, expect 2 out 

	--subu instruction
	Control  <= "0110";
	ALUSrc   <= '0';
	immd     <= x"00000000";
	i_RS     <= x"00000004";
	i_RT     <= x"00000002";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- subu, expect 2 out 

	--beq instruction
	Control  <= "0110";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000001";
	i_RT     <= x"00000001";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- beq, expect  out

	--bne instruction
	Control  <= "0110";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000001";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- bne, expect  out 

	--j instruction
	Control  <= "0010";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000000";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <="00000";   
	repl_qb	 <="00000000";
	wait for gCLK_HPER*2; -- j, expect  out 

	--repl_qb instruction
	Control  <= "1111";
	ALUSrc   <= '1';
	immd     <= x"00000001";
	i_RS     <= x"00000000";
	i_RT     <= x"00000000";  
        LR     <= '0';   
        LA     <= '0';
        amt    <= "00000";   
	repl_qb	 <= "00000001";
	wait for gCLK_HPER*2; -- repl_qb, expect  out  

    wait;
  end process;
  
end behavior;
