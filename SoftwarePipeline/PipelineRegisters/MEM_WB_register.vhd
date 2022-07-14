--Noah Peake
--MEM_WB_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_WB_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_RegDst       : in std_logic;
       i_MemtoReg     : in std_logic;
       i_s_RegWr      : in std_logic;
       i_jal          : in std_logic;
       i_Halt         : in std_logic;
       i_ALUOut       : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);

       o_RegDst       : out std_logic;
       o_MemtoReg     : out std_logic;
       o_s_RegWr      : out std_logic;
       o_jal          : out std_logic;
       o_Halt         : out std_logic;
       o_ALUOut       : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0);
);

end MEM_WB_register;

architecture structural of MEM_WB_register is

begin

  RegDstreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_RegDst,
             o_Q => o_RegDst);

  MemtoRegreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_MemtoReg,
             o_Q => o_MemtoReg);

  RegWrreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_s_RegWr,
             o_Q => o_s_RegWr);

  jalreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_jal,
             o_Q => o_jal);

  Haltreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_Halt,
             o_Q => o_Halt);

  ALUOutreg: N_Bit_Register
    generic map(N => 32)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_ALUOut,
             o_Q => o_ALUOut);

  PCReg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_upc,
             o_Q => o_upc);

  ImemReg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_imem,
             o_Q => o_imem);

end structural;
