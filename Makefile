.PHONY:comp 
.PHONY:run_%
.PHONY:debug_%
#UVM_HOME = /usr/synopsys/vc_static-O-2018.09-SP2-2/vcs-mx/etc/uvm-1.2/
#NOVAS_HOME = /usr/synopsys/vc_static-O-2018.09-SP2-2/verdi/
#LD_LIBRARY_PATH = /usr/synopsys/vc_static-O-2018.09-SP2-2/verdi/share/PLI/VCS/linux64
UVM_VERBOSITY = UVM_HIGH
#NOVAS = /usr/synopsys/vc_static-O-2018.09-SP2-2/verdi/share/PLI/VCS/linux64
# my compute
UVM_HOME = /home/synopsys/vcs-mx/O-2018.09-1/etc/uvm-1.2
NOVAS_HOME = /home/synopsys/verdi/Verdi_O-2018.09-SP2/etc
LD_LIBRARY_PATH = /home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64
NOVAS = /home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64

TEST = qspi_test
:
VCS =	vcs -sverilog -timescale=1ns/1ns \
	+acc +vpi -debug_access+nomemcbk+dmptf -debug_region+cell \
	+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
        -debug_access+all -kdb -lca  \
        -cm line+cond+tgl\
	-LDFLAGS -Wl,--no-as-needed \
        -ntb_opts uvm-1.2  -full64\
	+incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
	-CFLAGS -DVCS -P $(NOVAS)/novas.tab $(NOVAS)/pli.a top.sv 



run:
	$(VCS); ./simv

clean:
	rm -rf coverage.vdb csrc DVEfiles inter.vpd simv simv.daidir ucli.key vc_hdrs.h vcs.log .inter.vpd.uvm

run_%:
	mkdir -p $(patsubst run_%,%,$@) ;\
	cp ./comp/*  $(patsubst run_%,%,$@) -rf ;\
	cd  $(patsubst run_%,%,$@) ;\
	./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) \
	+UVM_TESTNAME=$(patsubst run_%,%,$@)  +UVM_TR_RECORD +UVM_LOG_RECORD +ntb_random_seed_automatic \
	+verbose=1 -l vcs.log -cm line+cond+tgl

debug_%:
	mkdir -p $(patsubst debug_%,%,$@) ;\
	cp ./comp/*  $(patsubst debug_%,%,$@) -rf ;\
	cd  $(patsubst debug_%,%,$@) ;\
	./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) \
	+UVM_TESTNAME=$(patsubst debug_%,%,$@)  +UVM_TR_RECORD +UVM_LOG_RECORD +ntb_random_seed_automatic \
	+verbose=1 -l vcs.log -cm line+cond+tgl
