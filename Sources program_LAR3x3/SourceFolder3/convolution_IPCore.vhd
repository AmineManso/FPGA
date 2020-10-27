library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_STD.ALL;
-------------------------------------------------
entity convolution_IPCore is
port(	P1, P2, P3, P4, P5, P6, P7, P8, P9 : in std_logic_vector(7 downto 0);-- Pixels. 
		C1, C2, C3, C4, C5, C6, C7, C8, C9: in std_logic_vector(7 downto 0);--Coéfficients de convolution.
			clk, Ce : in std_logic ;														
			
		Sortie_Convolution : out std_logic_vector(15 downto 0) -- La sortie du composant de convolution.
		);
end convolution_IPCore;
--------------------------------------------------
architecture Behavioral of convolution_IPCore is
	------------------------------------------------Debut Package
		component MultiplieurIP IS
		PORT (
			 clk : IN STD_LOGIC;
			 a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			 b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			 p : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
		end component;
		---------------
		COMPONENT Additionneur_IPCore IS
		  PORT (
			 a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			 b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			 clk : IN STD_LOGIC;
			 add : IN STD_LOGIC;
			 c_in : IN STD_LOGIC;
			 ce : IN STD_LOGIC;
			 sclr : IN STD_LOGIC;
			 s : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)  );
		END COMPONENT;
	------------------------------------------------Fin Package 
	-- les signaux "Mi" seront utilisés pour stocker les résultats de multiplications. 
	signal M1, M2, M3, M4, M5, M6, M7, M8, M9 : std_logic_vector(15 downto 0):= (others => '0');
	-- Signaux intermediaires pour relier les composants entre eux:
	signal S11, S12, S13, S14, S21, S22,S31, S41: std_logic_vector(16 downto 0):= (others => '0'); 
begin
----------------- etape 1 , multiplication:	
	u1:MultiplieurIP port map(clk => clk,	--Horloge.
										a  => P1 ,	--Entrée A. 8bits
										b  => C1 ,	--Entrée B. 8bits
										p  => M1 ); --Sortie P. 16bits, car(A*B ==> 16 bits)
	u2:MultiplieurIP port map(clk, P2 , C2 , M2 );	
	u3:MultiplieurIP port map(clk, P3 , C3 , M3 );	
	u4:MultiplieurIP port map(clk, P4 , C4 , M4 );	
	u5:MultiplieurIP port map(clk, P5 , C5 , M5 );	
	u6:MultiplieurIP port map(clk, P6 , C6 , M6 );	
	u7:MultiplieurIP port map(clk, P7 , C7 , M7 );	
	u8:MultiplieurIP port map(clk, P8 , C8 , M8 );	
	u9:MultiplieurIP port map(clk, P9 , C9 , M9 );	
-------------------- etape 2 des additions:
---------- Etage 1:
	u11:Additionneur_IPCore port map( a    => M1,	--Entrée A
												 b    => M2,	--Entrée B
												 clk  => clk,
	-- add : selection de Mode:add <= '1' =>fonctionnement en  Additionneur / add<='0'=> Fonctionnement en Soustracteur.							 
												 add  => '1',	
												 c_in => '0',
												 ce   => Ce,
												 sclr => '0',	-- reset fynchrone.
												 s    => S11);	--Sortie Additionneur.
	
	u12:Additionneur_IPCore port map(M3 ,M4 ,clk ,'1' ,'0' ,Ce ,'0' ,S12 );
	u13:Additionneur_IPCore port map(M6 ,M7 ,clk ,'1' ,'0' ,Ce ,'0' ,S13 );
	u14:Additionneur_IPCore port map( M8 ,M9 ,clk ,'1' ,'0' ,Ce ,'0' ,S14);
---------- Etage 2:	
	u21:Additionneur_IPCore port map( S11(15 downto 0) ,S12(15 downto 0) ,clk ,'1' ,'0' ,Ce ,'0' ,S21);
	u22:Additionneur_IPCore port map( S13(15 downto 0) ,S14(15 downto 0) ,clk ,'1' ,'0' ,Ce ,'0' ,S22);
---------- Etage 3:	
	u31:Additionneur_IPCore port map(S21(15 downto 0) ,S22(15 downto 0) ,clk ,'1' ,'0' ,Ce ,'0' ,S31);
---------- Etage 4: ajout du Pixel 5. Mais sa cause un poblème lors de la division / 9. Donc, on l'enléve.
--	u41:Additionneur_IPCore port map(S31 ,M5 ,clk ,'1' ,'0' ,Ce ,'0' ,S41);
----------------------------------
----------------------------etape 3 de dividion(moyenne):  pour facilité les choses, on devise sur 8.
	Sortie_Convolution <="000" & S31(15 downto 3);
---------------------	
end Behavioral;
---------------------
