-----------------------------------------------------------------------------------
-- File:        ov7670_pixel_capture.vhd
-- Date:        20211117
-- Author:      Lucas A. Kammann and Rafael N. Trozzo
-- Description: Module for capturing the pixel data of an OV7670 camera
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Package
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ov7670_pixel_capture is
    port (
        signal vsync    : in std_logic; 
        signal href     : in std_logic;
        signal pclk     : in std_logic;
        signal d        : in std_logic_vector (7 downto 0);

        signal y        : out std_logic_vector (7 downto 0);
        signal u        : out std_logic_vector (7 downto 0);
        signal v        : out std_logic_vector (7 downto 0);
        signal pready   : out std_logic
    );
end entity ov7670_pixel_capture;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------

architecture ov7670_pixel_capture_arch of ov7670_pixel_capture is
    signal byte_selector    : std_logic_vector (1 downto 0) := 0;
begin
    
    capture: process (href, pclk)
    begin
        if rising_edge(href) then
            byte_selector <= 0;
            pixel_selector <= 0;
        end if;

        if rising_edge(pclk) then
            if (href = '1') then
                if (pixel_selector = 0) then
                    if (byte_selector = 0) then
                        u <= d;
                        byte_selector <= 1;
                    elsif (byte_selector = 1) then
                        y <= d;
                        byte_selector <= 2;
                    elsif (byte_selector = 2) then
                        v <= d;
                        byte_selector <= 0;
                    end if;
                    elsif (byte_selector = 0) then
                        y <= d;
                        pixel_selector <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process capture;

    pready <= not byte_selector;

end architecture ov7670_pixel_capture_arch;