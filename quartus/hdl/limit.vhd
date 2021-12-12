-----------------------------------------------------------------------------------
-- File:        limit.vhd
-- Date:        20211212
-- Author:      Facundo D. Farall, Lucas A. Kammann
-- Description: Module for limiting ALU output
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
entity limit is
	port(
        signal data_in  : in std_logic_vector(21 downto 0);
        signal data_out : out std_logic_vector(15 downto 0)
    );
end entity limit;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture limit_arch of limit is
begin
    limit: process (data_in)
    begin
        if (data_in(21) = '1') then
            data_out <= std_logic_vector(to_unsigned(0, 16));
        elsif (data_in(20 downto 18) /= "000") then
            data_out <= std_logic_vector(to_unsigned(65535, 16));
        else
            data_out <= data_in(17 downto 2);
        end if;
    end process limit;
end architecture limit_arch;