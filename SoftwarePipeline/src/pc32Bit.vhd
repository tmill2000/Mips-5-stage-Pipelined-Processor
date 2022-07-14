-------------------------------------------------------------------------
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- pc32Bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: Implementation of a 32 bit PC register
--
--
-- NOTES:
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity pc32Bit is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_wr         : in std_logic_vector(N-1 downto 0);
       i_we         : in std_logic;
       o_rt         : out std_logic_vector(N-1 downto 0));

end pc32Bit;

architecture structure of pc32Bit is

constant RESET_VAL : std_logic_vector(31 downto 0) := x"00400000";
signal s_Q : std_logic_vector(N-1 downto 0);

begin
    o_rt <= s_Q;

    process(i_CLK, i_RST) 
    begin
        if(i_RST = '1') then
            s_Q <= RESET_VAL;
        elsif (rising_edge(i_CLK)) then
            if (i_we = '1') then
                s_Q <= i_wr;
            end if;
        end if;
    end process;
end structure;
