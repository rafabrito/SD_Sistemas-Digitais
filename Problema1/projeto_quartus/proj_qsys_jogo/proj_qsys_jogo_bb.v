
module proj_qsys_jogo (
	buttons_export,
	clk_clk,
	db_export,
	en_export,
	rs_export,
	rw_export);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[7:0]	db_export;
	output		en_export;
	output		rs_export;
	output		rw_export;
endmodule
