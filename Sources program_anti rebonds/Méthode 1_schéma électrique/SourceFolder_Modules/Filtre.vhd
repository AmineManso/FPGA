	library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Filtre is
PORT( Din 		: in std_logic;
		clk, CE  : 	 in std_logic; 
		Cout     : out std_logic );
end Filtre;

	architecture Behavioral of Filtre is
		---------------------------------------------------------- Début package:
		component Register_D is
			PORT( E   : in  STD_LOGIC;
					clk : in  STD_LOGIC;
					CE  : in  STD_LOGIC;
					Sortie_D : out  STD_LOGIC);
		end component;
	---------------------------	
		component Counter is
		port(  	   E  : in std_logic;
					clk: in std_logic;
					CE : in std_logic;
					ras : in std_logic;
					
				Sortie_C : out std_logic);
		end component;
		---- ------------------------------------------------------ Fin package.
	---- -------------------------------------------------------Declaration signaux:
	signal S1, S2, S3, S4, S5 : std_logic := '0'; 
	---- -------------------------------------------------------	
begin
-------------------------------------------------------------------------------
---------------------------------------------- Etage du Process 1 du schéma électrique:
		S3 <= not(S1 xor S2); -- on utilise le NXOR, plutot qu le XOR
	
		u1: Register_D port map(Din, clk, CE, S1); -- FF1.
		u2: Register_D port map(S1, clk, CE, S2);  -- FF2.
		u3: Counter port map(E => S3,clk => clk,	CE => CE, ras => S5, Sortie_C => S4 );		
		
		------ décaller S4 pour que le changement d'état ne soit pas imédiat
		------  et pour voir le fonctionnement dans la simulation
		u32: Register_D port map (S4, clk, CE, S5); -- FF3.
		
------------------------------------------------ Etage du Process 2 du schéma électrique:
		u4: Register_D port map (S2, clk, S4, Cout);-- FF4.

------------------------------------------------
end Behavioral;
------------------------------------------------------------------------------------



