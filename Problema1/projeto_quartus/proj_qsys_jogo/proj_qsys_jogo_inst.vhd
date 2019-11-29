	component proj_qsys_jogo is
		port (
			buttons_export : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			clk_clk        : in  std_logic                    := 'X';             -- clk
			db_export      : out std_logic_vector(7 downto 0);                    -- export
			en_export      : out std_logic;                                       -- export
			rs_export      : out std_logic;                                       -- export
			rw_export      : out std_logic                                        -- export
		);
	end component proj_qsys_jogo;

	u0 : component proj_qsys_jogo
		port map (
			buttons_export => CONNECTED_TO_buttons_export, -- buttons.export
			clk_clk        => CONNECTED_TO_clk_clk,        --     clk.clk
			db_export      => CONNECTED_TO_db_export,      --      db.export
			en_export      => CONNECTED_TO_en_export,      --      en.export
			rs_export      => CONNECTED_TO_rs_export,      --      rs.export
			rw_export      => CONNECTED_TO_rw_export       --      rw.export
		);

