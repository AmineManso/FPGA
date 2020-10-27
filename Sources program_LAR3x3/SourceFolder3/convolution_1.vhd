	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity convolution_1 is
port( P1, P2, P3, P4, P5, P6, P7, P8, P9 : in std_logic_vector(7 downto 0);-- Pixels. 
		C1, C2, C3, C4, C5, C6, C7, C8, C9: in std_logic_vector(7 downto 0);--Coéfficients de convolution.
			clk, Ce : in std_logic ;														
			
--		Sortie_Convolution : out std_logic_vector(7 downto 0) --(15 downto 0)
		Sortie_Convolution : out std_logic_vector(11 downto 0) --(15 downto 0)
		);
end convolution_1;
 ----------------------------------------------
architecture Behavioral of convolution_1 is
    --------------------------------------------------------
  component Moyenneur is
	port( P1, P2, P3, P4, P6, P7, P8, P9 : in std_logic_vector(7 downto 0);--(15 downto 0);
			P5: in std_logic_vector(7 downto 0);-- entrée pour faire la convolution.
			clk, Ce : in std_logic ;
			
			Sortie_Moy_8P, Sortie_Moy_9P : out std_logic_vector(11 downto 0)  --(15 downto 0);
		);
		end component;
----------------------------------------------
	--signal signal_somme: std_logic_vector(7 downto 0):= (others => '0');
	signal signal_Sortie_Moy_8P : std_logic_vector(11 downto 0):= (others => '0'); 
	signal M1, M2, M3, M4, M5, M6, M7, M8, M9 : std_logic_vector(15 downto 0):= (others => '0'); 
begin
	process(clk)
	begin
		M1 <=	C1*P1;
		M2 <= C2*P2;
		M3 <= C3*P3;
		M4 <= C4*P4;
		M5 <= C5*P5;
		M6 <= C6*P6;
		M7 <= C7*P7;
		M8 <= C8*P8;
		M9 <= C9*P9;
		if(M1> x"FF")then M1 <= x"00FF";end if;
		if(M2> x"FF")then M2 <= x"00FF";end if;
		if(M3> x"FF")then M3 <= x"00FF";end if;
		if(M4> x"FF")then M4 <= x"00FF";end if;
		if(M5> x"FF")then M5 <= x"00FF";end if;
		if(M6> x"FF")then M6 <= x"00FF";end if;
		if(M7> x"FF")then M7 <= x"00FF";end if;
		if(M8> x"FF")then M8 <= x"00FF";end if;
		if(M9> x"FF")then M9 <= x"00FF";end if;
	end process;
u0:Moyenneur port map(M1(7 downto 0),M2(7 downto 0),M3(7 downto 0),M4(7 downto 0),M5(7 downto 0),
							M6(7 downto 0),M7(7 downto 0),M8(7 downto 0),M9(7 downto 0),
--							clk, Ce, signal_Sortie_Moy_8P(7 downto 0),Sortie_Convolution );
							clk, Ce, signal_Sortie_Moy_8P, Sortie_Convolution );

end Behavioral;