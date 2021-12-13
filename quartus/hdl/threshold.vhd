-----------------------------------------------------------------------------------
-- File:        threshold.vhd
-- Date:        20211213
-- Author:      Rafael N. Trozzo
-- Description: Module for selecting the threshold
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
entity threshold is
	port(
        signal index        : in std_logic_vector(3 downto 0);
        signal threshold    : out std_logic_vector(15 downto 0)
    );
end entity threshold;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture threshold_arch of threshold is
    signal t0   : integer := 13000; -- Wire
    signal t1   : integer := 8500;  -- Low Pass
    signal t2   : integer := 1500;	-- High Boost
    signal t3   : integer := 300;	-- Laplacian (50 -> Erosion y dilación + Sobel o 300 -> El resto)
    signal t4   : integer := 0;		-- Laplacian
    signal t5   : integer := 0;		-- Sobel
begin 
	update: process (index)
    begin
        if (index = "0000") then
            threshold <= std_logic_vector(to_unsigned(t0, 16));
        elsif (index = "0001") then
            threshold <= std_logic_vector(to_unsigned(t1, 16));
        elsif (index = "0010") then
            threshold <= std_logic_vector(to_unsigned(t2, 16));
        elsif (index = "0011") then
            threshold <= std_logic_vector(to_unsigned(t3, 16));
        elsif (index = "0100") then
            threshold <= std_logic_vector(to_unsigned(t4, 16));
        elsif (index = "0101") then
            threshold <= std_logic_vector(to_unsigned(t5, 16));
        end if;
    end process update;

end architecture threshold_arch;
