-- Entity name: montgomery_multiplier_tb
-- Author: Stephen Carter, Jacob Barnett
-- Contact: stephen.carter@mail.mcgill.ca, jacob.barnett@mail.mcgill.ca
-- Date: ${DATE}
-- Description:
-- 	Testbench used to test the Montgomery Multiplier
--		Tests autogenerated from a python script

library ieee;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity montgomery_multiplier_tb is
end entity;

architecture test of montgomery_multiplier_tb is
-- define the ALU compontent to be tested
Component montgomery_multiplier is
 	Generic(
		WIDTH_IN : integer := ${DATA_WIDTH}
	);
	Port(	A :	in unsigned(WIDTH_IN-1 downto 0);
		B :	in unsigned(WIDTH_IN-1 downto 0);
		N :	in unsigned(WIDTH_IN-1 downto 0);
		latch : in std_logic;
		clk :	in std_logic;
		reset :	in std_logic;
		M : 	out unsigned(WIDTH_IN-1 downto 0)
	);
end component;

CONSTANT WIDTH_IN : integer := ${DATA_WIDTH};

CONSTANT clk_period : time := 1 ns;

Signal N_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
Signal A_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
Signal B_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');

Signal clk : std_logic := '0';
Signal reset_t : std_logic := '0';
Signal latch_in : std_logic := '0';

Signal M_out : unsigned(WIDTH_IN-1 downto 0) := (others => '0');

Begin
-- device under test
dut: montgomery_multiplier PORT MAP(	A	=> 	A_in,
					B 	=> 	B_in,
					N 	=> 	N_in,
					latch	=>	latch_in,
					clk	=> 	clk,
					reset 	=>	reset_t,
					M	=>	M_out);
  
-- process for clock
clk_process : Process
Begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;

stim_process: process
Begin


	reset_t <= '1';
	wait for 1 * clk_period;
	reset_t <= '0';
	wait for 1 * clk_period;


${TEST_BODY}

	wait;

end process;
end architecture;

