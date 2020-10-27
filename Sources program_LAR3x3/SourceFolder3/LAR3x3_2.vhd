library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-----------------------------------------
entity LAR3x3 is
port( Pin: in std_logic_vector(7 downto 0);
		clk, Ce, reset : in std_logic;
		
		P1,P2,P3,P4,P5,P6,P7,P8,P9: out std_logic_vector(7 downto 0);
		Pout : out std_logic_vector(7 downto 0));
end LAR3x3;

architecture Behavioral of LAR3x3 is
	----------------------------------------------package
	component LAR is
	port( Din 				: in std_logic_vector(7 downto 0);
			clk, Ce, reset : in std_logic;		
			P1, P2, P3, SortieLAR : out std_logic_vector(7 downto 0) -- SortieLAR = dou (de la FIFO)
			);
	end component;
	----------------------------------------------end package
	signal S1, S2:std_logic_vector(7 downto 0);
	----------------------------------------------
begin
	
	u1: LAR port map(Pin, clk, Ce, reset , P1,P2,P3,S1 );
	u2: LAR port map(S1, clk, Ce , reset , P4,P5,P6,S2 );
	u3: LAR port map(S2, clk, Ce , reset , P7,P8,P9,Pout );
	
end Behavioral;




--------------------------------------------------------------------------------------------
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
-------------------------------------------
--entity LAR3x3 is
--port( Pin: in std_logic_vector(7 downto 0);
--		clk, Ce, reset : in std_logic;
--		
--		P1,P2,P3,P4,P5,P6,P7,P8,P9: out std_logic_vector(7 downto 0);
--		 Pout : out std_logic_vector(7 downto 0)
--		);
--end LAR3x3;
--
--architecture Behavioral of LAR3x3 is
--	----------------------------------------------package
--	component LAR is
--	port( Din : 			  in std_logic_vector(7 downto 0);
--			clk, Ce, reset : in std_logic;
--			
----			s_prog_full : inout std_logic;
----			s_full : 		OUT STD_LOGIC;
----			s_empty : 		OUT STD_LOGIC;
----			s_data_count :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
--			P1, P2, P3, SortieLAR : out std_logic_vector(7 downto 0) -- SortieLAR = dou (de la FIFO)
--			);
--	end component;
--	----------------------------------------------------
--	---- Moyenneur et Convolution
----	component Moyenneur is ------- Moyenneur avant les modif de la dimension du Bus
----	port( P1, P2, P3, P4, P6, P7, P8, P9 : in std_logic_vector(15 downto 0);
----			P5: in std_logic_vector(15 downto 0);-- entrée pour faire la convolution.
----				clk, Ce : in std_logic ;
----				
----			Sortie_Moy_8P, Sortie_Moy_9P : out std_logic_vector(15 downto 0)
----			);
----	end component;
--	-------
--------		component Moyenneur is
--------	port( P1, P2, P3, P4, P6, P7, P8, P9 : in std_logic_vector(15 downto 0);
--------			P5: in std_logic_vector(15 downto 0);-- entrée pour faire la convolution.
--------				clk, Ce : in std_logic ;
--------				
--------			Sortie_Moy_8P, Sortie_Moy_9P : out std_logic_vector(11 downto 0)
--------			);
--------	 ----------
--------	end component;
--------	component convolution_1 is
--------	port( P1, P2, P3, P4, P5, P6, P7, P8, P9 : in std_logic_vector(7 downto 0);
--------			C1, C2, C3, C4, C5, C6, C7, C8, C9: in std_logic_vector(7 downto 0);
--------				clk, Ce : in std_logic ;
--------				
--------			Sortie_Convolution : out std_logic_vector(7 downto 0)
--------			);
--------	end component;
--------------------------------------------------------------------------fin package
--	-----# Declaration des Signaux pour les lignes de retard :(u1, u2, u3)
--------	signal signal_prog_full, signal_full, signal_empty: STD_LOGIC:= '0'; 
--------	signal signal_data_count: STD_LOGIC_VECTOR(3 DOWNTO 0); 
--	signal S1, S2:std_logic_vector(7 downto 0);
--	-----#Fin de declaration.
--	
--	-----# Declaration des Signaux pour le  composant "convolution_1" :( u5 ).
--------	signal signal_Sortie_Moy_8P : std_logic_vector(15 downto 0):= (others => '0'); 
--------	signal M1, M2, M3, M4, M5, M6, M7, M8, M9 : std_logic_vector(15 downto 0):= (others => '0'); 
--
--	
--begin
--	
--	----# 1er étage pour avoir les 9 pixels du Filtre 3x3:
----u1: LAR port map(Pin, clk, Ce, reset,signal_prog_full, signal_full, signal_empty,signal_data_count,P1,P2,P3,S1 );
----u2: LAR port map(S1, clk, Ce, reset,signal_prog_full, signal_full, signal_empty,signal_data_count,P4,P5,P6,S2 );
----u3: LAR port map(S2, clk, Ce, reset,signal_prog_full, signal_full, signal_empty,signal_data_count,P7,P8,P9,Pout );
--u1: LAR port map(Pin, clk, Ce, reset , P1,P2,P3,S1 );
--u2: LAR port map(S1, clk, Ce , reset , P4,P5,P6,S2 );
--u3: LAR port map(S2, clk, Ce , reset , P7,P8,P9,Pout );
----
----	---- 2éme étage pour calculer la Moyenne (Le composants "Moyenneur" a 2 Sorties:--> Sortie_Moy_8P: calcule la Moyenne de 8 Pixels.
----	----																									  --> Sortie_Moy_9P: calcule la Moyenne de 9 Pixels. 
----u4:Moyenneur port map(P1,P2,P3,P4,P5,P6,P7,P8,P9, clk, Ce, Sortie_Moy_8P, Sortie_Moy_9P);
----	
----	---- 3éme étage pour calculer la Convolution:
----
----u5:convolution_1 port map( P1, P2, P3, P4, P5, P6, P7, P8, P9,
----									C1, C2, C3, C4, C5, C6, C7, C8, C9,
----									clk, Ce,
----									Sortie_Convolution );--Sortie_Convolution	 doit etre ajoutée dans le composant principal.
--	
--end Behavioral;


