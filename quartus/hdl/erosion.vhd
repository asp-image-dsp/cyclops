-----------------------------------------------------------------------------------
-- File:        erosion.vhd
-- Date:        20211129
-- Author:      Gonzalo Davidov
-- Description: Module for eroding an image
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
entity erosion is
	port(
		signal data_in		: in std_logic_vector(8 downto 0);
		signal data_out	: out std_logic
    );
end entity erosion;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture erosion_arch of erosion is

begin 

	update: process (data_in)
	begin
		if (data_in(4) = '1') then
			if ( 	 
					(data_in(1) = '0') or 
					(data_in(3) = '0') or 
					(data_in(5) = '0') or 
					(data_in(7) = '0')				
			) then
				data_out <= '0';
			else
				data_out <= '1';
			end if;
		else
			data_out <= '0';
		end if;
	
	end process update;
   

end architecture erosion_arch;