import pdb
from genu import *
from rasp30 import *
class rasp30_vmm(stats):
    def __init__(self):
        self.array = arrayStats()
        self.cab = cabStats()
        self.cab_vmm = cab_vmmStats()
        self.cab2 = cab2Stats()
        self.clb = clbStats()
        self.io_sd = iosdStats()
        self.io_w = iowStats()
        self.io_sa = iosaStats()
        self.io_e = ioeStats()
	self.io_el = ioelStats()
        self.io_na= iosaStats()
##
## This should override previos definition of arrayStats which we use a lot
##
class arrayStats(stats):
    arch_file = './arch/rasp30.xml'
    pattern = [
            [    [], 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', 'io_w', []], 
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sa', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'io_na'],
            ['io_sa', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'io_na'],
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sa', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'io_na'],
            ['io_sa', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'io_na'],
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sa', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'io_na'],
            ['io_sa', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'cab_vmm', 'io_na'],
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sd', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'clb', 'io_nd'],
            ['io_sa', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'cab2', 'io_na'],
            ['io_el', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e', 'io_e',[]]]
            
    def __init__(self):
        DEBUG = 0
        
        x_pattern = []
        for i in range(len(self.pattern)):
        	x_pattern.append(self.pattern[i][1])
        	
        y_pattern = self.pattern[1]
        
        if DEBUG:
        	for j in reversed(range(len(pattern))):
        		for i in range(len(pattern[j])):
        			print str(pattern[i][j]).rjust(6),
        		print

        #y offset is not higher order bits, but the lower bits
        #base addresses for y are the higher order bits
        #also we can't count the first clb
	#y offset:: col<3:0> while using in col 
        addrs = {'y':{'io_sd':1, 'clb':1, 'io_nd':0}, 'x':{'io_w':0, 'clb':34,'cab':34,'cab2':34, 'cab_vmm':34,'io_e':34}}
        
        self.x_offsets = [0]
        self.x_offsets.append(0) # this and the [2:] are to skip the first CLB
	#!!! check the x-offsets
        for x_type in x_pattern[2:]:
            self.x_offsets.append(self.x_offsets[-1] + addrs['x'][x_type])
        
        self.y_offsets = [0]
        for y_type in y_pattern[1:]:
            self.y_offsets.append(self.y_offsets[-1] + addrs['y'][y_type])
            
    def getTileOffset(self, swc, grid_loc):      
        
        DEBUG = 0
        x = grid_loc[0]
        y = grid_loc[1]
    	
	#pdb.set_trace()
        if DEBUG:
            return [999, 999]
        else:
	    # calculate the real column offset as some C-blocks are shifted
	    #print self.y_offsets[y]
	    #print swc[1]
	    #print 2**4
	    #print swc[1]*2**4
            return [swc[0]+self.x_offsets[x], swc[1]*2**4+self.y_offsets[y]] #kludge / hardcoded 2**4 part, fix this!

###########################################
#   CAB VMM stats 
###########################################   
class cab_vmmStats(stats):
    def __init__(self):
        global ladder_blk
	ladder_blk=0
        self.num_inputs = 16 # not accounting for si now
        self.num_outputs = 24
        # order is I[0:15] then si[0:3] O[0:7] so[0:12]  where si==O and so==I
        self.pin_order =['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15','O0','O1','O2','O3','O0','O1','O2','O3','O4','O5','O6','O7','I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11']	
        #self.pin_order =['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15','I0','I1','I2','I3','I4','I5','O0','O1','O0','O1','O2','O3','O4','O5','O6','O7']
	    #CHANX--C BLOCK ---y axis of adjacent CAB
	    # these are the decoder mapped addrs
	   	
        #chanx_sm = ['T[0:16]', [range(22,13,-1)+range(12,8,-1)+range(7,3,-1),0],### flipping chanx and chany ####
	chanx_sm = ['T[0:16]', [range(22,15,-1)+range(14,8,-1)+range(7,3,-1),0],
             'I8',   [ 0,36],     #pin names
             'I9',   [ 0,37],
             'I13',  [ 0,38],
             'I14',  [ 0,39],
	     'I15',  [ 0,40],
             'O4',   [ 0,41],
             'XI10', [ 0,42],
             'XI11', [ 0,43],
             'XI12', [ 0,44],
             'XO5',  [ 0,45],
             'XO6',  [ 0,46],
	     'XO7',  [ 0,47]]

        self.chanx = smDictFromList(chanx_sm, 'remBrak')
            
        # CHANY  --x axis block of original  
        #chany_sm = ['T[0:16]', [range(22,13,-1)+range(12,8,-1)+range(7,3,-1),0],
	chany_sm = ['T[0:16]', [range(22,15,-1)+range(14,8,-1)+range(7,3,-1),0],
            'I4',   [ 0,65],    #pin names
            'I5',   [ 0,66],
            'I6',   [ 0,67],
            'I7',   [ 0,68],
            'O2',   [ 0,69],
            'O3',   [ 0,70],
	    'XO0',  [ 0,63],
            'XO1',  [ 0,64],
            'XI0',  [ 0,59],
            'XI1',  [ 0,60],
            'XI2',  [ 0,61],## problem conflict
            'XI3',  [ 0,62],
            'DXI2', [ 0,65],#------to match w/ dif DIgital tile NAME BUT ANALOG TILE MAPPING
            'DXI6',  [ 0,66], #to match w/ dif tile
            'DXI10', [ 0,67],#to match w/ dif tile
	    'DXI14', [ 0,68],
            'DXO2',  [ 0,69],
	    'DXO6',  [ 0,70]]
			#'XO3',	[0,70]]  # $$ XO<0,4>??
        self.chany = smDictFromList(chany_sm, 'remBrak')
        
        # SBLOCK            
        #sb_sw = ['T[0:16]', [range(22,13,-1)+range(12,8,-1)+range(7,3,-1), 0],
	sb_sw = ['T[0:16]', [range(22,15,-1)+range(14,8,-1)+range(7,3,-1), 0],
            'we',   [ 0,54],#actual ns    #track direction (these are rotated 90deg ccw from schematic name: ww->W)
            'wn',   [ 0,51],#ne                     
            'ws',   [ 0,50],#nw                     
            'ns',   [ 0,52], #ew                     
            'ne',   [ 0,53],#es                     
            'es',   [ 0,49],                     
            'ew',   [ 0,54],#ns                     
            'nw',   [ 0,51],                     
            'sw',   [ 0,50],                     
            'sn',   [ 0,52],                     
            'en',   [ 0,53],                     
            'se',   [ 0,49]]    
        self.sblock = smDictFromList(sb_sw, 'remBrak')  
              
        #Local Interconnect
        li_sm_0a = ['gnd','vcc','cab_vmm.I[0:15]']
	# outputs order into the CAB for direct swcs
        #li_sm_0b = ['vmm16x16.out[0]','vmm2x2.out[0:1]']
	# defining the inputs order into the CAB #?? last term to connect i/ps to o/ps? for direct swcs
        #li_sm_1 = ['vmm16x16.in[0:15]','vmm2x2.in[0:1]','cab_vmm.O[0:5]'] 
        
    # outputs order into the CAB
        li_sm_0b = ['fgota[0:1].out[0]','ota_buf[0].out[0]','ota[0].out[0]','ota_vmm[0].out[0]','cap[0:3].out[0]','nfet[0:1].out[0]','pfet[0:1].out[0]','tgate[0:3].out[0]','nmirror_vmm[0:1].out[0]','ladder_blk[0].out[0:1]','c4_blk[0].out[0]','speech[0].out[0:1]','INFneuron[0].out[0]','lpf[0].out[0]','nfet_i2v[0].out[0]','pfet_i2v[0].out[0]','i2v_pfet_gatefgota[0].out[0]','mismatch_meas[0].out[0]','peak_detector[0].out[0]','ramp_fe[0].out[0]','sigma_delta_fe[0].out[0]','vmm_senseamp1[0].out[0]','vmm_senseamp2[0].out[0:1]','wta[0].out[0]','wta_primary[0].out[0:1]','common_source[0].out[0]','gnd_out[0].out[0]','vdd_out[0].out[0]','in2in_x1[0].out[0]','in2in_x6[0].out[0]','volt_div[0:1].out[0]','integrator[0].out[0]','integrator_nmirror[0].out[0]','tgate_so[0].out[0]','vmm4x4_SR[0].out[0]','vmm8x4_SR[0].out[0]','SR4[0].out[0:7]','vmm4x4_SR2[0].out[0]','vmm4x4[0].out[0:3]','sftreg[0].out[0]','DAC_sftreg[0].out[0]','sftreg2[0].out[0]','mmap_local_swc[0].out[0]','th_logic[0].out[0]','vmm8x4[0].out[0]','vmm8x4_in[0].out[0]','vmm12x1[0].out[0]','fg_io[0].out[0]']
    # defining the inputs order into the CAB #?? last term to connect i/ps to o/ps?
        li_sm_1 = ['fgota[0:1].in[0:1]','ota_buf[0].in[0]','ota[0].in[0:1]','ota_vmm[0].in[0:1]','cap[0:3].in[0]','nfet[0:1].in[0:1]','pfet[0:1].in[0:1]','tgate[0:3].in[0:1]','nmirror_vmm[0:1].in[0]','ladder_blk[0].in[0:1]','c4_blk[0].in[0:1]','speech[0].in[0:2]','INFneuron[0].in[0:2]','lpf[0].in[0]','nfet_i2v[0].in[0]','pfet_i2v[0].in[0]','i2v_pfet_gatefgota[0].in[0]','mismatch_meas[0].in[0:2]','peak_detector[0].in[0:1]','ramp_fe[0].in[0]','sigma_delta_fe[0].in[0:4]','vmm_senseamp1[0].in[0:1]','vmm_senseamp2[0].in[0:3]','wta[0].in[0:1]','wta_primary[0].in[0]','common_source[0].in[0]','gnd_out[0].in[0:1]','vdd_out[0].in[0:1]','in2in_x1[0].in[0:2]','in2in_x6[0].in[0:12]','volt_div[0:1].in[0:1]','integrator[0].in[0:2]','integrator_nmirror[0].in[0:2]','tgate_so[0].in[0:7]','vmm4x4_SR[0].in[0:6]','vmm8x4_SR[0].in[0:10]','SR4[0].in[0:3]','vmm4x4_SR2[0].in[0:7]','vmm4x4[0].in[0:3]','sftreg[0].in[0:18]','DAC_sftreg[0].in[0:2]','sftreg2[0].in[0:2]','mmap_local_swc[0].in[0:2]','th_logic[0].in[0:7]','vmm8x4[0].in[0:12]','vmm8x4_in[0].in[0:12]','vmm12x1[0].in[0:12]','fg_io[0].in[0]','cab_vmm.O[0:7]'] 
	    
	          
        li_sm = ['gnd'             	,[0,  0],     #inputs from CAB and device outputs
		'vcc'               	,[0,  1],#y
		'cab_vmm.I[0:12]'       ,[0, range( 2, 15)],#y to be shifted for the decoder
		'vmm4x4_dummy[0:3]'	,[0,range(19,23)], #middle LI for VMM turn
		#O/PS OF CAB DEVICES
		'fgota[0:1].out[0]'  	,[0, range(15, 17)],#y
		'ota_buf[0].out[0]'  	,[0, 17],#y
		'ota[0].out[0]'      	,[0, 18],#y
		'ota_vmm[0].out[0]'      	,[0, 18],#y
		'cap[0:3].out[0]'    	,[0, range(19, 23)],#y                                
		'nfet[0:1].out[0]'   	,[0, range(24, 22, -1)],#y numbering chnge for nFET0(24) and nFET1(23), needs to be verified
		'pfet[0:1].out[0]'   	,[0, range(26, 24,-1)],#y numbering chnge for pFETt0(26) and pFET1(23)
		'tgate[0:3].out[0]'  	,[0, range(27, 31)],#y
		'nmirror_vmm[0:1].out[0]'	,[0, range(31, 33)],#y
		'ladder_blk[0].out[0:1]',[0,[17,18]],
		'c4_blk[0].out[0]'	 ,[0,15],
    	        'speech[0].out[0:1]'	 ,[0,[17,26]],
		'lpf[0].out[0]'  	 ,[0, 17],
                'nfet_i2v[0].out[0]',[0, 17], #ota0 output
                'pfet_i2v[0].out[0]',[0, 17], #ota0 output
                'i2v_pfet_gatefgota[0].out[0]',[0,17], #ota0 output
                'mismatch_meas[0].out[0]',[0,16], #fgota1 output
		'INFneuron[0].out[0]',[0,17],
		'peak_detector[0].out[0]',[0,25], # cap[0]'s out'
		'ramp_fe[0].out[0]' , [0,18], #[0,[18,17]], # 18:ota1.out 17: ota0.out
		'sigma_delta_fe[0].out[0]', [0,18], #[0,[18,17]], # 18:ota1.out 17: ota0.out
		'volt_div[0:1].out[0]',[0,[15,16]],
		'vmm_senseamp1[0].out[0]',[0,17], #ota0 output
		'vmm_senseamp2[0].out[0:1]',[0,[17,18]],
		'wta[0].out[0]'		 ,[0,17],#nfet0 source
		'wta_primary[0].out[0:1]'		 ,[0,[17,32]],#nfet0 source
		'integrator[0].out[0]',[0,18],
		'integrator_nmirror[0].out[0]',[0,18],
		'common_source[0].out[0]',[0,24],
		'gnd_out[0].out[0]',[0,24],
		'vdd_out[0].out[0]',[0,24],
		'in2in_x1[0].out[0]',[0,24],
		'in2in_x6[0].out[0]',[0,24],
		'tgate_so[0].out[0]',[0,19],
		'vmm4x4_SR[0].out[0]'  ,[0,34], #19+15--->15 is offset for middle LI
		'vmm4x4_SR2[0].out[0]'  ,[0,34], #19+15--->15 is offset for middle LI
		'vmm8x4_SR[0].out[0]'  ,[0,34], #19+15--->15 is offset for middle LI
		'SR4[0].out[0:4]',	[0,[19,20,21,22,18+15]],#cap--ops+15, and the 18+15
		'vmm4x4[0].out[0:3]',	[0,range(19,23)],
		'vmm8x4[0].out[0]',	[0,0], #dummy output
		'vmm8x4_in[0].out[0]',	[0,0], #dummy output
		'vmm12x1[0].out[0]',	[0,18], #wta output
		'sftreg[0].out[0]'   ,[0,18+15], #chose col-18
		'DAC_sftreg[0].out[0]'   ,[0,18+15], #chose col-18
		'sftreg2[0].out[0]'   ,[0,18+15], #chose col-18
		'mmap_local_swc[0].out[0]'   ,[0,18+15], #chose col-18
                'th_logic[0].out[0]',[0,2+15],
		'fg_io[0].out[0]'     ,[0,0],
		#'volswc[0:1].out[0]',[0, range(33, 35)],
		'fgota[0:1].in[0:1]' ,[range(33,29,-1), 0],# in<0:7> y its high because of the decoded address where 4==33 for 
		'ota_buf[0].in[0]' ,  [29, 0],# in<0:7> y
		'ota[0].in[0:1]'     ,[range(27,25,-1), 0],# in<0:7> y
		'ota_vmm[0].in[0:1]'     ,[range(27,25,-1), 0],# in<0:7> y
		'cap[0:3].in[0]'     ,[range(25,21,-1), 0],# in<8:11 y
		'nfet[0:1].in[0:1]'  ,[[19, 18, 21, 20], 0],# in<12:15> y 21, 17,-1) it's flipped
		'pfet[0:1].in[0:1]'  ,[[15, 14, 17, 16], 0],# in<16:19> n---change (17, 13,-1) it;s flipped
		'tgate[0:3].in[0:1]' ,[range(13,5,-1), 0],# in<20:27> y
		'nmirror_vmm[0:1].in[0]' ,[range(5,3,-1), 0],# in<28:29> y
		'ladder_blk[0].in[0:1]',[[29,26],0],
		'c4_blk[0].in[0:1]'   ,[[33,25],0],
		'speech[0].in[0:2]'   ,[[33,25,14],0],#25
		'lpf[0].in[0]'	  	,[29,0],
                'nfet_i2v[0].in[0]',[29,0], #ota0's in0
                'pfet_i2v[0].in[0]',[29,0], #ota0's in0
                'i2v_pfet_gatefgota[0].in[0]',[29,0], #ota0's in0
		'INFneuron[0].in[0:2]',[[27,29,21],0],#ota[in0] ota1[in1] and nfet[in0]
		'peak_detector[0].in[0:1]',[[33,17],0], #ota.0[in0] nfet1[gate]
		'ramp_fe[0].in[0]' , [31,0], #26: ota1.n 18:pfet0.gate
		'sigma_delta_fe[0].in[0:4]', [[29,26,28,13,15],0], #29:ota0+, 26:ota1 28:ota0- - 19:nfet0.gate 21 nfet1.gate
		'volt_div[0:1].in[0:1]', [[25,33,24,31],0],
		'vmm_senseamp1[0].in[0:1]',[[29,28],0], #ota0 V+, V-
		'vmm_senseamp2[0].in[0:3]',[[29,28,27,26],0],#ota0 V+, V- ,#ota1 V+, V-
		'wta[0].in[0:1]'		 ,[[19,21],0],#nfet0 and nfet1 drains
		'wta_primary[0].in[0]'		 ,[18,0],#nfet0 and nfet1 drains
		'integrator[0].in[0:2]'	  ,[[29,28,13],0],
		'integrator_nmirror[0].in[0:2]'	  ,[[29,28,13],0],
		'common_source[0].in[0]'	  ,[19,0],
                'gnd_out[0].in[0:1]'	  ,[[19,33],0],
                'vdd_out[0].in[0:1]'	  ,[[19,33],0],
                'in2in_x1[0].in[0:2]'	  ,[[19,33,33],0],
                'in2in_x6[0].in[0:12]'	  ,[[19,33,33,32,32,31,31,30,30,29,29,28,28],0],
		'tgate_so[0].in[0:7]'	  ,[[12,21,10,19,8,17,6,15],0],
		'vmm4x4_SR[0].in[0:3]'	,[[33,32,31,30],0], #connection lines to turn into shift register
		'vmm4x4_SR2[0].in[0:7]'	,[[33,32,31,30,0,0,0,25],0], #connection lines to turn into shift register
		'vmm8x4_SR[0].in[0:7]'	,[[33,32,31,30,33,32,31,30],0], #connection lines to turn into shift register
		'vmm8x4[0].in[0:12]'	,[[33,32,31,30,33,32,31,30,33,32,31,30,29],0], #connection lines to turn into shift register ---check
		'vmm8x4_in[0].in[0:12]'	,[[33,32,31,30,33,32,31,30,33,32,31,30,29],0], #in[0]~[7] will be ignored by genu.py
		'vmm12x1[0].in[0:12]'	,[[19,19,19,19,19,19,19,19,19,19,19,19,21],0], #VMM_WTA INPUTS------------------------------------------------------here --------------------------------------------------
		'SR4[0].in[0:3]'	,[[25,0,0,0],0], ## FG-OTAs input is now blocked
		'vmm4x4[0].in[0:3]'	,[[33,32,31,30],0],
		'fg_io[0].in[0]'     	,[22,0], # equivalent for cap[3]
		#'vmm16x16[0].out[0:15]' ,[0, range(0,16)],#y
		#'vmm2x2[0].out[0:1]'    ,[0, [0,1]],
		#'vmm16x16[0].in[0:1]' ,[range(22,20,-1),0],
		#'vmm16x16[0].in[0:15]'  ,[range(22,15,-1)+range(14,8,-1)+range(7,3,-1),0],#
		'cab_vmm.O[0:5]'        ,[range( 29, 23, -1), 21]] ## o/ps connectn to i/ps?? ummmmm !!! ---we need this 
        self.li = smDictFromList(li_sm)
        li0b = recStrExpand(li_sm_0b)
        li0b.reverse()
        self.li0 = recStrExpand(li_sm_0a) + li0b
        self.li1 = recStrExpand(li_sm_1)
        #pdb.set_trace()
        #CAB Devices ## order is very important here
	self.dev_types =['fgota']*2 + ['ota_buf']*1 + ['ota']*1 + ['ota_vmm']*1 + ['cap']*4+ ['nfet']*2 + ['pfet']*2 + ['tgate']*4 + ['nmirror_vmm']*2+['ladder_blk']*1+ ['c4_blk']*1+ ['speech']*1+ ['INFneuron']*1+ ['lpf']*1+['nfet_i2v']*1+['pfet_i2v']*1+['i2v_pfet_gatefgota']*1+['mismatch_meas']*1+['peak_detector']*1+['ramp_fe']*1+['sigma_delta_fe']*1+['vmm_senseamp1']*1+['vmm_senseamp2']*1+['wta']*1+['wta_primary']*1+['common_source']*1+['gnd_out']*1+['vdd_out']*1+['in2in_x1']*1+['in2in_x6']*1+['volt_div']*2+['integrator']*1+['integrator_nmirror']*1+['tgate_so']*1+['vmm4x4_SR']*1+['vmm8x4_SR']*1+['SR4']*1+['vmm4x4_SR2']*1+['vmm4x4']*1+['sftreg']*1+['DAC_sftreg']*1 +['sftreg2']*1+['mmap_local_swc']*1+['th_logic']*1+['vmm8x4']*1+['vmm8x4_in']*1+['vmm12x1']*1+['fg_io']*1
	self.dev_pins = {'fgota_in':2,'ota_buf_in':1,'ota_in':2,'ota_vmm_in':2, 'cap_in':1, 'nfet_in':2, 'pfet_in':2,'tgate_in':2,'nmirror_vmm_in':1,'ladder_blk_in':2, 'c4_blk_in':2,'speech_in':3,'INFneuron_in':3,'lpf_in':1,'nfet_i2v_in':1,'pfet_i2v_in':1,'i2v_pfet_gatefgota_in':1,'mismatch_meas_in':3,'peak_detector_in':2,'ramp_fe_in':1,'sigma_delta_fe_in':5,'vmm_senseamp1_in':2,'vmm_senseamp2_in':4,'wta_in':2,'wta_primary_in':1,'common_source_in':1,'gnd_out_in':2,'vdd_out_in':2,'in2in_x1_in':3,'in2in_x6_in':13,'volt_div_in':2,'integrator_in':3,'integrator_nmirror_in':3,'tgate_so_in':8,'vmm4x4_SR_in':7,'vmm8x4_SR_in':11,'SR4_in':4,'vmm4x4_SR2_in':8,'vmm4x4_in':4,'vmm12x1_in':13,'fg_io_in':1,'fgota_out':1,'ota_buf_out':1,'ota_out':1,'ota_vmm_out':1, 'cap_out':1, 'nfet_out':1, 'pfet_out':1,'tgate_out':1,'nmirror_vmm_out':1,'ladder_blk_out':2, 'c4_blk_out':1,'speech_out':2,'INFneuron_out':1,'lpf_out':1,'nfet_i2v_out':1,'pfet_i2v_out':1,'i2v_pfet_gatefgota_out':1,'mismatch_meas_out':1,'peak_detector_out':1,'ramp_fe_out':1,'sigma_delta_fe_out':1,'vmm_senseamp1_out':1,'vmm_senseamp2_out':2,'wta_out':1,'wta_primary_out':2,'common_source_out':1,'gnd_out_out':1,'vdd_out_out':1,'in2in_x1_out':1,'in2in_x6_out':1,'volt_div_out':1,'integrator_out':1,'integrator_nmirror_out':1,'tgate_so_out':1,'vmm4x4_SR_out':1,'vmm8x4_SR_out':1,'SR4_out':8,'vmm4x4_SR2_out':1,'vmm4x4_out':4, 'sftreg_in':19, 'DAC_sftreg_in':3, 'sftreg_out':1,'DAC_sftreg_out':1, 'sftreg2_in':3, 'sftreg2_out':1,'mmap_local_swc_in':3, 'mmap_local_swc_out':1,'th_logic_in':8, 'th_logic_out':1,'vmm8x4_in':13,'vmm8x4_out':1,'vmm8x4_in_in':13,'vmm8x4_in_out':1,'vmm12x1_out':1,'fg_io_out':1}  
        
        dev_fgs_sm = ['fgota[0:1]',[0, [58, 60]],## block names
		'ota_buf[0]' 	,[0, 62],
		'lpf[0]'	,[0, 62],
		'nfet_i2v[0]'	,[0, 0],
		'pfet_i2v[0]'	,[0, 0],
		'i2v_pfet_gatefgota[0]'	,[0, 0],
		'mismatch_meas[0]'	,[0, 0],
	        'ota[0]'	,[0, 63],
		'ota_vmm[0]'	,[0, 63],
		'ladder_blk[0]' ,[0,18],
		'c4_blk[0]'  	, [0,62], # set as ota[0] now
		'speech[0]'  	, [0,62], 
		'INFneuron[0]' 	, [0,62], # set as ota[0] now
		'peak_detector[0]' , [0,62],
		'ramp_fe[0]'    ,[0,62],
		'sigma_delta_fe[0]',[0,63],
            	'cap[0:3]'	,[0, [57,60,57,60]],
		'volt_div[0:1]' ,[0, [58, 60]],
		'vmm_senseamp1[0]',[0,0],
		'vmm_senseamp2[0]',[0,0],
		'wta[0]'	,[0,0],
		'wta_primary[0]'	,[0,0],
		'integrator[0]' ,[0,57],
		'integrator_nmirror[0]' ,[0,57],
		'common_source[0]' ,[0,0],
		'gnd_out[0]' ,[0,0],
		'vdd_out[0]' ,[0,0],
		'in2in_x1[0]' ,[0,0],
		'in2in_x6[0]' ,[0,0],
		'tgate_so[0]' ,[0,0],
		'vmm4x4[0]'	,[0,0],
		'vmm8x4[0]'	,[0,0],
		'vmm8x4_in[0]'	,[0,0],
		'vmm12x1[0]'	,[0,0],
		'vmm4x4_SR[0]'  ,[0,0],
		'vmm8x4_SR[0]'  ,[0,0],
		'vmm4x4_SR2[0]'  ,[0,0],
		'SR4[0]'	,[0,0],
		'sftreg[0]' , [0,0],
		'DAC_sftreg[0]' , [0,0],
		'nmirror_vmm[0]',[0,0],
		'sftreg2[0]' , [0,0],
		'mmap_local_swc[0]' , [0,0],
		'th_logic[0]' , [0,0],
		'fg_io[0]'    , [0,0],
		##### now the define parts
            	'ota_bias'	,[[32, 0],[33,0]],
		'ota_bias[0]'	,[[32, 0]],#62-17 ota_bias col-ota_out[0]col value
		'ota_bias[1]'	,[[32, 0]],
		'ramp_ota_biasfb[0]',[[32,-1],[28,17-63]],
		'sd_ota_biasfb[0]',[[32,-1],[28,17-63]], #sigma delta ota0 bias
		'sd_ota_bias[0]',[[32,-1]], #sigma delta ota0 bias
		'ota_biasfb[0]'	,[[32, 0],[28,-45]],#62-17 ota_bias col-ota_out[0]col value
		'fgota_biasfb[0]',[[32,0],[32,15-58]],#62-17 ota_bias col-ota_out[0]col value
		'fgota_biasfb[1]',[[32,0],[30,16-60]],
		'fgota_small_cap[0]',[[31,0],[31,1]],# switch for both n and p
		'fgota_small_cap[1]',[[31,0],[31,1]],#switches for both n and p
            	'gnd_out_c[0]', [[33, 0]],
            	'vdd_out_c[0]', [[33, 1]],
            	'ota_p_bias[0]', [[33, 1]],
           	'ota_n_bias[0]', [[33, 0]],
		'ota_p_bias[1]', [[33, 1]],
           	'ota_n_bias[1]', [[33, 0]],
           	'c4_ota_p_bias[0]', [[33, 1-62+58]],
           	'c4_ota_n_bias[0]', [[33, 0-62+58]],
		'c4_ota_p_bias[1]', [[33, 1-62+60]],
           	'c4_ota_n_bias[1]', [[33, 0-62+60]],
             	'speech_fg[0]',[[32,19-62],[32,20-62],[24,15-62],[28,62-62],[32,16-62],[30,16-62],[31,15-62],[31,1-62+58],[31,0-62+58],[31,1-62+60],[31,0-62+60],[28,2-62+57],[28,1-62+57],[28,0-62+57],[26,25-62],[27,15-62],[17,18-62],[16,0-62],[29,25-62],[28,17-62],[15,17-62]], #[16,0-62],[21,26-62],,[15,25-62],[14,1-62],pfet[15,17],[0,26]
		        'speech_pfetbias[0]' ,[[29,1-62]], #[26,1-62]
		         'speech_pfetbias[1]' ,[[29,0-62]], #[26,1-62]
		         'speech_peakotabias[0]' ,[[32,63-62]],
		         'speech_peakotabias[1]' ,[[32,62-62]], 
		'ladder_fb[0]' , [[28,0],[27,-1]],
		'INF_bias[0]'  ,[[26,-61]],
		'INF_fg[0]'	,[[19,-45],[18,-62],[28,-44],[20,-38],[26,-39]],
		'c4_ota_bias[0]',[[32, 0-62+58]],#62-17 ota_bias col-ota_out[0]col value
		'c4_ota_bias[1]',[[32, 0-62+60]],
		'peak_ota_bias[0]',[[32, 0-62+58]],
		'c4_fg[0]'	,[[32,-43],[32,-46],[30,-46],[31,-47]],#[ota_bias0|ota0neg->cap0|cap0.in->ota0out|ota_bias1|ota1_fb] |c2 and c3 conections
		'c4_cap_3x[0]',[28,2-62+57],
		'c4_cap_2x[0]',[28,1-62+57],
		'c4_cap_1x[0]',[28,0-62+57],
		'c4_ota_small_cap[0]', [[31,1-62+58],[31,0-62+58]],
		'c4_ota_small_cap[1]', [[31,1-62+60],[31,0-62+60]],
		'peak_ota_small_cap[0]', [[31,1-62+58],[31,0-62+58]],
		'lpf_fg[0]'	,[[26,-43],[26,-42],[26,-41],[26,-40],[25,-61],[24,-61],[23,-61],[22,-61]],
		'peak_detector_fg[0]',[[32,25-62],[15,15-62],[14,25-62],[16,1-62],[30,26-62],[30,0-62]],
		'ramp_fe_fg[0]' ,[[32,27-62],[25,27-62],[12,19-62],[12,15-62],[30,15-62],[28,2-62+57],[31,1-62+58],[31,0-62+58],[33,1-62],[31,1-62+60],[31,0-62+60],[15,16-62],[19,16-62],[18,0-62],[17,26-62],[17,24-62],[21,24-62],[16,1-62],[20,0-62],[13,25-62],[13,23-62],[31,1-62+60],[31,0-62+60],[26,18-62],[27,25-62]], #w/tgate and no fb, also needs buffer for GPIO
		'ramp_pfetinput[0]' ,[[32,1-62]], #w/tgate and no fb
		'ramp_pfetinput[1]' ,[[14,1-62]], #w/tgate and no fb
		#'ramp_fe_fg[0]' ,[[14,1-63],[12,0-63],[25,0-63],[13,18-63],[29,19-63],[27,26-63],[27,27-63],[27,19-63]], #w/tgate
		#'ramp_fe_fg[0]' ,[[14,1-63],[18,0-63],[25,0-63],[19,18-63],[29,19-63],[27,26-63],[27,24-63],[27,19-63]], #w nfet
		'sigma_delta_fe_fg[0]',[[27,17-63],[27,27-63],[12,26-63],[14,1-63]],
		'lpf_cap_3x[0:1]',[28,[-5,-2]],
		'lpf_cap_2x[0:1]',[28,[-4,-1]],
		'lpf_cap_1x[0:1]',[28,[-3, 0]],
		'lpf_cap_3x[2:3]',[29,[-5,-2]],# cap2 and 3
		'lpf_cap_2x[2:3]',[29,[-4,-1]],
		'lpf_cap_1x[2:3]',[29,[-3, 0]],
		'cap_1x[0:3]'	,[[28,29,28,29], 2], 
		'cap_2x[0:3]'	,[[28,29,28,29], 1],
            	'cap_3x[0:3]'	,[[28,29,28,29], 0],
		'volt_div_fg[0]' ,[[33,19-58]],
		'cap_1x_vd[0]'	,[28, 1], #cap0 for voltage divider[0] 58
		'cap_2x_vd[0]'	,[28, 0], #cap0 for voltage divider[0]
		'cap_3x_vd[0]'	,[28, -1], #cap0 for voltage divider[0]
		'cap_1x_vd[1]'	,[29,2], #cap0 for voltage divider[1]
		'cap_2x_vd[1]'	,[29,1], #cap0 for voltage divider[1]
		'cap_3x_vd[1]'	,[29,0], #cap0 for voltage divider[1]
		'volt_div_fg[1]',[[31,20-58]],
		'vd_target[0:1]',[[33,31],13-58],
		'ota0bias[0]'   ,[32,62], # for vmm sense amps
		'ota1bias[0]'   ,[32,63],
		'fgota0bias[0]' ,[32,62],
		'fgota1bias[0]' ,[32,63],
		'fgota0pbias[0]' ,[33,59],
		'fgota1pbias[0]' ,[33,61],
		'fgota0nbias[0]' ,[33,58],
		'fgota1nbias[0]' ,[33,60],
		'vmm_target[0]'  ,[0,0],
		'wta_fg[0]'	 ,[[19,23],[20,0],[21,24],[18,15],[29,15],[28,17]], # fix input0 to I12,I11 and output to 04
		'wta_primary_fg[0]'	 ,[[24,0],[24,24],[19,13],[21,14],[29,23],[28,17],[20,32]], # fix input0 to I12,I11 and output to 04
		'wta_bufbias[0]' ,[32,62], 
		'wta_primary_bufbias[0]' ,[32,62], 
		'wta_pfetbias[0]' ,[29,1],
		'wta_primary_pfetbias[0]' ,[29,1], 
		'wta_primary_pfetbias1[0]' ,[4,1], 
                'integrator_fg[0]',[[28,19-57],[28,27-57],[12,17-57],[25,17-57],[27,17-57],[26,18-57]],
                'integrator_nmirror_fg[0]',[[28,19-57],[28,27-57],[12,17-57],[25,17-57],[27,17-57],[26,18-57],[28,31-57]],
            	'nmirror_bias[0]', [[5, 1]],
            	'nmirror_bias[1]', [[4, 1]],
                'common_source_fg[0]',[[18,0],[25,24]],
		'integrator_ota0[0]'   ,[[32,62-57]],
	        'integrator_ota1[0]'   ,[[32,63-57]],
		'integrator_nmirror_ota0[0]'   ,[[32,62-57]],
	        'integrator_nmirror_ota1[0]'   ,[[32,63-57]],
	        'integrator_nmirror_ota2[0]'   ,[[5,1-57]],
	        'cs_bias[0]'   ,[[25,1]],
                'tgate_so_fg[0]',[[21,27],[19,28],[17,29],[15,30],[13,19],[11,19],[9,19],[7,19]],
		'vmm_senseamp1_fg[0]',[[33,17],[32,15]],
		'vmm_senseamp2_fg[0]',[[33,17],[32,15],[30,16],[31,18]],
		'SR_fg[0]'	     ,[[33,19],[32,20],[31,21],[30,22],[33,8],[32,12],[31,2],[30,6],[25,18+15],[25,19+15]],
		'vmm_bias[0:3]'	     ,[[33,32,31,30],0],
		'vmm4x4_target[0:3]',[33,[10,11,13,14]], # Shift-register0
		'vmm4x4_target[4:7]',[32,[10,11,13,14]], #SR1
		'vmm4x4_target[8:11]',[31,[10,11,13,14]], #SR2
		'vmm4x4_target[12:15]',[30,[10,11,13,14]],#SR3
		'vmm8x4_target[0:7]',[33,[10,11,13,14,3,4,5,7]], # Shift-register0
		'vmm8x4_target[8:15]',[32,[10,11,13,14,3,4,5,7]], #SR1
		'vmm8x4_target[16:23]',[31,[10,11,13,14,3,4,5,7]], #SR2
		'vmm8x4_target[24:31]',[30,[10,11,13,14,3,4,5,7]],#SR3
		'vmm8x4_in_target[0:7]',[33,[2,3,4,5,6,7,8,9]], # 
		'vmm8x4_in_target[8:15]',[32,[2,3,4,5,6,7,8,9]], # 
		'vmm8x4_in_target[16:23]',[31,[2,3,4,5,6,7,8,9]], # 
		'vmm8x4_in_target[24:31]',[30,[2,3,4,5,6,7,8,9]], # 
		'vmm12x1_target[0:11]',[19,[2,3,4,5,6,7,8,9,10,11,12,13]],#VMM target values
		'vmm12x1_fg[0]',[[19,23],[20,0],[21,24],[18,15],[27,15],[26,18],[21,31]],#VMM fg[19,23]
		'vmm12x1_pfetbias[0]' ,[18,1], #WTA pfet bias
		'vmm12x1_offsetbias[0]' ,[19,1], #WTA pfet bias,offset for the vmm
		'vmm12x1_otabias[0]' ,[32,63], #WTA pfet bias
		'fg_io_fg[0]'	,[[22,13]], # fg_io block
		'sftreg_fg[0]'  ,[[30,40],[30,41],[30,42],[30,43],[30,44],[30,45],[30,46],[30,47],[30,48],[30,49],[30,50],[30,51],[30,52],[30,53],[30,54],[30,55],[25,19+15+21]],
		'DAC_sftreg_fg[0]'  ,[[25,19+15+21],[33,1],[30,40],[30,41],[30,42],[30,43],[30,44],[30,45],[30,46],[30,47],[30,48],[30,49],[30,50],[30,51],[30,52],[30,53],[30,54],[30,55]],
		'DAC_sftreg_normal[0]'  ,[[33,1],[33,15],[25,33]],
		'DAC_bias_pfet[0]'  ,[25,0],
		'DAC_sftreg_target[0:5]'  ,[33,[8,9,10,11,12,13]],
		'DAC_sftreg_target[6:7]'  ,[[26,27],36],
		'DAC_sftreg_target[8:13]'  ,[33,[2,3,4,5,6,7]],
		'DAC_sftreg_target[14:15]'  ,[[28,29],36],
		'sftreg2_fg[0]' ,[[30,40],[30,41],[30,42],[30,43],[30,44],[30,45],[30,46],[30,47],[30,48],[30,49],[30,50],[30,51],[30,52],[30,53],[30,54],[30,55],[25,19+15+21]],
		'nfet_i2v_fg[0]', [[28,17],[29,24],[19,24],[18,0]],
		'nfet_i2v_otabias[0]', [32,62],
		'pfet_i2v_fg[0]', [[28,17],[29,26],[15,0],[14,0]],
		'pfet_i2v_otabias[0]', [32,62],
		'i2v_pfet_gatefgota_fg[0]', [[29,26],[14,0],[15,15],[28,17],[33,1],[32,15],[31,58],[31,59]], 
		'i2v_pfet_gatefgota_ota0bias[0]', [32,62],
		'i2v_pfet_gatefgota_fgotabias[0]', [32,58],
		'i2v_pfet_gatefgota_fgotapbias[0]', [33,59],
		'i2v_pfet_gatefgota_fgotanbias[0]', [33,58],
	        'mismatch_meas_fg[0]', [[31,26],[14,0],[15,15],[30,0],[33,1],[32,15],[31,58],[31,59],[31,60],[31,61],[31,27],[31,28]], 
		'mismatch_meas_pfetg_fgotabias[0]', [32,58],
		'mismatch_meas_pfetg_fgotapbias[0]', [33,59],
		'mismatch_meas_pfetg_fgotanbias[0]', [33,58],
		'mismatch_meas_out_fgotabias[0]', [32,60],
		'mismatch_meas_out_fgotapbias[0]', [33,61],
		'mismatch_meas_out_fgotanbias[0]', [33,60],
		'mismatch_meas_cal_bias[0]', [10,1],
                'mmap_ls_fg[0]' ,[[30,40],[30,41],[30,42],[30,43],[30,44],[30,45],[30,46],[30,47],[30,48],[30,49],[30,50],[30,51],[30,52],[30,53],[30,54],[30,55],[25,19+15+21]],
		'mmap_ls_in_r0_vdd[0]' ,[[33,1]],
		'mmap_ls_in_r0[0]' ,[[33,8],[33,9],[33,10],[33,11],[33,12],[33,13],[33,2],[33,3],[33,4],[33,5],[33,6],[33,7]],
		'mmap_ls_in_r1_vdd[0]' ,[[32,1]],
		'mmap_ls_in_r1[0]' ,[[32,8],[32,9],[32,10],[32,11],[32,12],[32,13],[32,2],[32,3],[32,4],[32,5],[32,6],[32,7]],
		'mmap_ls_in_r2_vdd[0]' ,[[31,1]],
		'mmap_ls_in_r2[0]' ,[[31,8],[31,9],[31,10],[31,11],[31,12],[31,13],[31,2],[31,3],[31,4],[31,5],[31,6],[31,7]],
		'mmap_ls_in_r3_vdd[0]' ,[[30,1]],
		'mmap_ls_in_r3[0]' ,[[30,8],[30,9],[30,10],[30,11],[30,12],[30,13],[30,2],[30,3],[30,4],[30,5],[30,6],[30,7]],
		'mmap_ls_in_r4_vdd[0]' ,[[29,1]],
		'mmap_ls_in_r4[0]' ,[[29,8],[29,9],[29,10],[29,11],[29,12],[29,13],[29,2],[29,3],[29,4],[29,5],[29,6],[29,7]],
		'mmap_ls_in_r5_vdd[0]' ,[[28,1]],
		'mmap_ls_in_r5[0]' ,[[28,8],[28,9],[28,10],[28,11],[28,12],[28,13],[28,2],[28,3],[28,4],[28,5],[28,6],[28,7]],
		'mmap_ls_in_r6_vdd[0]' ,[[27,1]],
		'mmap_ls_in_r6[0]' ,[[27,8],[27,9],[27,10],[27,11],[27,12],[27,13],[27,2],[27,3],[27,4],[27,5],[27,6],[27,7]],
		'mmap_ls_in_r7_vdd[0]' ,[[26,1]],
		'mmap_ls_in_r7[0]' ,[[26,8],[26,9],[26,10],[26,11],[26,12],[26,13],[26,2],[26,3],[26,4],[26,5],[26,6],[26,7]],
		'mmap_ls_in_r8_vdd[0]' ,[[25,1]],
		'mmap_ls_in_r8[0]' ,[[25,8],[25,9],[25,10],[25,11],[25,12],[25,13],[25,2],[25,3],[25,4],[25,5],[25,6],[25,7]],
		'mmap_ls_in_r9_vdd[0]' ,[[24,1]],
		'mmap_ls_in_r9[0]' ,[[24,8],[24,9],[24,10],[24,11],[24,12],[24,13],[24,2],[24,3],[24,4],[24,5],[24,6],[24,7]],
		'mmap_ls_in_r10_vdd[0]' ,[[23,1]],
		'mmap_ls_in_r10[0]' ,[[23,8],[23,9],[23,10],[23,11],[23,12],[23,13],[23,2],[23,3],[23,4],[23,5],[23,6],[23,7]],
		'mmap_ls_in_r11_vdd[0]' ,[[22,1]],
		'mmap_ls_in_r11[0]' ,[[22,8],[22,9],[22,10],[22,11],[22,12],[22,13],[22,2],[22,3],[22,4],[22,5],[22,6],[22,7]],
		'mmap_ls_in_r12_vdd[0]' ,[[21,1]],
		'mmap_ls_in_r12[0]' ,[[21,8],[21,9],[21,10],[21,11],[21,12],[21,13],[21,2],[21,3],[21,4],[21,5],[21,6],[21,7]],
		'mmap_ls_in_r13_vdd[0]' ,[[20,1]],
		'mmap_ls_in_r13[0]' ,[[20,8],[20,9],[20,10],[20,11],[20,12],[20,13],[20,2],[20,3],[20,4],[20,5],[20,6],[20,7]],
		'mmap_ls_in_r14_vdd[0]' ,[[19,1]],
		'mmap_ls_in_r14[0]' ,[[19,8],[19,9],[19,10],[19,11],[19,12],[19,13],[19,2],[19,3],[19,4],[19,5],[19,6],[19,7]],
		'mmap_ls_in_r15_vdd[0]' ,[[18,1]],
		'mmap_ls_in_r15[0]' ,[[18,8],[18,9],[18,10],[18,11],[18,12],[18,13],[18,2],[18,3],[18,4],[18,5],[18,6],[18,7]],
		'mmap_ls_in_r16_vdd[0]' ,[[17,1]],
		'mmap_ls_in_r16[0]' ,[[17,8],[17,9],[17,10],[17,11],[17,12],[17,13],[17,2],[17,3],[17,4],[17,5],[17,6],[17,7]],
		'mmap_ls_in_r17_vdd[0]' ,[[16,1]],
		'mmap_ls_in_r17[0]' ,[[16,8],[16,9],[16,10],[16,11],[16,12],[16,13],[16,2],[16,3],[16,4],[16,5],[16,6],[16,7]],
		'mmap_ls_in_r18_vdd[0]' ,[[15,1]],
		'mmap_ls_in_r18[0]' ,[[15,8],[15,9],[15,10],[15,11],[15,12],[15,13],[15,2],[15,3],[15,4],[15,5],[15,6],[15,7]],
		'mmap_ls_in_r19_vdd[0]' ,[[14,1]],
		'mmap_ls_in_r19[0]' ,[[14,8],[14,9],[14,10],[14,11],[14,12],[14,13],[14,2],[14,3],[14,4],[14,5],[14,6],[14,7]],
		'mmap_ls_in_r20_vdd[0]' ,[[13,1]],
		'mmap_ls_in_r20[0]' ,[[13,8],[13,9],[13,10],[13,11],[13,12],[13,13],[13,2],[13,3],[13,4],[13,5],[13,6],[13,7]],
		'mmap_ls_in_r21_vdd[0]' ,[[12,1]],
		'mmap_ls_in_r21[0]' ,[[12,8],[12,9],[12,10],[12,11],[12,12],[12,13],[12,2],[12,3],[12,4],[12,5],[12,6],[12,7]],
		'mmap_ls_in_r22_vdd[0]' ,[[11,1]],
		'mmap_ls_in_r22[0]' ,[[11,8],[11,9],[11,10],[11,11],[11,12],[11,13],[11,2],[11,3],[11,4],[11,5],[11,6],[11,7]],
		'mmap_ls_in_r23_vdd[0]' ,[[10,1]],
		'mmap_ls_in_r23[0]' ,[[10,8],[10,9],[10,10],[10,11],[10,12],[10,13],[10,2],[10,3],[10,4],[10,5],[10,6],[10,7]],
		'mmap_ls_in_r24_vdd[0]' ,[[9,1]],
		'mmap_ls_in_r24[0]' ,[[9,8],[9,9],[9,10],[9,11],[9,12],[9,13],[9,2],[9,3],[9,4],[9,5],[9,6],[9,7]],
		'mmap_ls_in_r25_vdd[0]' ,[[8,1]],
		'mmap_ls_in_r25[0]' ,[[8,8],[8,9],[8,10],[8,11],[8,12],[8,13],[8,2],[8,3],[8,4],[8,5],[8,6],[8,7]],
		'mmap_ls_in_r26_vdd[0]' ,[[7,1]],
		'mmap_ls_in_r26[0]' ,[[7,8],[7,9],[7,10],[7,11],[7,12],[7,13],[7,2],[7,3],[7,4],[7,5],[7,6],[7,7]],
		'mmap_ls_in_r27_vdd[0]' ,[[6,1]],
		'mmap_ls_in_r27[0]' ,[[6,8],[6,9],[6,10],[6,11],[6,12],[6,13],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7]],
		'mmap_ls_in_r28_vdd[0]' ,[[5,1]],
		'mmap_ls_in_r28[0]' ,[[5,8],[5,9],[5,10],[5,11],[5,12],[5,13],[5,2],[5,3],[5,4],[5,5],[5,6],[5,7]],
		'mmap_ls_in_r29_vdd[0]' ,[[4,1]],
		'mmap_ls_in_r29[0]' ,[[4,8],[4,9],[4,10],[4,11],[4,12],[4,13],[4,2],[4,3],[4,4],[4,5],[4,6],[4,7]],
		'mmap_ls_in_vdd1_vdd[0]' ,[[33,8],[32,9],[31,10],[30,11],[29,12],[28,13],[27,2],[26,3],[25,4],[24,5],[23,6],[22,7]],
		'mmap_ls_in_vdd1[0]' ,[[33,1],[32,1],[31,1],[30,1],[29,1],[28,1],[27,1],[26,1],[25,1],[24,1],[23,1],[22,1]],
		'mmap_ls_in_vdd2_vdd[0]' ,[[21,8],[20,9],[19,10],[18,11],[17,12],[16,13],[15,2],[14,3],[13,4],[12,5],[11,6],[10,7]],
		'mmap_ls_in_vdd2[0]' ,[[21,1],[20,1],[19,1],[18,1],[17,1],[16,1],[15,1],[14,1],[13,1],[12,1],[11,1],[10,1]],
		'mmap_ls_in_vdd3_vdd[0]' ,[[9,8],[8,9],[7,10],[6,11]],
		'mmap_ls_in_vdd3[0]' ,[[9,1],[8,1],[7,1],[6,1]],
		'mmap_ls_in_in12_1_vdd[0]' ,[[33,8],[32,9],[31,10],[30,11],[29,12],[28,13],[27,2],[26,3],[25,4],[24,5],[23,6],[22,7],[21,1],[21,14]],
		'mmap_ls_in_in12_1[0]' ,[[33,14],[32,14],[31,14],[30,14],[29,14],[28,14],[27,14],[26,14],[25,14],[24,14],[23,14],[22,14]],
		'mmap_ls_in_in12_2_vdd[0]' ,[[21,8],[20,9],[19,10],[18,11],[17,12],[16,13],[15,2],[14,3],[13,4],[12,5],[11,6],[10,7],[22,1],[22,14]],
		'mmap_ls_in_in12_2[0]' ,[[21,14],[20,14],[19,14],[18,14],[17,14],[16,14],[15,14],[14,14],[13,14],[12,14],[11,14],[10,14]],
		'mmap_ls_in_in12_3_vdd[0]' ,[[9,8],[8,9],[7,10],[6,11],[10,1],[10,14]],
		'mmap_ls_in_in12_3[0]' ,[[9,14],[8,14],[7,14],[6,14]],
                'th_logic_fg[0]', [28,17],
		'th_logic_otabias[0]', [32,62],
		#'th_logic_inbias[0]' ,[[28,2],[28,3],[28,4],[28,5],[28,6],[28,7],[28,8],[28,9]],
		'th_logic_inbias_0[0]' ,[[28,2]],
		'th_logic_inbias_1[0]' ,[[28,3]],
		'vmm_volatile[0]'     ,[[30,40],[30,44],[30,48],[30,52],[25,54]]]#volatile switch in shift register
		
        self.dev_fgs = smDictFromList(dev_fgs_sm)
	#pdb.set_trace()
     
    
class cab_vmm(complexBlock):
    def __init__(self, name):
        
        self.name = name
        self.type = 'CAB_VMM'
        self.stats = cab_vmmStats()     
        self.array_stats = arrayStats()
        self.subblocks = []
        
        #CAB ports
        self.inputs = ['open']*self.stats.num_inputs
        self.outputs = ['open']*self.stats.num_outputs

        #CAB Devices
        dev_types = self.stats.dev_types
        dev_pins = self.stats.dev_pins 
	#pdb.set_trace()  
        self.addSubs(dev_types, dev_pins)
        
    def genLI(self, *var):
        self.swcs = []
	#print a
	#pdb.set_trace()
        #cab = rasp3array().array['cab']
        verbose = 0
        if len(var) == 1: verbose = 1
        
        #inputs to local interconnect--
        #   inputs to CAB + outputs from DEVs
        self.li_in_in = ['gnd','vcc']+self.inputs
        self.li_in_dev = []
        for i in range(len(self.subblocks)):
	    if isinstance(self.getSub(i).outputs,str):
	    	self.getSub(i).outputs= self.getSub(i).outputs.split()
	    for j in range(len(self.getSub(i).outputs)):
            	self.li_in_dev.append(self.getSub(i).outputs[j])
        self.li_in_dev.reverse()
        self.li_in = self.li_in_in + self.li_in_dev
       
        #outputs from local interconnect--
        #   inputs to DEVs + outputs from CAB
        self.li_out_out = self.outputs
        self.li_out_dev = []
        for i in range(len(self.subblocks)):
            for j in range(len(self.getSub(i).inputs)):
                self.li_out_dev.append(self.getSub(i).inputs[j])      
        self.li_out = self.li_out_dev+self.li_out_out 
        #pdb.set_trace()
        self.li = [[0]*len(self.li_in) for x in self.li_out]
        #pdb.set_trace()
        #printing connectivity matrix and filling the local interconnect matrix
        x = 1
        for i in range(len(self.li_in)):
            if verbose: print '%s'%str(i).ljust(2),
        if verbose: 
		print
        	#pdb.set_trace()    
        for i in range(len(self.li_in)):
            if self.li_in[i] != 'open':
                if verbose: print '%s'%self.li_in[i].ljust(x),
            else:
                if verbose: print ''.ljust(x),
        if verbose: print
	#pdb.set_trace()
        for i in range(len(self.li_out_dev)):
            if self.li_out[i] != 'open':
                for j in range(len(self.li_in)):
		    #print self.li_out[i]
                    if self.li_out[i] == self.li_in[j]:
                        if verbose: print str('X').ljust(x),
                        self.li[i][j] = 1
                    else:
                        if verbose: print str('.').ljust(x),
                if verbose: 
                    print self.li_out[i].ljust(2), 
                    print str(i).ljust(2)
            else:
                for j in range(len(self.li_in)):
                    if verbose: print str('.').ljust(x),
                if verbose: print '%s%s'%(''.ljust(3), str(i).ljust(2))
        #pdb.set_trace()        
        for i in range(len(self.li_out_out)):
            for j in range(len(self.li_in_in)):
                if verbose: print ''.ljust(x),
            for j in range(len(self.li_in_dev)):
                if self.li_out_out[i] == self.li_in_dev[j] and self.li_out_out[i] != 'open':
                    if verbose: print 'X'.ljust(x),
                    self.li[i+len(self.li_out_dev)][j+len(self.li_in_in)] = 1
                else:
                    if verbose: print '.'.ljust(x),
            if self.li_out_out[i] == 'open':
                if verbose: print self.li_out_out[i]
            else:
                if verbose: print self.li_out_out[i]
                
        #actually generating the switches addresses here  
        self.swcsFromLi()    
                 
    def dispLI(self):
        self.genLI('verbose')
        
    def genDevFgs(self):
	print "getting here!"
        verbose = 1
        for i in range(len(self.subblocks)):
            sb = self.getSub(i)
	    #pdb.set_trace()
	    #print sb
            if sb.outputs != 'open':
                swc_name0 = sb.name
                #pdb.set_trace()
                if sb.ex_fgs:
		    ex_fg=sb.ex_fgs.split("&")
		    #pdb.set_trace()
		    for s in range(len(ex_fg)):
			    for j in ex_fg[s].split()[::2]:
				if swc_name0 in["ladder_blk[0]","c4_blk[0]","speech[0]","INFneuron[0]","lpf[0]","peak_detector[0]","ramp_fe[0]",'sigma_delta_fe[0]','nmirror_vmm[0]']:
					#pdb.set_trace()
					swc_name1 = j
				#elif 
				elif swc_name0 in ["vmm4x4_SR[0]","vmm4x4_SR2[0]","vmm8x4_SR[0]",'vmm4x4[0]','vmm8x4[0]','vmm8x4_in[0]','vmm12x1[0]','DAC_sftreg[0]']:
				    swc_name1 = j+'['+sb.name.split('[')[1]
				     #pdb.set_trace()
				    if swc_name0 in ['vmm4x4_SR[0]','vmm4x4_SR2[0]','vmm4x4[0]']:
					vmm_size=16
					vmm_str='vmm4x4_target'
				    elif swc_name0 in ['vmm12x1[0]']:
					vmm_size=12
					vmm_str='vmm12x1_target'
				    elif swc_name0 in ['DAC_sftreg[0]']:
					vmm_size=16
					vmm_str='DAC_sftreg_target'
				    elif swc_name0 in ['vmm8x4_in[0]']:
					vmm_size=32
					vmm_str='vmm8x4_in_target'
        			    elif swc_name0 in ['vmm8x4[0]']:
					vmm_size=32
					vmm_str='vmm8x4_target'
                                    if swc_name1 in ['vmm4x4_target[0]','vmm8x4_target[0]','vmm8x4_in_target[0]','vmm12x1_target[0]','DAC_sftreg_target[0]']:
					targets=list(ex_fg[s].split("=")[1].split(","))
					for h in range(0,vmm_size):
					    swc_name1=vmm_str+'['+str(h)+']'
					     #pdb.set_trace()
					    swc2 = self.stats.dev_fgs[swc_name1]
					     #pdb.set_trace()
					    swcx = self.array_stats.getTileOffset(swc2, self.grid_loc)
					     #pdb.set_trace()
					    swcx.append(targets[h])
					    swcx.append(1)
					    self.swcs.append(swcx)
					    if verbose: print '%s %s -> (%g %g) -> (%g %g)'%(swc_name0, swc_name1, swc2[0], swc2[1], swcx[0], swcx[1])
					#pdb.set_trace()
					continue
				    elif swc_name1=='vmm_bias[0]':
					targets=list(ex_fg[s].split("=")[1].split(","))
					#pdb.set_trace()
					for h in range(0,4):
					    swc_name1='vmm_bias['+str(h)+']'
					    swc2 = self.stats.dev_fgs[swc_name1]
					    swcx = self.array_stats.getTileOffset(swc2, self.grid_loc)
					    swcx.append(targets[h])
					    swcx.append(1)
					    self.swcs.append(swcx)
					    if verbose: print '%s %s -> (%g %g) -> (%g %g)'%(swc_name0, swc_name1, swc2[0], swc2[1], swcx[0], swcx[1])
					#pdb.set_trace()
					continue
				    else:
					#pdb.set_trace()
					swc_name1 = j+'['+sb.name.split('[')[1]
				else:
		                	swc_name1 = j+'['+sb.name.split('[')[1]
		                swc0 = self.stats.dev_fgs[swc_name0]
		                swc2 = self.stats.dev_fgs[swc_name1]
				#pdb.set_trace()
				for n in range(len(swc2)):
					if isinstance(swc2[0],int):
						swc1=swc2
					else:
						swc1=swc2[n]
				        swc = [swc0[0]+swc1[0], swc0[1]+swc1[1]]
				        swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
				        if verbose: print '%s %s -> (%g %g) -> (%g %g)'%(swc_name0, swc_name1, swc[0], swc[1], swcx[0], swcx[1])
					#if swc_name1 in['vmm_volatile[0]'] :
					#	#pdb.set_trace()
					#	swcx.append(1)
					
					if n==0 and swc_name1 not in ['sftreg_fg[0]', 'DAC_sftreg_fg[0]','sftreg2_fg[0]','nfet_i2v_fg[0]','pfet_i2v_fg[0]','i2v_pfet_gatefgota_fg[0]','mismatch_meas_fg[0]','mmap_ls_fg[0]','mmap_ls_in_r0_vdd[0]','mmap_ls_in_r0[0]','mmap_ls_in_r1_vdd[0]','mmap_ls_in_r1[0]','mmap_ls_in_r2_vdd[0]','mmap_ls_in_r2[0]','mmap_ls_in_r3_vdd[0]','mmap_ls_in_r3[0]','mmap_ls_in_r4_vdd[0]','mmap_ls_in_r4[0]','mmap_ls_in_r5_vdd[0]','mmap_ls_in_r5[0]','mmap_ls_in_r6_vdd[0]','mmap_ls_in_r6[0]','mmap_ls_in_r7_vdd[0]','mmap_ls_in_r7[0]','mmap_ls_in_r8_vdd[0]','mmap_ls_in_r8[0]','mmap_ls_in_r9_vdd[0]','mmap_ls_in_r9[0]','mmap_ls_in_r10_vdd[0]','mmap_ls_in_r10[0]','mmap_ls_in_r11_vdd[0]','mmap_ls_in_r11[0]','mmap_ls_in_r12_vdd[0]','mmap_ls_in_r12[0]','mmap_ls_in_r13_vdd[0]','mmap_ls_in_r13[0]','mmap_ls_in_r14_vdd[0]','mmap_ls_in_r14[0]','mmap_ls_in_r15_vdd[0]','mmap_ls_in_r15[0]','mmap_ls_in_r16_vdd[0]','mmap_ls_in_r16[0]','mmap_ls_in_r17_vdd[0]','mmap_ls_in_r17[0]','mmap_ls_in_r18_vdd[0]','mmap_ls_in_r18[0]','mmap_ls_in_r19_vdd[0]','mmap_ls_in_r19[0]','mmap_ls_in_r20_vdd[0]','mmap_ls_in_r20[0]','mmap_ls_in_r21_vdd[0]','mmap_ls_in_r21[0]','mmap_ls_in_r22_vdd[0]','mmap_ls_in_r22[0]','mmap_ls_in_r23_vdd[0]','mmap_ls_in_r23[0]','mmap_ls_in_r24_vdd[0]','mmap_ls_in_r24[0]','mmap_ls_in_r25_vdd[0]','mmap_ls_in_r25[0]','mmap_ls_in_r26_vdd[0]','mmap_ls_in_r26[0]','mmap_ls_in_r27_vdd[0]','mmap_ls_in_r27[0]','mmap_ls_in_r28_vdd[0]','mmap_ls_in_r28[0]','mmap_ls_in_r29_vdd[0]','mmap_ls_in_r29[0]','mmap_ls_in_vdd1_vdd[0]','mmap_ls_in_vdd1[0]','mmap_ls_in_vdd2_vdd[0]','mmap_ls_in_vdd2[0]','mmap_ls_in_vdd3_vdd[0]','mmap_ls_in_vdd3[0]','mmap_ls_in_in12_1_vdd[0]','mmap_ls_in_in12_1[0]','mmap_ls_in_in12_2_vdd[0]','mmap_ls_in_in12_2[0]','mmap_ls_in_in12_3_vdd[0]','mmap_ls_in_in12_3[0]','th_logic_fg[0]']: 
						swcx.append(ex_fg[s].split('=')[1])
					#else:
						#swcx.append(0)
					#pdb.set_trace()	
					if ex_fg[s].split('=')[0] in ['ota_p_bias ','ota_n_bias ','fgota0nbias ','fgota0pbias ','fgota1nbias ','fgota1pbias ','i2v_pfet_gatefgota_fgotapbias[0]','i2v_pfet_gatefgota_fgotanbias[0]','mismatch_meas_pfetg_fgotapbias[0]','mismatch_meas_pfetg_fgotanbias[0]','mismatch_meas_out_fgotapbias[0]','mismatch_meas_out_fgotanbias[0]']:
						swcx.append(3)
					elif swc_name1 in ['c4_ota_p_bias[0]','c4_ota_n_bias[0]','c4_ota_p_bias[1]','c4_ota_n_bias[1]','peak_ota_n_bias[0]','peak_ota_p_bias[0]']:
						swcx.append(3)	
					elif swc_name1 in ['c4_ota_bias[0]','c4_ota_bias[1]','peak_ota_bias[0]','wta_bufbias[0]','wta_primary_bufbias[0]','speech_peakotabias[0]','speech_peakotabias[1]','vmm12x1_otabias[0]','nfet_i2v_otabias[0]','pfet_i2v_otabias[0]','i2v_pfet_gatefgota_ota0bias[0]','i2v_pfet_gatefgota_fgotabias[0]','mismatch_meas_pfetg_fgotabias[0]','mismatch_meas_out_fgotabias[0]','th_logic_otabias[0]']:
						swcx.append(2)
					elif ex_fg[s].split('=')[0] in ['ota0bias ','ota1bias ','fgota0bias ','fgota1bias ','integrator_ota0 ','integrator_ota1 ','integrator_nmirror_ota0 ','integrator_nmirror_ota1 ','fgota_biasfb[0] ','fgota_biasfb[1] ','fgota_biasfb '] and n==0:
					        #pdb.set_trace()
						swcx.append(2)
					elif swc_name1 == 'fgota_biasfb[0] 'and n==0:
						swcx.append(2)
					elif swc_name1 == 'fgota_biasfb[1] 'and n==0:
						swcx.append(2)
					elif swc_name1 in ['vd_target[0]','vd_target[1]','ramp_pfetinput[0]','ramp_pfetinput[1]','wta_pfetbias[0]','wta_primary_pfetbias1[0]','wta_primary_pfetbias[0]','speech_pfetbias[0]','speech_pfetbias[1]','vmm12x1_pfetbias[0]','integrator_nmirror_ota2 ','DAC_bias_pfet[0]','vmm12x1_offsetbias[0]','fg_io_fg[0]','nmirror_bias[0]','INF_bias[0]','cs_bias[0]','mismatch_meas_cal_bias[0]']:
						swcx.append(1)
                                        elif sb.name.split('[')[0] in ['ota','ota_vmm','ota_buf','fgota','ladder_blk','c4_blk','INFneuron','lpf','ramp_fe','sigma_delta_fe'] and swc_name1[0:6]!="c4_cap" and  swc_name1[0:5]!="c4_fg" and n==0 and swc_name1 not in ['INF_fg[0]','lpf_fg[0]','peak_detector[0]'] and swc_name1[0:7] not in ['lpf_cap','ramp_fe','sigma_d'] :
						#pdb.set_trace()
						swcx.append(2)
					elif swc_name1 in ['mmap_ls_in_r0[0]','mmap_ls_in_r1[0]','mmap_ls_in_r2[0]','mmap_ls_in_r3[0]','mmap_ls_in_r4[0]','mmap_ls_in_r5[0]','mmap_ls_in_r6[0]','mmap_ls_in_r7[0]','mmap_ls_in_r8[0]','mmap_ls_in_r9[0]','mmap_ls_in_r10[0]','mmap_ls_in_r11[0]','mmap_ls_in_r12[0]','mmap_ls_in_r13[0]','mmap_ls_in_r14[0]','mmap_ls_in_r15[0]','mmap_ls_in_r16[0]','mmap_ls_in_r17[0]','mmap_ls_in_r18[0]','mmap_ls_in_r19[0]','mmap_ls_in_r20[0]','mmap_ls_in_r21[0]','mmap_ls_in_r22[0]','mmap_ls_in_r23[0]','mmap_ls_in_r24[0]','mmap_ls_in_r25[0]','mmap_ls_in_r26[0]','mmap_ls_in_r27[0]','mmap_ls_in_r28[0]','mmap_ls_in_r29[0]','mmap_ls_in_vdd1[0]','mmap_ls_in_vdd2[0]','mmap_ls_in_vdd3[0]','mmap_ls_in_in12_1[0]','mmap_ls_in_in12_2[0]','mmap_ls_in_in12_3[0]']:
						swcx.append(ex_fg[s].split('=')[1])
                                                swcx.append(11)
					elif swc_name1 in ['th_logic_inbias_0[0]','th_logic_inbias_1[0]']:
                                                swcx.append(1)
					#else:
						#swcx.append(0)
				        self.swcs.append(swcx)
					#if swc_name1[0:6]=="c4_cap": pdb.set_trace()
					if isinstance(swc2[0],int): break

                        
