library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------------
entity LAR3x3_Convoluee_Div9 is
PORT(	DataIn: in std_logic_vector(7 downto 0);
		clk, Ce, reset : in std_logic;
		--Coéfficients de convolution.
		Coef1, Coef2, Coef3, Coef4, Coef5, Coef6, Coef7, Coef8, Coef9: in std_logic_vector(7 downto 0);
		
		DataOut_Div8: out std_logic_vector(15 downto 0); 
		DataOut_Div9: out std_logic_vector(16 downto 0)	); 
end LAR3x3_Convoluee_Div9;
-----------------------------------------------------------------------
architecture Behavioral of LAR3x3_Convoluee_Div9 is
		-------------------------------------------------------
		signal signal_P1,signal_P2,signal_P3,signal_P4,signal_P5,signal_P6,signal_P7,
				 signal_P8,signal_P9, signal_Pout: std_logic_vector(7 downto 0):=(others => '0');
		-----------------------------------------------------------------------Debut Package
		component LAR3x3 is
		port( Pin: in std_logic_vector(7 downto 0);
				clk, Ce, reset : in std_logic;
				
				P1,P2,P3,P4,P5,P6,P7,P8,P9: out std_logic_vector(7 downto 0);
				 Pout : out std_logic_vector(7 downto 0));
		end component;
		-----------
		component convolution_IPCore is
		port(	P1, P2, P3, P4, P5, P6, P7, P8, P9 : in std_logic_vector(7 downto 0);-- Pixels. 
				-----Coéfficients de convolution.
				C1, C2, C3, C4, C5, C6, C7, C8, C9: in std_logic_vector(7 downto 0);
					clk, Ce : in std_logic ;														
					
				Sortie_Convolution : out std_logic_vector(15 downto 0));
		end component;
		---------------
		component convolution_IPCore_Div9 is
		port(	P1, P2, P3, P4, P5, P6, P7, P8, P9 : in std_logic_vector(7 downto 0);-- Pixels. 
				C1, C2, C3, C4, C5, C6, C7, C8, C9: in std_logic_vector(7 downto 0);--Coéfficients de convolution.
					clk, Ce : in std_logic ;														
					
				Sortie_Convolution : out std_logic_vector(15 downto 0);-- sortie 1 du composant de convolution.
				Sortie_Convolution_Div9 : out std_logic_vector(16 downto 0) --sortie 2 de convolution, division par 9.
				);
		end component;
--------------------------------------------------
		-----------------------------------------------------------------------Fin Package
begin
	
	v1:LAR3x3 port map(DataIn, clk, Ce, reset, signal_P1,signal_P2,signal_P3,signal_P4,signal_P5,
						    signal_P6,signal_P7,signal_P8,signal_P9, signal_Pout );  -- signal_Pout sera négligé.
	

	V3:convolution_IPCore_Div9 port map( signal_P1,signal_P2,signal_P3,signal_P4,signal_P5,signal_P6,signal_P7,
														signal_P8,signal_P9,
														Coef1, Coef2, Coef3, Coef4, Coef5, Coef6, Coef7, Coef8, Coef9,
														clk, Ce, 
														DataOut_Div8,  DataOut_Div9);
-----------------
end Behavioral;
