-----------------------------------------------------------------------------------
-- File:        binarization.vhd
-- Date:        20211122
-- Author:      Rafael N. Trozzo
-- Description: Module for binarizing a byte value
-----------------------------------------------------------------------------------


-----------------------------------------------------------------------------------
-- Package
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
entity binarization is
	generic(
		threshold :	integer := 127
	);

	port(
		signal byte	: in std_logic_vector(7 downto 0);
		signal clock	: in std_logic;
		signal y		: out std_logic
	);
end entity binarization;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture binarization_arch of binarization is
begin 

	update: process (clock)
	begin
		if (rising_edge(clock)) then
			if (unsigned(byte) > threshold) then
				y <= '1';
			else 
				y <= '0';	
			end if;			  
		end if;
	end process update;
	
end architecture binarization_arch;