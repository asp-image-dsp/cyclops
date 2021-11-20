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
    signal last_byte        : std_logic := 0;
    signal byte_selector    : std_logic_vector (1 downto 0) := 0;
    signal prev_u           : std_logic_vector (7 downto 0);
    signal prev_v           : std_logic_vector (7 downto 0);
    signal prev_y0          : std_logic_vector (7 downto 0);
    signal prev_y1          : std_logic_vector (7 downto 0);
begin
    
    capture: process (href, pclk)
    begin

        if rising_edge(href) then
            byte_selector <= 0;
        end if;

        if falling_edge(href) then
            last_byte <= '1';
        end if;

        -- Data capture to buffer
        if rising_edge(pclk) then
            -- Capture data if valid
            if (href = '1') then
                if (byte_selector = 0) then
                    prev_u <= d;
                elsif (byte_selector = 1) then
                    prev_y0 <= d;
                elsif (byte_selector = 2) then
                    v <= d;
                elsif (byte_selector = 3) then
                    prev_y1 <= d;
                end if;
            end if;

            -- Count PCLK edges independently from href being 1
            if (byte_selector = 0) then
                byte_selector <= 1;
            elsif (byte_selector = 1) then
                byte_selector <= 2;
            elsif (byte_selector = 2) then
                byte_selector <= 3;
            elsif (byte_selector = 3) then
                byte_selector <= 0;
            end if;
        
        end if;

        -- Update output from buffer
        if falling_edge(pclk) then
            if ((href = '1') or (last_byte = '1')) then
                -- Divide update frequency by 2
                if (byte_selector(0) = 0) then                
                    if (byte_selector(1) = 0) then
                        u <= prev_u;
                        v <= prev_v;
                        y <= prev_y0;
                    elsif (byte_selector(1) = 1) then
                        y <= prev_y1;
                        last_byte <= '0';
                    end if;
                end if;
            end if;
        end if;

    end process capture;

    pready <= not byte_selector;

end architecture ov7670_pixel_capture_arch;