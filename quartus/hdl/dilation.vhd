-----------------------------------------------------------------------------------
-- File:        dilation.vhd
-- Date:        20211129
-- Author:      Gonzalo Davidov
-- Description: Module for dilating an image
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
entity dilation is
	port(
		signal data_in		: in std_logic_vector(8 downto 0);
		signal data_out	: out std_logic
    );
end entity dilation;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture dilation_arch of dilation is

begin 
	update: process (data_in)
	begin
		if (data_in(4) = '0') then
			if ( 	 
				(data_in(1) = '1') or 
				(data_in(3) = '1') or 
				(data_in(5) = '1') or 
				(data_in(7) = '1')				
			) then
				data_out <= '1';
			else
				data_out <= '0';
			end if;
		else
			data_out <= '1';
		end if;
	
	end process update;
   

end architecture dilation_arch;