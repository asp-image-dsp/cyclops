-----------------------------------------------------------------------------------
-- File:        step_counter.vhd
-- Date:        20211213
-- Author:      Facundo D. Farall, Lucas A. Kammann
-- Description: Module for counting step by step
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
entity step_counter is
    generic(
        step    : integer := 5
    );

	port(
        signal clock    : in std_logic;
        signal data_out : out std_logic_vector(15 downto 0)
    );
end entity step_counter;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture step_counter_arch of step_counter is
    signal dout : std_logic_vector(15 downto 0) := "0000000000000000";
begin
    data_out <= dout;

    counter: process (clock)
    begin
        if (rising_edge(clock)) then
            dout <= std_logic_vector(unsigned(dout) + step);
        end if;
    end process counter;
end architecture step_counter_arch;