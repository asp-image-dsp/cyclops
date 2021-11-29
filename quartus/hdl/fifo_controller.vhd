-----------------------------------------------------------------------------------
-- File:        fifo_controller.vhd
-- Date:        20211128
-- Author:      Lucas A. Kammann and Rafael N. Trozzo
-- Description: The FIFO controller indicates for each virtual element of the FIFO,
--              which physical element is used. It is used to push and pull the elements
--              by moving the pointers used to reference each element.
--              The value of the index output indicates the number of physical element
--              which is mapped as that virtual element of the FIFO.
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Package
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_controller is
    port (
        -- Input ports
        roll    : in std_logic; -- Positive edge roll function
        reset   : in std_logic; -- Active high asynchronous reset

        -- Output ports
        index_0 : out std_logic_vector (1 downto 0);
        index_1 : out std_logic_vector (1 downto 0);
        index_2 : out std_logic_vector (1 downto 0);
        index_3 : out std_logic_vector (1 downto 0)
    );
end entity fifo_controller;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------

architecture fifo_controller_arch of fifo_controller is
    signal i_0 : std_logic_vector (1 downto 0) := "00";
    signal i_1 : std_logic_vector (1 downto 0) := "01";
    signal i_2 : std_logic_vector (1 downto 0) := "10";
    signal i_3 : std_logic_vector (1 downto 0) := "11";
begin

    index_0 <= i_0;
    index_1 <= i_1;
    index_2 <= i_2;
    index_3 <= i_3;

    fifo: process (reset, roll)
    begin
        if (reset = '1') then
            i_0 <= "00";
            i_1 <= "01";
            i_2 <= "10";
            i_3 <= "11";
        else
            if (rising_edge(roll)) then
                i_0 <= i_1;
                i_1 <= i_2;
                i_2 <= i_3;
                i_3 <= i_0;
            end if;
        end if;
    end process fifo;

end architecture fifo_controller_arch;