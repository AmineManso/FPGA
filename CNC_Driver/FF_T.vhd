library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FF_T is
port(T, clk: in std_logic;
      Q : out std_logic
        );
end FF_T;

architecture Behavioral of FF_T is
    signal Qm : std_logic :='0';
begin
    
    Q <= Qm;
    process(clk, T)
    begin
    if(rising_edge(clk) and T = '1') then Qm <= not(Qm); 
    end if;
    end process;

end Behavioral;	