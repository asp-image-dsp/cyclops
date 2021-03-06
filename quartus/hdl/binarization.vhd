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
	port(
		signal threshold	: in std_logic_vector(15 downto 0);
		signal data_in		: in std_logic_vector(15 downto 0);
		signal data_out		: out std_logic
	);
end entity binarization;

-----------------------------------------------------------------------------------
-- Architectures
-----------------------------------------------------------------------------------
architecture binarization_arch of binarization is
begin 
	update: process (data_in)
	begin
		if (to_integer(unsigned(data_in)) > to_integer(unsigned(threshold))) then
			data_out <= '1';
		else 
			data_out <= '0';	
		end if;			  
	end process update;
	
end architecture binarization_arch;