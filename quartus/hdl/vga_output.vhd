-----------------------------------------------------------------------------------
-- File:        binarization.vhd
-- Date:        20211122
-- Author:      Rafael N. Trozzo
-- Description: Module for sending output to VGA monitor
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
entity vga_output is 
    generic(
        word_width : integer := 1;
        address_width : integer := 8
    );
    port(
        signal clock    : in std_logic;
        signal data_in  : in std_logic_vector(word_width - 1 downto 0); -- Memory input data
        signal vsync    : out std_logic;
        signal hsync    : out std_logic;
        signal r        : out std_logic_vector(word_width - 1 downto 0); 
        signal g        : out std_logic_vector(word_width - 1 downto 0);
        signal b        : out std_logic_vector(word_width - 1 downto 0);
        signal address  : out std_logic_vector(address_width - 1 downto 0);
		  signal mem_clk	: out std_logic;
		  signal activ		: out std_logic := '0'; -- debug
		  signal counth	: out integer range 0 to 1000; -- debug
		  signal countv	: out integer range 0 to 1000 -- debug
    );
end entity vga_output;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture vga_output_arch of vga_output is
    signal read_address  : integer;
    signal h_count       : integer range 0 to 1024 := 0;
    signal v_count       : std_logic_vector (9 downto 0);-- integer range 0 to 1024 := 0;
    signal is_active     : std_logic;
       
    -- Constant parameters
    constant pixel_count : integer := 307200;

    constant hactive : integer := 640;
    constant hfrontporch : integer := 16;
    constant hsyncpulse : integer := 96;
    constant hbackporch : integer := 48;
    constant htotal : integer := 800;

    constant vactive : integer := 480;
    constant vfrontporch : integer := 10;
    constant vsyncpulse : integer := 2;
    constant vbackporch : integer := 33;
    constant vtotal : integer := 525;

	 
	 
begin

    update_signals: process(clock)
    begin
        if (rising_edge(clock)) then
            if (h_count = (htotal - 1)) then
                h_count <= 0;
                if (to_integer(unsigned(v_count)) = (vtotal - 1)) then
                    v_count <= std_logic_vector(to_unsigned(0, 10));
                else
						v_count <= std_logic_vector(to_unsigned(to_integer(unsigned(v_count)) + 1, 10));  
                end if;
            else
                h_count <= h_count + 1; 
            end if;
        end if;
    end process update_signals;

    update_syncs: process(v_count, h_count)
    begin
        -- Triggering the synchronization pulses
        if (h_count >= (hfrontporch + hactive) and h_count < (hfrontporch + hactive + hsyncpulse)) then
            hsync <= '1';
        else
            hsync <= '0';
        end if;

        if (to_integer(unsigned(v_count)) >= (vfrontporch + vactive) and to_integer(unsigned(v_count)) < (vfrontporch + vactive + vsyncpulse)) then
            vsync <= '1';
        else
            vsync <= '0';
        end if;

        -- Enabling when the RGB bits should be turned on or not
		if ( (h_count >= 0 and h_count < hactive) and (to_integer(unsigned(v_count)) >= 0 and to_integer(unsigned(v_count)) < vactive) ) then
			is_active <= '1';
		else
			is_active <= '0';
	   end if;
    end process update_syncs;

    update_memory: process(clock)
    begin
        if (rising_edge(clock) and is_active = '1') then
            -- Update memory read address
            if (read_address = pixel_count - 1) then
                read_address <= 0;
            else
                read_address <= read_address + 1;
            end if;
        end if;
		  
		  if (is_active = '1') then
		      mem_clk <= not clock;
		  end if;
    end process update_memory;

    update_rgb: process(is_active, data_in)
    begin
        if (is_active = '1') then
            -- Output pixel value, same value for RGB (grayscale)
            r <= data_in;
            g <= data_in;
            b <= data_in;
			else
				r <= std_logic_vector(to_unsigned(0, word_width));
				g <= std_logic_vector(to_unsigned(0, word_width));
				b <= std_logic_vector(to_unsigned(0, word_width));
        end if;
    end process update_rgb;
	 
	 activ <= is_active;
	 counth <= h_count;
	 countv <= to_integer(unsigned(v_count));
	 address <= std_logic_vector(to_unsigned(read_address, address_width));

end architecture vga_output_arch;