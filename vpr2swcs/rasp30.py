import pdb
from genu import *

class rasp30(stats):
    def __init__(self):
        self.array = arrayStats()
        self.cab = cabStats()
        self.cab2 = cab2Stats()
        self.clb = clbStats()
        self.io_sd = iosdStats()
        self.io_w = iowStats()
        self.io_sa = iosaStats()
        self.io_e = ioeStats()
	self.io_el = ioelStats()
        self.io_na= iosaStats()
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
            ['io_sa', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'io_na'],
            ['io_sa', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'cab', 'io_na'],
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
        addrs = {'y':{'io_sd':1, 'clb':1, 'io_nd':0}, 'x':{'io_w':0, 'clb':34,'cab':34,'cab2':34, 'io_e':34}}
        
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
#   CAB stats 
###########################################   
class cabStats(stats):
    def __init__(self):
        global ladder_blk
	ladder_blk=0
        self.num_inputs = 16
        self.num_outputs = 24 #8+4
        
        #self.pin_order = ['I3','I2','I1','I0','I7','I6','I5','I4','I11','I10','I9','I8','XI9','I14','I13','I12','O3','O2','O1','O0','O7','O6','O5','O4']

	self.pin_order =['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15','O0','O1','O2','O3','O4','O5','O6','O7','IO','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15']	
#self.pin_order = ['I0','I4','I8','I12','I2','I6','I10','I14','I3','I7','I1','I5','I9','I11','I15','I15','O3','O2','O1','O0','O7','O6','O5','O4']
	################## 0    1     2   3      4    5    6     7    8    9     10   11   12    13    14    15	      
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
            #'XI0',  [ 0,33],#to match w/ dif tile
            #'XI4',  [ 0,34], #to match w/ dif tile
            #'XI8',  [ 0,35],#to match w/ dif tile
			#'XI12', [ 0,36], # $$might have to include more?? hmmm XI<0,4,8,12?> # $$might have to include more?? hmmm XI<0,4,8,12?>
            #DXO0',  [ 0,37],
			#'XO4',  [ 0,38],
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
        li_sm_0a = ['gnd','vcc','cab.I[0:15]']
# outputs order into the CAB   ## order is very important here
        li_sm_0b = ['fgota[0:1].out[0]','ota_buf[0].out[0]','ota[0].out[0]','cap[0:3].out[0]','nfet[0:1].out[0]','pfet[0:1].out[0]','tgate[0:3].out[0]','nmirror[0:1].out[0]','ladder_blk[0].out[0:1]','c4_blk[0].out[0]','Nagating_blk[0].out[0]','speech[0].out[0:1]','gnd_out[0].out[0]','vdd_out[0].out[0]','in2in_x1[0].out[0]','in2in_x6[0].out[0]','volt_div[0:1].out[0]','integrator[0].out[0]','integrator_nmirror[0].out[0]','INFneuron[0].out[0]','lpf[0].out[0]','nfet_i2v[0].out[0]','peak_detector[0].out[0]','pfet_i2v[0].out[0]','i2v_pfet_gatefgota[0].out[0]','mismatch_meas[0].out[0]','mmap_local_swc[0].out[0]','ramp_fe[0].out[0]','sigma_delta_fe[0].out[0]','cap_sense[0].out[0]','HOP_bif[0].out[0]','lpf_2[0].out[0]','hhneuron[0].out[0:2]','ladder_filter[0].out[0:2]','h_rect[0].out[0]','hh_neuron_b_debug[0].out[0:2]','dendiff[0].out[0]','switch_cap[0].out[0]','common_drain[0].out[0]','common_source1[0].out[0]']
# defining the inputs order into the CAB #?? last term to connect i/ps to o/ps? ## order is very important here
        li_sm_1 = ['fgota[0:1].in[0:1]','ota_buf[0].in[0]','ota[0].in[0:1]','cap[0:3].in[0]','nfet[0:1].in[0:1]','pfet[0:1].in[0:1]','tgate[0:3].in[0:1]','nmirror[0:1].in[0]','ladder_blk[0].in[0:1]','c4_blk[0].in[0:1]','Nagating_blk[0].in[0:1]','speech[0].in[0:2]','gnd_out[0].in[0:1]','vdd_out[0].in[0:1]','in2in_x1[0].in[0:2]','in2in_x6[0].in[0:12]','volt_div[0:1].in[0:1]','integrator[0].in[0:2]','integrator_nmirror[0].in[0:2]','INFneuron[0].in[0:2]','lpf[0].in[0]','nfet_i2v[0].in[0]','peak_detector[0].in[0:1]','pfet_i2v[0].in[0]','i2v_pfet_gatefgota[0].in[0]','mismatch_meas[0].in[0:2]','mmap_local_swc[0].in[0:2]','ramp_fe[0].in[0]','sigma_delta_fe[0].in[0:2]','cap_sense[0].in[0:1]','HOP_bif[0].in[0]','lpf_2[0].in[0]','hhneuron[0].in[0:3]','ladder_filter[0].in[0:1]','h_rect[0].in[0:1]','hh_neuron_b_debug[0].in[0:3]','dendiff[0].in[0:5]','switch_cap[0].in[0:4]','common_drain[0].in[0:1]','common_source1[0].in[0]','cab.O[0:5]'] 
	   #O/PS        
        li_sm = ['gnd'             ,[0,  0],     #inputs from CAB and device outputs
            'vcc'                ,[0,  1],#y
            'cab.I[0:12]'        ,[0, range( 2, 15)],#y to be shifted for the decoder
	    #O/PS OF CAB DEVICES
	    'fgota[0:1].out[0]'  ,[0, range(15, 17)],#y
	    'h_rect[0].out[0]', [0,26], # Half Wave Rectifier
	    'ota_buf[0].out[0]'  ,[0, 17],#y
            'ota[0].out[0]'      , [0, 18],#y
            'HOP_bif[0].out[0]'      , [0, 16],#y
            'ladder_filter[0].out[0:2]'      , [0, [15,16,18]],#y
            'hh_neuron_b_debug[0].out[0:2]'      , [0, [17,18,16]], #Vout, V_Na, V_K
            'cap[0:3].out[0]'    ,[0, range(19, 23)],#y                                
            'nfet[0:1].out[0]'   ,[0, range(24, 22, -1)],#y numbering chnge for nFET0(24) and nFET1(23), needs to be verified
            'pfet[0:1].out[0]'   ,[0, range(26, 24,-1)],#y numbering chnge for pFETt0(26) and pFET1(23)
            'tgate[0:3].out[0]'  ,[0, range(27, 31)],#y
            'nmirror[0:1].out[0]',[0, range(31, 33)],#y
	    'ladder_blk[0].out[0:2]',[0,[17,15,16]],
	    'c4_blk[0].out[0]'	 ,[0,15],# c4 with floating gates
	    'Nagating_blk[0].out[0]'  ,[0,15],
	    'speech[0].out[0:1]'	 ,[0,[17,26]],  #25 only c4 and pd. 26 with pfet out to inverse. 
	    'gnd_out[0].out[0]',[0,24],
	    'vdd_out[0].out[0]',[0,24],
	    'in2in_x1[0].out[0]',[0,24],
	    'switch_cap[0].out[0]',[0,18],
            'in2in_x6[0].out[0]',[0,24],
            'common_drain[0].out[0]',[0,24],
		'common_source1[0].out[0]',[0,24],
	    'volt_div[0:1].out[0]',[0,[15,16]],
            'integrator[0].out[0]',[0,18],
            'integrator_nmirror[0].out[0]',[0,18],
            'lpf[0].out[0]',[0, 17],
	    'peak_detector[0].out[0]',[0,25], # 
            'nfet_i2v[0].out[0]',[0, 2+15],
            'pfet_i2v[0].out[0]',[0, 2+15],
            'i2v_pfet_gatefgota[0].out[0]',[0,17], #ota0 output
            'mismatch_meas[0].out[0]',[0,16], #fgota1 output
	    'mmap_local_swc[0].out[0]'   ,[0,18+15], #chose col-18
	    'INFneuron[0].out[0]',[0,17],
	    'ramp_fe[0].out[0]' , [0,18], #26
	    'sigma_delta_fe[0].out[0]', [0,17], #[0,[18,17]], # 18:ota1.out 17: ota0.out
	    'cap_sense[0].out[0]'     , [0,18],
	    'volswc[0:1].out[0]',[0, range(33, 35)],
	    'lpf_2[0].out[0]', [0,18],
	    'hhneuron[0].out[0:2]',[0,[18,15,16]],#Vmem,VNa,VK
	    'dendiff[0].out[0]',[0,0],
	    'fgota[0:1].in[0:1]' ,[range(33,29,-1), 0],# in<0:7> y its high because of the decoded address where 4==33 for 
	    'h_rect[0].in[0:1]'  , [[29, 28], 0],
            'ota_buf[0].in[0]' ,  [29, 0],# in<0:7> y
	    'ota[0].in[0:1]'     ,[range(27,25,-1), 0],# in<0:7> y
            'cap[0:3].in[0]'     ,[range(25,21,-1), 0],# in<8:11 y
            'nfet[0:1].in[0:1]'  ,[[19, 18, 21, 20], 0],# in<12:15> y 21, 17,-1) it's flipped
            'pfet[0:1].in[0:1]'  ,[[15, 14, 17, 16], 0],# in<16:19> n---change (17, 13,-1) it;s flipped
            'tgate[0:3].in[0:1]' ,[range(13,5,-1), 0],# in<20:27> y
            'nmirror[0:1].in[0]' ,[range(5,3,-1), 0],# in<28:29> y
	    'ladder_blk[0].in[0:1]',[[33,30],0],
	    'c4_blk[0].in[0:1]'   ,[[33,25],0],
	    'Nagating_blk[0].in[0:1]'   ,[[33,25],0],
	    'speech[0].in[0:2]'   ,[[33,25,14],0],#25
            'gnd_out[0].in[0:1]'	 ,[[19,33],0],
            'vdd_out[0].in[0:1]'	 ,[[19,33],0],
            'in2in_x1[0].in[0:2]'	  ,[[19,33,33],0],
            'switch_cap[0].in[0:4]'	  ,[[27,12,13,11,9],0],
            'in2in_x6[0].in[0:12]'	  ,[[19,33,33,32,32,31,31,30,30,29,29,28,28],0],
	    'volt_div[0:1].in[0:1]', [[25,33,24,31],0],
            'integrator[0].in[0:2]'	  ,[[29,28,13],0],
            'integrator_nmirror[0].in[0:2]'	  ,[[29,28,13],0],
            'lpf[0].in[0]'	  ,[29,0],
            'nfet_i2v[0].in[0]',[29,0],
		'common_source1[0].in[0]'	  ,[19,0],
            'common_drain[0].in[0:1]',[[19,21],0],
            'pfet_i2v[0].in[0]',[29,0],
            'i2v_pfet_gatefgota[0].in[0]',[29,0], #ota0's in0
            'mismatch_meas[0].in[0:2]',[[12,13,11],0], #tgate0's in, s and tgate1's s
	    'peak_detector[0].in[0:1]',[[33,17],0], #fgota.0[in0] pfet[gate]
            'HOP_bif[0].in[0]'      , [33,0],#y
            'ladder_filter[0].in[0:1]'      , [[33,30],0],#y
            'hh_neuron_b_debug[0].in[0:3]'      , [[33,14,18,27],0],  #Vin, E_Na, E_K, Vref
	    'INFneuron[0].in[0:2]',[[27,29,21],0],#ota[in0] ota1[in1] and nfet[in0]
	    'ramp_fe[0].in[0]' , [31,0], #26: ota1.n 18:pfet0.gate
	    'sigma_delta_fe[0].in[0:2]', [[33,32,13],0], #29:ota0+, 26:ota1 28:ota0- - 19:nfet0.gate 21 nfet1.gate
	    'cap_sense[0].in[0:1]'     , [[29,28],0],
	    'lpf_2[0].in[0]', [29,0],
	    'hhneuron[0].in[0:3]',[[25,26,16,33],0],#Vin,EK,ENa,Vref
	    'vco[0].in[0]',[15,0],
	    'dendiff[0].in[0:5]',[[26,27,25,24,23,22],-1],
	    #'sigma_delta_fe[0].in[:4]', [[13,15],0], ## weird doesn't like 4 in a row...hmm
	    'cab.O[0:5]'          ,[range( 29, 23, -1), 21]] ## o/ps connectn to i/ps?? ummmmm !!! ---we need this 
        self.li = smDictFromList(li_sm)
        li0b = recStrExpand(li_sm_0b)
        li0b.reverse()
        self.li0 = recStrExpand(li_sm_0a) + li0b
        self.li1 = recStrExpand(li_sm_1)
        #pdb.set_trace()
        #CAB Devices ## order is very important here
	self.dev_types =['fgota']*2 + ['ota_buf']*1 + ['ota']*1 + ['cap']*4+ ['nfet']*2 + ['pfet']*2 + ['tgate']*4 +['nmirror']*2+['ladder_blk']*1+ ['c4_blk']*1+['Nagating_blk']*1+['speech']*1+['gnd_out']*1+['vdd_out']*1+['in2in_x1']*1+['in2in_x6']*1+['volt_div']*2+['integrator']*1+['integrator_nmirror']*1+['INFneuron']*1+['lpf']*1+['nfet_i2v']*1+['peak_detector']*1+['pfet_i2v']*1+['i2v_pfet_gatefgota']*1+['mismatch_meas']*1+['mmap_local_swc']*1+['ramp_fe']*1+['sigma_delta_fe']*1+['cap_sense']*1+['HOP_bif']*1+['lpf_2']*1+['hhneuron']*1+['ladder_filter']*1+ ['h_rect']*1+['hh_neuron_b_debug']*1+['dendiff']*1+['switch_cap']*1+['common_drain']*1+['common_source1']*1
	self.dev_pins = {'fgota_in':2,'ota_buf_in':1,'ota_in':2, 'cap_in':1, 'nfet_in':2, 'pfet_in':2,'tgate_in':2, 'nmirror_in':1,'ladder_blk_in':2, 'c4_blk_in':2,'Nagating_blk_in':2,'speech_in':3,'gnd_out_in':2,'vdd_out_in':2,'in2in_x1_in':3,'in2in_x6_in':13,'volt_div_in':2,'integrator_in':3,'integrator_nmirror_in':3,'INFneuron_in':3,'lpf_in':1,'nfet_i2v_in':1,'peak_detector_in':2,'pfet_i2v_in':1,'i2v_pfet_gatefgota_in':1,'mismatch_meas_in':3,'ramp_fe_in':1,'sigma_delta_fe_in':3,'cap_sense_in':2,'HOP_bif_in':1,'lpf_2_in':1,'hhneuron_in':4,'ladder_filter_in':2,'h_rect_in':2,'hh_neuron_b_debug_in':4,'dendiff_in':6,'switch_cap_in':5,'common_source1_in':1,'common_drain_in':2,'fgota_out':1,'ota_buf_out':1,'ota_out':1, 'cap_out':1, 'nfet_out':1, 'pfet_out':1,'tgate_out':1, 'nmirror_out':1,'ladder_blk_out':2, 'c4_blk_out':1,'Nagating_blk_out':1,'speech_out':2,'gnd_out_out':1,'vdd_out_out':1,'in2in_x1_out':1,'in2in_x6_out':1,'volt_div_out':1,'integrator_out':1,'integrator_nmirror_out':1,'INFneuron_out':1,'lpf_out':1,'nfet_i2v_out':1,'peak_detector_out':1,'pfet_i2v_out':1,'i2v_pfet_gatefgota_out':1,'mismatch_meas_out':1,'mmap_local_swc_in':3, 'mmap_local_swc_out':1,'ramp_fe_out':1,'sigma_delta_fe_out':1,'cap_sense_out':1,'HOP_bif_out':1,'lpf_2_out':1,'hhneuron_out':3,'ladder_filter_out':3,'h_rect_out':1,'hh_neuron_b_debug_out':3,'dendiff_out':1,'switch_cap_out':1,'common_source1_out':1,'common_drain_out':1}  
        dev_fgs_sm = ['fgota[0:1]',[0, [58, 60]],## block names
		'ota_buf[0]' 	,[0, 62],
		'lpf[0]'	,[0, 62],
		'nfet_i2v[0]'	,[0, 0],
		'pfet_i2v[0]'	,[0, 0],
		'i2v_pfet_gatefgota[0]'	,[0, 0],
		'mismatch_meas[0]'	,[0, 0],
		'mmap_local_swc[0]' , [0,0],
	        'ota[0]'	,[0, 63],
		'switch_cap[0]'	,[0, 0],
		'common_source1[0]' ,[0,0],
		'common_drain[0]'	,[0, 0],
		'ladder_blk[0]' ,[0,0],
		'c4_blk[0]'  	, [0,62], # set as ota[0] now
		'Nagating_blk[0]'  ,[0,62],
		'HOP_bif[0]'  	, [0,62], 
		'vco[0]'  	, [0,62], 
		'ladder_filter[0]'  	, [0,62],
		'h_rect[0]', [0, 0], 
		'hh_neuron_b_debug[0]'  	, [0,62], 
		'speech[0]'  	, [0,62], 
		'gnd_out[0]' ,[0,0],
		'vdd_out[0]' ,[0,0],
		'in2in_x1[0]' ,[0,0],
		'in2in_x6[0]' ,[0,0],
		'ramp_fe[0]'    ,[0,62],
		'lpf_2[0]' ,[0,0],
		'hhneuron[0]' ,[0,0],
		'dendiff[0]',[0,0],
		'volt_div[0:1]' ,[0, [58, 60]],
                'integrator[0]' ,[0,57],
                'integrator_nmirror[0]' ,[0,57],
                'INFneuron[0]' 	, [0,62], # set as ota[0] now
		'peak_detector[0]' , [0,62],
		'sigma_delta_fe[0]',[0,62],
		'cap_sense[0]',[0,0],
		'nmirror[0]',[0,0],
            	'cap[0:3]'	,[0, [57,60,57,60]],
		##### now the define parts
            	'ota_bias'	,[[32, 0],[33,0]],
		'ladder_fg[0]',[[31,15],[29,16],[32,16],[28,17]],
		'ota_bias[0]'	,[[32, 0]],#62-17 ota_bias col-ota_out[0]col value
		'ota_bias[1]'	,[[32, 0]],
		'ramp_ota_biasfb[0]',[[32,-1],[28,17-63]],
		'sd_ota_bias[0]',[[32,0-62+58]], #sigma delta fgota0 bias
		'sd_ota_bias[1]',[[32,63-62]], #sigma delta ota_fb bias
		'sd_ota_bias[2]',[[32, 0-62+60]], #sigma delta second fgota bias
		'sd_ota_bias[3]',[[32,62-62]], #sigma delta comparator ota
		'ota_biasfb[0]'	,[[32, 0],[28,-45]],#62-17 ota_bias col-ota_out[0]col value
		'fgota_biasfb[0]',[[32, 0]],#62-17 ota_bias col-ota_out[0]col value[32,-47]
		'fgota_biasfb[1]',[[32, 0]],
		'h_rect_bias[0]',[32,62], # HALF WAVE RECTIFIER
		'switch_cap_fg[0]',[[25,27],[18,27],[27,24],[10,19],[20,19],[27,23],[26,28],[26,20],[26,29],[8,18],[24,18],[13,21],[21,21],[11,22],[19,22],[28,59],[29,62],[29,61],[29,60]], #
		'switch_cap_bias[0]',[32,63], # HALF WAVE RECTIFIER
            	'gnd_out_c[0]', [[33, 0]],
            	'vdd_out_c[0]', [[33, 1]],
            	'nmirror_bias[0]', [[5, 1]],
            	'nmirror_bias[1]', [[4, 1]],
            	'ota_p_bias[0]', [[33, 1]],
           	'ota_n_bias[0]', [[33, 0]],
		'ota_p_bias[1]', [[33, 1]],
           	'ota_n_bias[1]', [[33, 0]],
           	'c4_ota_p_bias[0]', [[33, 1-62+58]],
           	'c4_ota_n_bias[0]', [[33, 0-62+58]],
		'c4_ota_p_bias[1]', [[33, 1-62+60]],
           	'c4_ota_n_bias[1]', [[33, 0-62+60]],
           	'Nagating_ota_p_bias[0]', [[33, 1-62+58]],
           	'Nagating_ota_n_bias[0]', [[33, 0-62+58]],
           	'Nagating_fbpfetbias' , [[32, 15-62]],
           	'peak_ota_p_bias[0]', [[33, 1-62+58]],
           	'peak_ota_n_bias[0]', [[33, 0-62+58]],
           	'sd_ota_p_bias[0]', [[33, 1-62+58]],
           	'sd_ota_n_bias[0]', [[33, 0-62+58]],
           	'sd_ota_p_bias[1]', [[33, 1-62+60]],
           	'sd_ota_n_bias[1]', [[33, 0-62+60]],
           	'ladder_fg_fb[0]', [[30,16-62]],
           	'ladder_filter_fg[0]', [[32,16-62],[27,16-62],[26,18-62],[31,15-62],[31,1-62+58],[31,0-62+58],[31,1-62+60],[31,0-62+60]],
           	'hh_neuron_b_local[0]', [[32,0-62],[31,0-62+58],[31,0-62+59],[29,0-62+15],[28,0-62+17],[29,0-62+26],[29,0-62+24],[31,0-62+15],[25,0-62+15],[26,0-62+19],[28,0-62+59],[15,0-62+18],[19,0-62+16],[30,0-62+16]],
           	'hh_neuron_b_bias_1[0]', [[32,0-62+58]], # fgota_Vin bias.
           	'hh_neuron_b_bias_2[0]', [[33,0-62+59]], # fgota_Vin pbias.
           	'hh_neuron_b_bias_3[0]', [[33,0-62+58]], # fgota_Vin nbias.
           	'hh_neuron_b_bias_4[0]', [[32,0-62+62]], # ota_Vout bias.
           	'HOP_bif_fg[0]',[[32,15-62],[31,15-62],[31,18-62],[27,18-62],[26,16-62],[30,16-62],[31,1-62+58],[31,0-62+58],[31,1-62+60],[31,0-62+60]], 
             	'speech_fg[0]',[[32,19-62],[32,20-62],[24,15-62],[28,62-62],[32,16-62],[30,16-62],[31,15-62],[31,1-62+58],[31,0-62+58],[31,1-62+60],[31,0-62+60],[28,2-62+57],[28,1-62+57],[28,0-62+57],[26,25-62],[27,15-62],[17,18-62],[16,0-62],[29,25-62],[28,17-62],[15,17-62]], #[16,0-62],[21,26-62],,[15,25-62],[14,1-62],pfet[15,17],[0,26]
		        'speech_pfetbias[0]' ,[[29,1-62]], #[26,1-62]
		         'speech_pfetbias[1]' ,[[29,0-62]], #[26,1-62]
		         'speech_peakotabias[0]' ,[[32,63-62]],
		         'speech_peakotabias[1]' ,[[32,62-62]], 
		    'cap_sense_fg[0]'            ,[[27,17],[25,17],[28,19],[28,2+57],[28,1+57],[28,0+57],[26,18]],
		    'cap_sense_pfet[0]',[28,17],		
		    'cap_sense_ota[0]',  [32,62],
		    'cap_sense_ota[1]',  [32,63],  
		'lpf_2_otabias[0]',  [32,62],
		'lpf_2_otabias[1]',  [32,63],   
		'lpf_2_fg[0]',  [[28,18], [27,17],[26,18]],
		'hhneuron_fg[0]', [[32,19],[25,20],[24,19],[31,58],[31,59],[28,2+60],[28,1+60],[28,0+60],[28,2+57],[28,1+57],[28,0+57],[17,15],[31,24],[30,16],[19,16],[25,18],[31,60],[31,61],[26,27],[18,27]],
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
	        'hh_nabias', [32,58],
		'hh_kbias', [32,60],
		'hh_fbpfetbias', [32,15],
		'hh_vinbias', [32,63],
		'hh_voutbias', [32,62],
		'hh_ota_p_bias[0]', [[33, 59]],
        	'hh_ota_n_bias[0]', [[33, 58]],
		'hh_ota_p_bias[1]', [[33, 61]],
        	'hh_ota_n_bias[1]', [[33, 60]],
		'hh_leak', [31,1],
		'ota_small_cap[0]', [[31,1],[31,0]],
		'ota_small_cap[1]', [[31,1],[31,0]],
		'ladder_fb[0]' , [[28,0],[27,-1]],
        'common_source1_fg[0]',[[18,0],[25,24]],
	    'cs_bias[0]'   ,[[25,1]],
        'common_drain_fg[0]',[[18,1],[25,24],[20,0],[25,23]],
		'INF_bias[0]'  ,[[26,-61]],
		'INF_fg[0]'	,[[19,-45],[18,-62],[28,-44],[20,-38],[26,-39]],
		'c4_ota_bias[0]',[[32, 0-62+58]],#62-17 ota_bias col-ota_out[0]col value
		'c4_ota_bias[1]',[[32, 0-62+60]],
		'Nagating_ota_bias[0]',[[32, 0-62+58]],
		'Nagating_ota_bias[1]',[[32, 62-62]],
		'peak_ota_bias[0]',[[32, 0-62+58]],
		'dendiff_synapse[0]',[26,3],'dendiff_synapse[1]',[25,5],'dendiff_synapse[2]',[24,7],'dendiff_synapse[3]',[23,9],'dendiff_synapse[4]',[22,11],
		'dendiff_axial[0]',[26,4],'dendiff_axial[1]',[25,6],'dendiff_axial[2]',[24,8],'dendiff_axial[3]',[23,10],'dendiff_axial[4]',[22,12],
		'dendiff_leak[0]',[25,2],'dendiff_leak[1]',[24,2],'dendiff_leak[2]',[23,2],'dendiff_leak[3]',[22,2],'dendiff_leak[4]',[27,12],
		'dendiff_vmem[0]', [26,1],
		'c4_fg[0]'	,[[32,-43],[32,-46],[30,-46],[31,-47],[32,20-62],[24,15-62],[28,62-62]],#[ota_bias0|ota0neg->cap0|cap0.in->ota0out|ota_bias1|ota1_fb] |c2 and c3 conections
		'Nagating_fg[0]'	,[[32,19-62],[23,19-62],[25,21-62],[25,20-62],[24,19-62],[28,2-62+60],[28,1-62+60],[28,0-62+60],[28,2-62+57],[28,1-62+57],[28,0-62+57],[29,2-62+60],[29,1-62+60],[29,0-62+60]],
		'c4_cap_3x[0]',[28,2-62+57],
		'c4_cap_2x[0]',[28,1-62+57],
		'c4_cap_1x[0]',[28,0-62+57],
		'c4_ota_small_cap[0]', [[31,1-62+58],[31,0-62+58]],
		'c4_ota_small_cap[1]', [[31,1-62+60],[31,0-62+60]],
		'peak_ota_small_cap[0]', [[31,1-62+58],[31,0-62+58]],
		'lpf_fg[0]'	,[[26,-43],[26,-42],[26,-41],[26,-40],[25,-61],[24,-61],[23,-61],[22,-61]],
		'peak_detector_fg[0]',[[32,25-62],[15,15-62],[14,25-62],[16,1-62],[30,26-62],[30,0-62]],
		'h_rect_fg[0]',[[16,1],[17,25],[14,1],[17,17],[15,17]],
		 #'ramp_fe_fg[0]' ,[[32,27-62],[25,27-62],[12,19-62],[12,15-62],[29,15-62],[28,17-62],[26,17-62],[28,0-62+57],[28,1-62+57],[28,2-62+57],[31,1-62+58],[31,0-62+58],[33,1-62],[13,16-62],[31,18-62],[30,16-62],[31,1-62+60],[31,0-62+60],[15,18-62],[19,18-62],[18,0-62],[24,26-62],[24,24-62]], #w/tgate and no fb
		'ramp_fe_fg[0]' ,[[32,27-62],[25,27-62],[12,19-62],[12,15-62],[30,15-62],[28,2-62+57],[31,1-62+58],[31,0-62+58],[33,1-62],[31,1-62+60],[31,0-62+60],[15,16-62],[19,16-62],[18,0-62],[17,26-62],[17,24-62],[21,24-62],[16,1-62],[20,0-62],[13,25-62],[13,23-62],[31,1-62+60],[31,0-62+60],[26,18-62],[27,25-62]], #w/tgate and no fb, also needs buffer for GPIO
		'ramp_pfetinput[0]' ,[[32,1-62]], #w/tgate and no fb
		'ramp_pfetinput[1]' ,[[14,1-62]], #w/tgate and no fb
		'sigma_delta_fe_fg[0]',[[32,31-62],[27,31-62],[30,31-62],[28,31-62],[31,18-62],[31,15-62],[12,16-62],[29,27-62],[26,17-62],[31,1-62+58],[31,0-62+58],[31,1-62+60],[31,0-62+60]],
                'volt_div_fg[0]' ,[[33,19-58]],
		'volt_div_fg[1]',[[31,20-58]],
                'integrator_fg[0]',[[28,19-57],[28,27-57],[12,17-57],[25,17-57],[27,17-57],[26,18-57]],
                'integrator_nmirror_fg[0]',[[28,19-57],[28,27-57],[12,17-57],[25,17-57],[27,17-57],[26,18-57],[28,31-57]],
             	'integrator_ota0[0]'   ,[[32,62-57]],
	        'integrator_ota1[0]'   ,[[32,63-57]],
             	'integrator_nmirror_ota0[0]'   ,[[32,62-57]],
	        'integrator_nmirror_ota1[0]'   ,[[32,63-57]],
	        'integrator_nmirror_ota2[0]'   ,[[5,1-57]],
                'lpf_cap_3x[0:1]',[28,[-5,-2]],
		'lpf_cap_2x[0:1]',[28,[-4,-1]],
		'lpf_cap_1x[0:1]',[28,[-3, 0]],
		'lpf_cap_3x[2:3]',[29,[-5,-2]],# cap2 and 3
		'lpf_cap_2x[2:3]',[29,[-4,-1]],
		'lpf_cap_1x[2:3]',[29,[-3, 0]],
		'fgota_small_cap[0]',[[31,0],[31,1]],# switch for both n and p
		'fgota_small_cap[1]',[[31,0],[31,1]],#switches for both n and p
		'cap_1x_vd[0]'	,[28, 1], #cap0 for voltage divider[0] 58
		'cap_2x_vd[0]'	,[28, 0], #cap0 for voltage divider[0]
		'cap_3x_vd[0]'	,[28, -1], #cap0 for voltage divider[0]
		'cap_1x_vd[1]'	,[29,2], #cap0 for voltage divider[1]
		'cap_2x_vd[1]'	,[29,1], #cap0 for voltage divider[1]
		'cap_3x_vd[1]'	,[29,0], #cap0 for voltage divider[1]
                'vd_target[0:1]',[[33,31],13-58],
                'vco_fg[0]',[[31,15-62],[30,1-62],[19,16-62],[18,0-62],[33,24-62],[33,26-62],[14,1-62],[32,1-62],[31,1-62+58],[31,0-62+58],[31,1-62+60],[31,0-62+60]],
                'cap_1x[0:3]'	,[[28,29,28,29], 2],
		'cap_2x[0:3]'	,[[28,29,28,29], 1],
                'cap_3x[0:3]'	,[[28,29,28,29], 0]]
        self.dev_fgs = smDictFromList(dev_fgs_sm)
	#pdb.set_trace()
###########################################
#   CAB2 stats 
###########################################   
class cab2Stats(stats):
    def __init__(self):
        
        self.num_inputs = 13
        self.num_outputs = 8
	#self.pin_order =['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15','O0','O1','O2','O3','O4','O5','O6','O7']	
	self.pin_order =['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15','I0','I1','I2','I3','I4','I5','O0','O1','O0','O1','O2','O3','O4','O5','O6','O7']
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
            #'XI0',  [ 0,33],#to match w/ dif tile
            #'XI4',  [ 0,34], #to match w/ dif tile
            #'XI8',  [ 0,35],#to match w/ dif tile
			#'XI12', [ 0,36], # $$might have to include more?? hmmm XI<0,4,8,12?> # $$might have to include more?? hmmm XI<0,4,8,12?>
            #DXO0',  [ 0,37],
			#'XO4',  [ 0,38],
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
        li_sm_0a = ['gnd','vcc','cab2.I[0:15]']
# outputs order into the CAB
        li_sm_0b = ['ota_buffer.out[0]','tgate[0:2].out[0]','cap2[0:2].out[0]','tgate2[0:2].out[0]','mite[0:2].out[0]','mite2.out[0:1]','mult[0:1].out[0:1]','meas_volt_mite[0:1].out','ota2.out']
# defining the inputs order into the CAB #?? last term to connect i/ps to o/ps?
        li_sm_1 = ['ota_buffer.in[0]','tgate[0:2].in[0:1]','cap2[0:2].in[0]','tgate2[0:2].in[0:1]','mite[0:2].in[0:2]','mite2.in[0:1]','mult[0:1].in[0:3]','meas_volt_mite[0:1].in','ota2.in[0:1]','cab2.O[0:5]'] 
	   #O/PS        
        li_sm = ['gnd'           ,[0,  0],     #inputs from CAB and device outputs
            'vcc'                ,[0,  1],#y
            'cab2.I[0:12]'       ,[0, range( 2, 15)],#y to be shifted for the decoder
	    #O/PS OF CAB DEVICES
            'ota2.out[0]'         ,[0, 15],#y
			'ota_buffer.out[0]'  ,[0, 15],#y
			'tgate[0:2].out[0]'  ,[0,range(16,19)],
            'cap2[0:2].out[0]'    ,[0,range(19, 22)],#y                                
            'tgate2[0:2].out[0]' ,[0,range(22, 25)],#y numbering chnge for nFET0(24) and nFET1(23)
            'mite[0:2].out[0]'   ,[0,[24,25,31]],# out<10,11,16>
            'mite2.out[0:1]'  	 ,[0,[32,18]],# out<17>,out<3> --it's a 2 i/p 2o/p mite
            'mult[0:1].out[0:1]' ,[0,range(27,31)],# out<12:14>
			'meas_volt_mite[0:1].out',[0,[[25,26],[31,32,18]]], # we don't want to connect the outout
			'sftreg[0].out[3]'   ,[0,18+15], #chose col-18
            #'volswc[0:1].out[0]' ,[0, range(33, 35)],
            'ota2.in[0:1]'  	 ,[range(33,31,-1), 0],# in<0:1> y
			'ota_buffer.in[0]'  	 ,[33, 0],# in<0:1> y
			'tgate[0:2].out'     ,[range(31,27,-1), 0],# in<2:7> y
            'cap2[0:2].in[0]'     ,[range(27,22,-1), 0],# in<8:10> y
            'tgate2[0:1].in[0:1]',[range(17,13,-1)+[15,22], 0],# in<> y 21, 17,-1) it's flipped
            'mite[0:2].in[0:2]'  ,[[13,12,11,10,9,8,31,29,15], 0],# in<16:19> n---change (17, 13,-1) it;s flipped
            'mite2.in[0:1]' 	 ,[[27,17], 0],# in<6,16> y
            'mult[0:1].in[0:3]'  ,[range(7,3,-1)+range(21,17,-1), 0],# in<26:29> +in<12:15>
			'meas_volt_mite[0:1].in',[[[13,12,10,9],[31,29,27,17]],0],
            'cab2.O[0:5]'        ,[range( 29, 23, -1), 22]] ## o/ps connectn to i/ps?? ummmmm !!! ---we need this 
        self.li = smDictFromList(li_sm)
        li0b = recStrExpand(li_sm_0b)
        li0b.reverse()
        self.li0 = recStrExpand(li_sm_0a) + li0b #$$$$
        self.li1 = recStrExpand(li_sm_1)
        
        #CAB Devices ## to check
        self.dev_types = ['ota_buffer']*1 + ['tgate']*3+['cap2']*3 + ['tgate2']*3 + ['mite']*3 + ['mite2']*1 +['mult']*2+['meas_volt_mite']*2+['ota2']*1
        self.dev_pins = {'tgate_in':2,'tgate_out':1, 'cap2_in':1,'cap2_out':1, 'tgate2_in':2,'tgate2_out':1, 'ota2_out':1, 'mite_in':3,'mite_out':1, 'mite2_in':2, 'mite2_out':2,'mult_in':4, 'mult_out':2,'meas_volt_mite_in':1,'meas_volt_mite_out':1,'ota_buffer_in':1, 'ota2_in':2,'ota_buffer_out':1}  
        dev_fgs_sm = ['meas_volt_mite[0:1]',[0, [61, 63]],
			'mite2[0]'	,[0,63],
			'ota2[0]'	,[0,0],
			'mite[0:2]',[0, [0,0,0]],
			#'mite[0]'	,[0,61],
			'mult[0]'	,[0,0],
			'mult[1]'	,[1,0],
			'ota_buffer[0]',[[3,4]],
			'cap2[0:3]',[0, [57,60,57,60]],
			'sftreg[0]', [0,0],
			'mite_fg[0:2]'   ,[[31,31,31], 0],
			'mite_fg0[0]'   ,[[31, 61],[12,0]],
			'mite2_fg[0]'  ,[[31, 0]],
			'ota_bias',[[1, 0],[2,0]],
			'ota2_bias[0]',[[33,62]], #ota in CAB2
			'ota_biasfb',[[1, 0],[2,0]],
			'meas_fg[1]', [[31, 0],[15,-60],[18,-60]], ## check again
			'meas_fg[0]', [[31, 0],[11,-60],[8,-60]],
			'mult_fg[0]',[[32,58]],
			'mult_v1p[0]',[[32,59]],
			'mult_v1n[0]',[[32,60]],
			'cap2_1x[0:3]',[[28,29,28,29], 0],
			'cap2_2x[0:3]',[[28,29,28,29], 1],
			'cap2_3x[0:3]',[[28,29,28,29], 2],
			'sftreg_fg[0]' ,[[30,40],[30,41],[30,42],[30,43],[30,44],[30,45],[30,46],[30,47]]]
        self.dev_fgs = smDictFromList(dev_fgs_sm)
###########################################
#   CLB stats 
###########################################      
class clbStats(stats):
    def __init__(self):
        
        self.num_inputs = 16
        self.num_outputs = 8
        
        self.pin_order =['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9','I10','I11','I12','I13','I14','I15','O0','O1','O2','O3','O4','O5','O6','O7']
          
        chanx_sm = ['T[0:16]', [range(20,13,-1)+range(12,6,-1)+range(5,1,-1),0],
            'I3',   [ 0,46],     #pin names
            'I7',   [ 0,47],
            'I11',  [ 0,48],
            'I15',  [ 0,49],
            'O3',   [ 0,50],
            'O7',   [ 0,51],
            'XI1',  [ 0,52],
            'XI5',  [ 0,53],
            'XI9',  [ 0,54],
            'XI13', [ 0,55],
            'XO1',  [ 0,56],
            'XO5',  [ 0,57]]
        self.chanx = smDictFromList(chanx_sm, 'remBrak')
            
        # CHANY    
        chany_sm = ['T[0:16]', [range(20,13,-1)+range(12,6,-1)+range(5,1,-1),0],
            'I2',   [ 0,39],    #pin names $$ south side right?
            'I6',   [ 0,40],
            'I10',  [ 0,41],
            'I14',  [ 0,42],
            'O2',   [ 0,43],
            'O6',   [ 0,44],
            'XI0',  [ 0,33],
            'XI4',  [ 0,34],
            'XI8',  [ 0,35],
            'XI12', [ 0,36],
	    'XO0',  [ 0,37],
            'XO4',  [ 0,38],
	    #'XI0',  [ 0,59],#&&& problem
            #'XI1',  [ 0,60], #extra pin for D|A|D case 
            #'XI2',  [ 0,61], #extra pin for D|A|D case 
            #'XI3',  [ 0,62], #extra pin for D|A|D case 
	    'AXI4',  [ 0,39],#&&& problem AS THIS BLOCK IS IN CLB
            'AXI5',  [ 0,40], #extra pin for D|A|D case 
            'AXI6',  [ 0,41], #extra pin for D|A|D case 
            'AXI7',  [ 0,42], #extra pin for D|A|D case 
			#'XO0',  [ 0,63], #extra guy
			#'XO1',  [ 0,64], #extra guy
			'AXO2',  [ 0,43],#extra guy
			'AXO3',  [ 0,44]] #@@dummy need IA(4,5,6,7)==ID(2,6,10,14)
        self.chany = smDictFromList(chany_sm, 'remBrak')
        #pdb.set_trace()
        # SBLOCK      
        #track direction (these are rotated 90deg ccw from schematic name: ww->W)
        sb_sw = ['T[0:16]', [range(20,13,-1)+range(12,6,-1)+range(5,1,-1),0],
            'we',[ 0,64],
            'wn',[ 0,61],
            'ws',[ 0,60],
            'ns',[ 0,62],
            'ne',[ 0,63],
            'es',[ 0,59],
            'ew',[ 0,64],
            'nw',[ 0,61],
            'sw',[ 0,60],
            'sn',[ 0,62],
            'en',[ 0,63],
            'se',[ 0,59]]    
        self.sblock = smDictFromList(sb_sw, 'remBrak')  
              
        #Local Interconnect -- new numbers as of 8/17/14
        
        li_sm_0 = ['clb.I[0:15]', 'ble[0:7].out[0]']
        li_sm_1 = ['ble[0:7].in[0:3]']
        li_sm = [
            'clb.I[0:15]'        ,[range(21,5,-1), 0],
            'ble[0:7].out[0]'    ,[range(7,-1,-1), 0],
            'ble[0:7].in[0:3]'   ,[0, range(0,32)]]
        #pdb.set_trace()
        self.li0 = recStrExpand(li_sm_0)
        self.li1 = recStrExpand(li_sm_1)
        self.li = smDictFromList(li_sm)
        
        #CLB Devices
        self.dev_types = ['ble']*8
        self.dev_pins = {'ble':5}          
        dev_fgs_sm = ['ble[0]', [0,0], ## 0 4 8 instead of 2 1 0 as that's the diff btw rsel
			'ble[1]',	[4,0],
			'ble[2]',	[8,0],
			'ble[3]',	[0,22],
			'ble[4]',	[4,22],
			'ble[5]',	[8,22],
			'ble[6]',	[0,44],
			'ble[7]',	[4,44], #offsets
#            '0000',     [[22, 3], [25, 0]], #pFET #nFET
#            '0001',     [[22, 2], [25, 1]],
#            '0010',     [[22, 1], [25, 2]],
#            '0011',     [[22, 0], [25, 3]],
#            '0100',     [[22, 7], [25, 4]],
#            '0101',     [[22, 6], [25, 5]],
#            '0110',     [[22, 5], [25, 6]],
#            '0111',     [[22, 4], [25, 7]],
#            '1000',     [[22, 11], [25, 8]],
#            '1001',     [[22, 10], [25, 9]],
#            '1010',     [[22, 9], [25, 10]],
#            '1011',     [[22, 8], [25, 11]],
#            '1100',     [[22, 15], [25, 12]],
#            '1101',     [[22, 14], [25, 13]],
#            '1110',     [[22, 13], [25, 14]],
#            '1111',     [[22, 12], [25, 15]],
            '0000',     [[22, 3], [25, 0]], #pFET #nFET
            '0001',     [[22, 11], [25, 8]],
            '0010',     [[22, 7], [25, 4]],
            '0011',     [[22, 15], [25, 12]],
            '0100',     [[22, 1], [25, 2]],
            '0101',     [[22, 9], [25, 10]],
            '0110',     [[22, 5], [25, 6]],
            '0111',     [[22, 13], [25, 14]],
            '1000',     [[22, 2], [25, 1]],
            '1001',     [[22, 10], [25, 9]],
            '1010',     [[22, 6], [25, 5]],
            '1011',     [[22, 14], [25, 13]],
            '1100',     [[22, 0], [25, 3]],
            '1101',     [[22, 8], [25, 11]],
            '1110',     [[22, 4], [25, 7]],
            '1111',     [[22, 12], [25, 15]],
            'clk_r',    [0, 0], #default condition after tunnel, probably do need this address
            'clk_g',    [[22, 16], [25,16]],
            'clk_a',    [[22, 17], [25,16]], #used for counter macroblock to chain flipflops
            'res_r',    [0, 0], #default condition after tunnel, probably do need this address
            'res_g',    [[22, 19], [25,18]],#[22, 19], [25,18]
            'res_a',    [0, 0], #does not exist
            'ff_out',   [[22, 20], [25,19]],
            'lut_out',  [0, 0], #default condition after tunnel, probably do need this address
            'ff_in',	[[22,18], [25,17]]] #used for counter macroblock
        self.dev_fgs = smDictFromList(dev_fgs_sm)
        
class iowStats(stats):
    def __init__(self):
        self.num_inputs = 12
        self.num_outputs = 6
        
        self.pin_order = [
            'I2','I2','I2','I6','I6','I6','I10','I10','I10','I14','I14','I14','O2','O2','O2','O6','O6','O6']
class ioeStats(stats):
    """needs real fg numbers --  --done now-sg
    """
    def __init__(self):
        self.num_inputs = 12 # as we have 4 i/ps...each can be i/p or o/p or clk (thus 4x3 options)
        self.num_outputs = 6 # as we have 2 o/ps (2x3)
        
        self.pin_order = [
            'E0','E1','E2','E3','E4','E5','E6','IE6','E8','E9','E10','E11','E12','E13','E14','OE3','E16','E17']
        
#All tracks are excluding 0,8,15 tracks in the count 
#        chanx_sm = ['T[0:16]', [range(32,26,-1)+range(32,26,-1)+33+range(31,27,-1), 0],
#	    'XI8'   ,[ 0,17],    #pin names # 14(COL_OFFSET)+3(OFFSET)
#            'XI9'   ,[ 0,18],
#            'XI13'  ,[ 0,19],
#            'XI14'  ,[ 0,20],
#	    'XI15'  ,[ 0,21],
#            'XO4'   ,[ 0,22],
#            'I10' ,[ 0,23],
#            'I11' ,[ 0,24],
#            'I12' ,[ 0,25],
#            '05'  ,[ 0,26],
#            'O6'  ,[ 0,27],
#            'O7'  ,[ 0,28]]  

        #self.chanx = smDictFromList(chanx_sm, 'remBrak')
        
	chany_sm = ['T[0:16]', [0,range(1,8)+range(9,15)+range(16,20)],
	    'E0' ,  [6,21],
            'E1' ,  [6,21],
            'E2' ,  [0,21],
            'E3' ,  [5,21],
            'E4' ,  [5,21],
            'E5' ,  [0,21],
            'E6' ,  [4,21],
            'E7' ,  [4,21],
            'E8' ,  [0,21],
            'E9' ,  [3,21],
            'E10' ,  [3,21],
            'E11' ,  [0,21],
            'E12' ,  [2,21],
            'E13' ,  [2,21],
            'E14' ,  [0,21],
            'E15' ,  [1,21],
            'E16' ,  [1,21],
            'E17' ,  [0,21],
            'E18' ,  [0,21],
            'E19' ,  [0,21],
            'I4',   [ 6,0],    #pin names
            'I5',   [ 5,0],
            'I6',   [ 4,0],
            'I7',   [ 3,0],
            'O2',   [ 2,0],
            'O3',   [ 1,0],
	    'XO0',  [ 2,21], ### to be seen
            'XO1',  [ 1,21],
            'XI0',  [ 6,21],
            'XI1',  [ 5,21],
            'XI2',  [ 4,21],## problem conflict
            'XI3',  [ 3,21], # $$$$
	    'IE6',  [4,21], #$$$$ TO BE RESOLVED
	    'OE3',  [1,21],
            ### To be updated
            'XI2',  [ 0,39],#------to match w/ dif DIgital tile
            'XI6',  [ 0,40], #to match w/ dif tile
            'XI10', [ 0,41],#to match w/ dif tile
	    'XI14', [ 0,42],
            'XI4',  [ 0,59],#IO BLOCK io_e
            'XI5',  [ 0,60], #to match w/ dif tile
            #'XI6',  [ 0,61],#to match w/ dif tile
	    'XI7',  [ 0,62], # $$might have to include more?? hmmm XI<0,4,8,12?> # $$might have to include more?? hmmm XI<0,4,8,12?>
            'XO2',  [ 0,69], ### PROBLEM FROM i/o same as O2
	    'XO3',  [ 0,70],
	    'XO2',  [ 0,43],
	    'XO6',  [ 0,44]]  # $$ XO<0,4>??
        self.chany = smDictFromList(chany_sm, 'remBrak')	
	
        #self.sblock = {
            #'T0':   [ 32, 42],    #track names # 42 is the vd offset..inside cab vd<0:5>
            #'T1':   [ 31, 42],    
            #'T2':   [ 30, 42],
            #'T3':   [ 29, 42],
            #'T4':   [ 28, 42],
            #'T5':   [ 27, 42],
            #'T6':   [ 32, 52],	#track names # 52 is the vd offset..inside cab vd<10:15>
            #'T7':   [ 31, 52],
            #'T8':   [ 30, 52],
            #'T9':   [ 29, 52],
            #'T10':  [ 28, 52],
            #'T11':  [ 27, 52],
            #'T12':  [ 33, 62],	#track names # 62 is the vd offset..inside cab vd<20:25>
            #'T13':  [ 31, 62],
            #'T14':  [ 30, 62],
            #'T15':  [ 29, 62],
            #'T16':  [ 28, 62],
	    #'ns':   [ 0,3], #actual ne   #track direction++ ADDING +14 for this row
            #'ne':   [ 0,4], #se
            #'nw':   [ 0,2], #ne
            #'ew':   [ 0,5], # ns
            #'es':   [ 0,0], #sw
            #'sw':   [ 0,1], #nw
            #'sn':   [ 0,3], #en
            #'en':   [ 0,4],
            #'wn':   [ 0,2],
            #'we':   [ 0,5],
            #'se':   [ 0,0],
            #'ws':   [ 0,1]}
        self.sblock = {
            'T0':   [ 5, 0],    #track names
            'T1':   [ 4, 0],    
            'T2':   [ 3, 0],
            'T3':   [ 2, 0],
            'T4':   [ 1, 0],
            'T5':   [ 0, 0],
            'T6':   [ 5, 0],
            'T7':   [ 4, 10],
            'T8':   [ 3, 10],
            'T9':   [ 2, 10],
            'T10':  [ 1, 10],
            'T11':  [ 0, 10],
            'T12':  [ 6, 20],
            'T13':  [ 4, 20],
            'T14':  [ 3, 20],
            'T15':  [ 2, 20],
            'T16':  [ 1, 20],
	    'ns':   [ 0,3+42], #actual ew  #track direction++ ADDING +14 for this row
            'ne':   [ 0,4+42], #es
            'nw':   [ 0,2+42], #en
            'ew':   [ 0,5+42], #sn
            'es':   [ 0,0+42], #sw
            'sw':   [ 0,1+42], #wn
            'sn':   [ 0,3+42], #we
            'en':   [ 0,4+42], #se
            'wn':   [ 0,2+42], #ne
            'we':   [ 0,5+42], #ns
            'se':   [ 0,0+42], #ws
            'ws':   [ 0,1+42]} #nw
               
        self.dev_fgs = {
            'c4_out[0]':          [[22,13],[18,13]],
            'tgate_in[0]':    	  [[ 21, 13],[ 9, 11]],    #last switch is for bias
            'c4_out[1]':    	  [[26,13],[25,13]],
            'tgate_in[1]':    	  [[27,13]],
            'tgate[0]':			  [[8,25],[7,26]],
            'tgate[1]':			  [[8,26],[7,25]],
            'int[0]':             [[7,27]],              #offsets were wrong--ss
            'int[1]':             [[8,27]],
            'int[2]':             [[7,28]],
            'int[3]':             [[8,28]],
            'int[4]':             [[7,29]],
            'int[5]':             [[8,29]]}
        ##row address for local interconnect    
        self.li = {
			'I4':				[7,38],
			'I5':				[7,36],
			'I6':				[7,34],
			'I7':				[8,38],
			'O2':				[8,36],
			'O3':				[8,34],
            'tgate[0]':			[0,0],
            'tgate[1]':			[0,0],
            #'I0':               [13, 0],    #pin names from self.array
            #'I1':               [14, 0],
            #'I2':               [15, 0],
            #'I3':               [13, 0],
            #'O0':               [14, 0],
            #'O1':               [15, 0],
            'c4_out[0]':        [ 0, 7],    #io pin names
            'tgate_in[0]':   	[ 0, 6],
            'c4_out[1]':        [ 0,13],
            'tgate_in[1]':	[ 0,12]}   
class ioelStats(stats):
    """needs real fg numbers --  --done now-sg
    """
    def __init__(self):
        self.num_inputs = 12 # as we have 4 i/ps...each can be i/p or o/p or clk (thus 4x3 options)
        self.num_outputs = 6 # as we have 2 o/ps (2x3)
        
        self.pin_order = [
            'I4','I4','I4','I5','I5','I5','I6','I6','I6','I7','I7','I7','O2','O2','O2','O3','O3','O3']
        
#All tracks are excluding 0,8,15 tracks in the count 
#        chanx_sm = ['T[0:16]', [range(32,26,-1)+range(32,26,-1)+33+range(31,27,-1), 0],
#	    'XI8'   ,[ 0,17],    #pin names # 14(COL_OFFSET)+3(OFFSET)
#            'XI9'   ,[ 0,18],
#            'XI13'  ,[ 0,19],
#            'XI14'  ,[ 0,20],
#	    'XI15'  ,[ 0,21],
#            'XO4'   ,[ 0,22],
#            'I10' ,[ 0,23],
#            'I11' ,[ 0,24],
#            'I12' ,[ 0,25],
#            '05'  ,[ 0,26],
#            'O6'  ,[ 0,27],
#            'O7'  ,[ 0,28]]  

        #self.chanx = smDictFromList(chanx_sm, 'remBrak')
        
	chany_sm = ['T[0:16]', [0,range(1,8)+range(9,15)+range(16,20)],
            'I4',   [ 6,0],    #pin names
            'I5',   [ 5,0],
            'I6',   [ 4,0],
            'I7',   [ 3,0],
            'O2',   [ 2,0],
            'O3',   [ 1,0],
			'XO0',  [ 2,21], ### to be seen
            'XO1',  [ 1,21],
            'XI0',  [ 6,21],
            'XI1',  [ 5,21],
            'XI2',  [ 4,21],## problem conflict
            'XI3',  [ 3,21],
            ### To be updated
            'XI2',  [ 0,39],#------to match w/ dif DIgital tile
            'XI6',  [ 0,40], #to match w/ dif tile
            'XI10', [ 0,41],#to match w/ dif tile
	    'XI14', [ 0,42],
            'XI4',  [ 0,59],#IO BLOCK io_e
            'XI5',  [ 0,60], #to match w/ dif tile
            'XI6',  [ 0,61],#to match w/ dif tile
	    'XI7',  [ 0,62], # $$might have to include more?? hmmm XI<0,4,8,12?> # $$might have to include more?? hmmm XI<0,4,8,12?>
            'XO2',  [ 0,69], ### PROBLEM FROM i/o same as O2
	    'XO3',  [ 0,70],
	    'XO2',  [ 0,43],
	    'XO6',  [ 0,44]]  # $$ XO<0,4>??
        self.chany = smDictFromList(chany_sm, 'remBrak')	
	
        #self.sblock = {
            #'T0':   [ 32, 42],    #track names # 42 is the vd offset..inside cab vd<0:5>
            #'T1':   [ 31, 42],    
            #'T2':   [ 30, 42],
            #'T3':   [ 29, 42],
            #'T4':   [ 28, 42],
            #'T5':   [ 27, 42],
            #'T6':   [ 32, 52],	#track names # 52 is the vd offset..inside cab vd<10:15>
            #'T7':   [ 31, 52],
            #'T8':   [ 30, 52],
            #'T9':   [ 29, 52],
            #'T10':  [ 28, 52],
            #'T11':  [ 27, 52],
            #'T12':  [ 33, 62],	#track names # 62 is the vd offset..inside cab vd<20:25>
            #'T13':  [ 31, 62],
            #'T14':  [ 30, 62],
            #'T15':  [ 29, 62],
            #'T16':  [ 28, 62],
	    #'ns':   [ 0,3], #actual ne   #track direction++ ADDING +14 for this row
            #'ne':   [ 0,4], #se
            #'nw':   [ 0,2], #ne
            #'ew':   [ 0,5], # ns
            #'es':   [ 0,0], #sw
            #'sw':   [ 0,1], #nw
            #'sn':   [ 0,3], #en
            #'en':   [ 0,4],
            #'wn':   [ 0,2],
            #'we':   [ 0,5],
            #'se':   [ 0,0],
            #'ws':   [ 0,1]}
        self.sblock = {
            'T0':   [ 5, 12],    #track names
            'T1':   [ 4, 12],    
            'T2':   [ 3, 12],
            'T3':   [ 2, 12],
            'T4':   [ 1, 12],
            'T5':   [ 0, 12],
            'T6':   [ 5, 12],
            'T7':   [ 4, 6],
            'T8':   [ 3, 6],
            'T9':   [ 2, 6],
            'T10':  [ 1, 6],
            'T11':  [ 0, 6],
            'T12':  [ 6, 0],
            'T13':  [ 4, 0],
            'T14':  [ 3, 0],
            'T15':  [ 2, 0],
            'T16':  [ 1, 0],
	    'ns':   [ 0,3+14], #actual ew  #track direction++ ADDING +14 for this row
            'ne':   [ 0,4+14], #es
            'nw':   [ 0,2+14], #en
            'ew':   [ 0,5+14], #sn
            'es':   [ 0,0+14], #sw
            'sw':   [ 0,1+14], #wn
            'sn':   [ 0,3+14], #we
            'en':   [ 0,4+14], #se
            'wn':   [ 0,2+14], #ne
            'we':   [ 0,5+14], #ns
            'se':   [ 0,0+14], #ws
            'ws':   [ 0,1+14]} #nw      
class ioeStats11(stats):
    """needs real fg numbers --  --done now-sg
    """
    def __init__(self):
        self.num_inputs = 12 # as we have 4 i/ps...each can be i/p or o/p or clk (thus 4x3 options)
        self.num_outputs = 6 # as we have 2 o/ps (2x3)
        
        self.pin_order = [
            'I4','I4','I4','I5','I5','I5','I6','I6','I6','I7','I7','I7','O2','O2','O2','O3','O3','O3']
        
#All tracks are excluding 0,8,15 tracks in the count 
#        chanx_sm = ['T[0:16]', [range(32,26,-1)+range(32,26,-1)+33+range(31,27,-1), 0],
#	    'XI8'   ,[ 0,17],    #pin names # 14(COL_OFFSET)+3(OFFSET)
#            'XI9'   ,[ 0,18],
#            'XI13'  ,[ 0,19],
#            'XI14'  ,[ 0,20],
#	    'XI15'  ,[ 0,21],
#            'XO4'   ,[ 0,22],
#            'I10' ,[ 0,23],
#            'I11' ,[ 0,24],
#            'I12' ,[ 0,25],
#            '05'  ,[ 0,26],
#            'O6'  ,[ 0,27],
#            'O7'  ,[ 0,28]]  

        #self.chanx = smDictFromList(chanx_sm, 'remBrak')
        
	chany_sm = ['T[0:16]', [range(32,26,-1)+range(32,26,-1)+[33]+range(31,27,-1),0],
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
            'XI2',  [ 0,39],#------to match w/ dif DIgital tile
            'XI6',  [ 0,40], #to match w/ dif tile
            'XI10', [ 0,41],#to match w/ dif tile
	    'XI14', [ 0,42],
            'XI4',  [ 0,59],#IO BLOCK io_e
            'XI5',  [ 0,60], #to match w/ dif tile
            'XI6',  [ 0,61],#to match w/ dif tile
	    'XI7',  [ 0,62], # $$might have to include more?? hmmm XI<0,4,8,12?> # $$might have to include more?? hmmm XI<0,4,8,12?>
            'XO2',  [ 0,69], ### PROBLEM FROM i/o same as O2
	    'XO3',  [ 0,70],
	    'XO2',  [ 0,43],
	    'XO6',  [ 0,44]]  # $$ XO<0,4>??
        self.chany = smDictFromList(chany_sm, 'remBrak')	
	
        self.sblock = {
            'T0':   [ 32, 42],    #track names # 42 is the vd offset..inside cab vd<0:5>
            'T1':   [ 31, 42],    
            'T2':   [ 30, 42],
            'T3':   [ 29, 42],
            'T4':   [ 28, 42],
            'T5':   [ 27, 42],
            'T6':   [ 32, 52],	#track names # 52 is the vd offset..inside cab vd<10:15>
            'T7':   [ 31, 52],
            'T8':   [ 30, 52],
            'T9':   [ 29, 52],
            'T10':  [ 28, 52],
            'T11':  [ 27, 52],
            'T12':  [ 33, 62],	#track names # 62 is the vd offset..inside cab vd<20:25>
            'T13':  [ 31, 62],
            'T14':  [ 30, 62],
            'T15':  [ 29, 62],
            'T16':  [ 28, 62],
	    'ns':   [ 0,3], #actual ne   #track direction++ ADDING +14 for this row
            'ne':   [ 0,4], #se
            'nw':   [ 0,2], #ne
            'ew':   [ 0,5], # ns
            'es':   [ 0,0], #sw
            'sw':   [ 0,1], #nw
            'sn':   [ 0,3], #en
            'en':   [ 0,4],
            'wn':   [ 0,2],
            'we':   [ 0,5],
            'se':   [ 0,0],
            'ws':   [ 0,1]}
           
        self.dev_fgs = {
            'c4_out[0]':          [[22,13],[18,13]],
            'tgate_in[0]':    	  [[ 21, 13],[ 9, 11]],    #last switch is for bias
            'c4_out[1]':    	  [[26,13],[25,13]],
            'tgate_in[1]':    	  [[27,13]],
            'int[0]':             [[16, 8]],
            'int[1]':             [[16, 9]],
            'int[2]':             [[16,10]],
            'int[3]':             [[16,11]],
            'int[4]':             [[16,12]],
            'int[5]':             [[16,13]]}
        ##row address for local interconnect    
        self.li = {
            'I0':               [13, 0],    #pin names from self.array
            'I1':               [14, 0],
            'I2':               [15, 0],
            'I3':               [13, 0],
            'O0':               [14, 0],
            'O1':               [15, 0],
            'c4_out[0]':        [ 0, 7],    #io pin names
            'tgate_in[0]':   	[ 0, 6],
            'c4_out[1]':        [ 0,13],
            'tgate_in[1]':	[ 0,12]}   
                        
        
class iosdStats(stats):
    def __init__(self):
        self.num_inputs = 12
        self.num_outputs = 6
        
        self.pin_order = [
            'I3','I3','I3','I7','I7','I7','I11','I11','I11','I15','I15','I15','O3','O3','O3','O7','O7','O7']
         
        chanx_sm = ['T[0:16]', [[31,30,28,27,26,24,23,21,20,19,18,17,16,14,13,12,11], 0],
        #chanx_sm = ['T[0:16]',  [range(31,29,-1)+range(28,25,-1)+range(24,22,-1)+range(21,15,-1)+range(14,10,-1), 0], ##skipping tracks 0,4,8 in physical

            'I3'   ,[ 0,17], #pin names
            'I7'   ,[ 0,18], #physical le<0:5>
            'I11'  ,[ 0,19],
            'I15'  ,[ 0,20],
            'O3'   ,[ 0,21],
            'O7'   ,[ 0,22],
            'XI1'  ,[ 0,23], #physical lw<0:5>
            'XI5'  ,[ 0,24],
            'XI9'  ,[ 0,25],
            'XI13' ,[ 0,26],
            'XO1'  ,[ 0,27],
            'XO5'  ,[ 0,28]]   
        self.chanx = smDictFromList(chanx_sm, 'remBrak')

	
        
        self.sblock = {
             'T0':   [ 8, 6],    #track names +3 as vd<0> inside translates to vd<3> thus vd<6:13>~ vd<9:16>
             'T1':   [ 7, 6],    
             'T2':   [ 6, 6],
             'T3':   [ 5, 6],
             'T4':   [ 4, 6],
             'T5':   [ 1, 6],
             'T6':   [ 2, 6],
             'T7':   [ 0, 6],
             'T8':   [ 9, 0],
             'T9':   [ 8, 0],
             'T10':  [ 7, 0],
             'T11':  [ 6, 0],
             'T12':  [ 5, 0],
             'T13':  [ 3, 0],
             'T14':  [ 2, 0],
             'T15':  [ 1, 0],
             'T16':  [ 0, 0],
	     'ns':   [ 0,20],    #track direction
             'ne':   [ 0,21],
             'nw':   [ 0,19],
             'ew':   [ 0,22],
             'es':   [ 0,17],
             'sw':   [ 0,18],
             'sn':   [ 0,20],
             'en':   [ 0,21],
             'wn':   [ 0,19],
             'we':   [ 0,22],  	
             'se':   [ 0,17],
             'ws':   [ 0,18]}
           
            #these are specific FGs (for Tgate) to be turned on
	    #starting io_pad pin
        self.dev_fgs = {
            'tgate[0]':          [[18,13],[14,13]],
            'ana_buff_in[0]':    [[17, 13],[ 5, 11]],    #last switch is for bias
            'ana_buff_out[0]':   [[16, 13],[ 7, 13]],
			'ana_buff_out2[0]':  [[16, 13],[ 7, 13],[ 9, 1]],
            'dig_buff_in[0]':    [[19,13],[20,13]],
            'dig_buff_out[0]':   [[15,13]],
            'tgate[1]':          [[26,13],[27,13]],
            'ana_buff_in[1]':    [[30,13],[5, 2]],
            'ana_buff_out[1]':   [[24,13],[28,13]],
			'ana_buff_out2[1]':  [[24,13],[28,13],[9,0]],
            'dig_buff_in[1]':    [[22,13],[21,13]],
            'dig_buff_out[1]':   [[23,13]],
            'int[0]':            [[12, 8]],
            'int[1]':            [[12, 9]],
            'int[2]':            [[12,10]],
            'int[3]':            [[12,11]],
            'int[4]':            [[12,12]],
            'int[5]':            [[12,13]]}
            
        self.li = {
            'I3':                [ 9, 0],    #pin names from self.array
            'I7':                [10, 0],
            'I11':               [11, 0],
            'I15':               [ 9, 0],
            'O3':                [10, 0],
            'O7':                [11, 0],
            'tgate[0]':          [ 0, 7],    #io pin names
            'ana_buff_in[0]':    [ 0, 6],
            'ana_buff_out[0]':   [ 0, 5],
            'dig_buff_in[0]':    [ 0, 4],
            'dig_buff_out[0]':   [ 0, 3],
            'tgate[1]':          [ 0,13],
            'ana_buff_in[1]':    [ 0,12],
            'ana_buff_out[1]':   [ 0,11],
            'dig_buff_in[1]':    [ 0,10],
            'dig_buff_out[1]':   [ 0, 9]}

class iosaStats(stats):
    """needs real fg numbers -- just copied from iosd --done now-sg
    """
    def __init__(self):
        self.num_inputs = 12 # as we have 4 i/ps...each can be i/p or o/p or clk (thus 4x3 options)
        self.num_outputs = 6 # as we have 2 o/ps (2x3) KInda irrelevant as all of these are I/Os
        
        self.pin_order = [
            'I8','I8','I8','I9','I9','I9','I13','I13','I13','I14','I14','I14','I15','I15','I15','O4','O4','O4']
         
        #chanx_sm = ['T[0:16]', [[31,30,28,27,26,24,23,21,20,19,18,17,16,14,13,12,11], 0],
	chanx_sm = ['T[0:16]', [ [32,31,30,29,28,27,26,24,23,22,21,20,19,17,16,15,14], 0],
	    'I8'   ,[ 0,17],    #pin names # 14(COL_OFFSET)+3(OFFSET)
            'I9'   ,[ 0,18],
            'I13'  ,[ 0,19],
            'I14'  ,[ 0,20],
	    'I15'  ,[ 0,21],
            'O4'   ,[ 0,22],
            'XI10' ,[ 0,23],
            'XI11' ,[ 0,24],
            'XI12' ,[ 0,25],
            'XO5'  ,[ 0,26],
            'XO6'  ,[ 0,27],
            'XO7'  ,[ 0,28]]  
#            'I3'   ,[ 0,17],    #pin names # 14(COL_OFFSET)+3(OFFSET)
#            'I7'   ,[ 0,18],
#            'I11'  ,[ 0,19],
#            'I15'  ,[ 0,20],
#            'O3'   ,[ 0,21],
#            'O7'   ,[ 0,22],
#            'XI1'  ,[ 0,23],
#            'XI5'  ,[ 0,24],
#            'XI9'  ,[ 0,25],
#            'XI13' ,[ 0,26],
#            'XO1'  ,[ 0,27],
#            'XO5'  ,[ 0,28]]   ramp_fe
        self.chanx = smDictFromList(chanx_sm, 'remBrak')
        
        self.sblock = {
            'T0':   [ 12, 6],    #track names
            'T1':   [ 11, 6],    
            'T2':   [ 10, 6],
            'T3':   [ 9, 6],
            'T4':   [ 8, 6],
            'T5':   [ 5, 6],
            'T6':   [ 6, 6],
            'T7':   [ 4, 6],
            'T8':   [ 13, 0],
            'T9':   [ 12, 0],
            'T10':  [ 11, 0],
            'T11':  [ 10, 0],
            'T12':  [ 9, 0],
            'T13':  [ 7, 0],
            'T14':  [ 6, 0],
            'T15':  [ 5, 0],
            'T16':  [ 4, 0],
	    'ns':   [ 0,20], #actual ne   #track direction++ ADDING +14 for this row
            'ne':   [ 0,21], #se
            'nw':   [ 0,19], #ne
            'ew':   [ 0,22], # ns
            'es':   [ 0,17], #sw
            'sw':   [ 0,18], #nw
            'sn':   [ 0,20], #en
            'en':   [ 0,21],
            'wn':   [ 0,19],
            'we':   [ 0,22],
            'se':   [ 0,17],
            'ws':   [ 0,18]}
            
        self.dev_fgs = {
            'tgate[0]':           [[22,13],[18,13]],
            'ana_buff_in[0]':     [[ 21, 13],[ 9, 11]],    #last switch is for bias
            'ana_buff_out[0]':    [[ 20, 13],[ 11, 13]],
			'ana_buff_out2[0]':   [[ 20, 13],[ 13, 1]],
            'dig_buff_in[0]':     [[23,13],[19,13]],
            'dig_buff_out[0]':    [[19,13]],
            'tgate[1]':           [[30,13],[31,13]],
            'ana_buff_in[1]':     [[29, 13],[9, 2]], #$$ no3rd switch
            'ana_buff_out[1]':    [[28, 13],[32,13]],
			'ana_buff_out2[1]':   [[28, 13],[ 13, 0]],
            'dig_buff_in[1]':     [[26,13],[25,13]],
            'dig_buff_out[1]':    [[27,13]],
            'int[0]':             [[16, 8]],
            'int[1]':             [[16, 9]],
            'int[2]':             [[16,10]],
            'int[3]':             [[16,11]],
            'int[4]':             [[16,12]],
            'int[5]':             [[16,13]]}
        ##row address for local interconnect    
        self.li = {
            'I8':               [13, 0],    #pin names from self.array
            'I9':               [14, 0],
            'I13':              [15, 0],
            'I14':              [13, 0],
            'I15':              [14, 0],
            'O4':               [15, 0],
            'tgate[0]':         [ 0, 7],    #io pin names
            'ana_buff_in[0]':   [ 0, 6],
            'ana_buff_out[0]':  [ 0, 5],
            'dig_buff_in[0]':   [ 0, 4],
            'dig_buff_out[0]':  [ 0, 3],
            'tgate[1]':         [ 0,13],
            'ana_buff_in[1]':   [ 0,12],
            'ana_buff_out[1]':  [ 0,11],
            'dig_buff_in[1]':   [ 0,10],
            'dig_buff_out[1]':  [ 0, 9]}        
        
class array(pbarray):
    def __init__(self):
        xsize = len(arrayStats.pattern)
        ysize = len(arrayStats.pattern[0])
        super(array, self).__init__(xsize, ysize)
        self.name = 'rasp30_array'
        
class clb(complexBlock):
    def __init__(self, name):
        self.name = name
        self.type = 'CLB'
        self.stats = clbStats()
        self.array_stats = arrayStats()
        self.subblocks = []
        
        #CLB ports
        self.inputs = ['open']*self.stats.num_inputs
        self.outputs = ['open']*self.stats.num_outputs

        #CLB Devices
        dev_types = self.stats.dev_types
        dev_pins = self.stats.dev_pins    
        self.addSubs(dev_types, dev_pins)
                
    
    def genLI(self, *var):
        #cab = rasp3array().array['cab']
        verbose = 0
        if len(var) == 1: verbose = 1

        self.swcs = []        
        
        #inputs to local interconnect--
        #   inputs to CAB + outputs from DEVs
        #pdb.set_trace()
        self.li_in_in = self.inputs
        self.li_in_dev = []
        for i in range(len(self.subblocks)):
            self.li_in_dev.append(self.getSub(i).outputs)
        #self.li_in_dev.reverse()
        self.li_in = self.li_in_in + self.li_in_dev
        
        #outputs from local interconnect--
        #   inputs to DEVs + outputs from CAB
        self.li_out_out = self.outputs
        self.li_out_dev = []
        for i in range(len(self.subblocks)):
            for j in range(len(self.getSub(i).inputs)):
                self.li_out_dev.append(self.getSub(i).inputs[j])
             
        self.li_out = self.li_out_dev + self.li_out_out
        
        self.li = [[0]*len(self.li_in) for x in self.li_out]
        
        #printing connectivity matrix
        x = 2
        for i in range(len(self.li_in)):
            print '%s'%str(i).ljust(2),
        print
            
        for i in range(len(self.li_in)):
            if self.li_in[i] != 'open':
                if verbose: print '%s'%self.li_in[i].ljust(x),
            else:
                if verbose: print ''.ljust(x),
        if verbose: print
        
        for i in range(len(self.li_out_dev)):
            if self.li_out[i] != 'open':
                for j in range(len(self.li_in)):
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
           
        #actually generating the switch addresses here    
        self.swcsFromLi()
                        
                 
    def dispLI(self):
        self.genLI('verbose')
    ########################################## gen dev fgs for bles!!    
    def genDevFgs(self): 
        verbose = 1
        for i in range(len(self.subblocks)):
            #pdb.set_trace()
            sb = self.getSub(i)
            ## set initial conditions
            TT=['0000','0001','0010','0011','0100','0101','0110','0111','1000','1001','1010','1011','1100','1101','1110','1111']
            KK=[]
            TT=set(TT)

# add if counter8
# make ble[0] then variable containing ble[1-7]
# for each ble make a kk list of clb.dev_fgs for counter support
# run through similar switch generation as normal lut/ff

            if sb.outputs != 'open':
                
                #this generates the FG addresses for the LUT states
                # need to add the FG addresses for BLE configuration
                # LUT -> out, FF -> out, clk and reset select, etc
                #pdb.set_trace()
                ex_fgs_orig = sb.ex_fgs
                p0 = sb.inputs_orig
                #p0.reverse() #need to reverse ble input order, not sure why, but it works
                p1 = sb.inputs 
                print "ble input re-ordered"
                print p0
                print p1
                if ex_fgs_orig[0] == 'ff_in': #counter lut hack
					kk = ex_fgs_orig              
                elif ex_fgs_orig[-1] == 'ff_out': #flip flop lut hack
					#pdb.set_trace()
				
				
					kk = lutExpand(ex_fgs_orig[:-2], p0, p1) 
					#pdb.set_trace()
					#print "555555555555555555555555555555whoa %g" %(kk)
					KK=set(kk)
					kk=TT.difference(KK)
					kk=list(kk) # return as list
					kk.append('res_g')
					kk.append('ff_out')
					#pdb.set_trace()
                else:
					#pdb.set_trace()
					kk = lutExpand(ex_fgs_orig, p0, p1)
					KK=set(kk)
					kk=TT.difference(KK) ## take difference of list
					kk=list(kk) # return as list
                sb.ex_fgs = kk
                #pdb.set_trace()
                swc_name0 = sb.name
                swc0 = self.stats.dev_fgs[swc_name0]
                for j in kk: ##all truth table values
                    swc_name1 = j
                    #pdb.set_trace()
                    swc2 = self.stats.dev_fgs[swc_name1]
                    for n in range(len(swc2)):
						if isinstance(swc2[0],int):
							swc1=swc2
						else:
							swc1=swc2[n]
						swc = [swc0[0]+swc1[0], swc0[1]+swc1[1]]
						swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
                    
						if verbose: print '999%s %s -> (%g %g) -> (%g %g)'%(swc_name0, swc_name1, swc[0], swc[1], swcx[0], swcx[1])
						self.swcs.append(swcx)
                #pdb.set_trace()
                    
                    
      ######################################          

class cab(complexBlock):
    def __init__(self, name):
        
        self.name = name
        self.type = 'CAB'
        self.stats = cabStats()     
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
	for pwr in range(len(self.inputs)):
	    if self.inputs[pwr] in ['gnd','vcc']:
		self.inputs[pwr]='open'
	    
	    
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
        x = 2
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
	#pdb.set_trace()
        for i in range(len(self.li_out_dev)):
            if self.li_out[i] != 'open':
                for j in range(len(self.li_in)):
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
	#pdb.set_trace()
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
				if swc_name0 in["ladder_blk[0]","c4_blk[0]","Nagating_blk[0]","speech[0]","HOP_bif[0]","ladder_filter[0]","hh_neuron_b_debug[0]","INFneuron[0]","lpf[0]","lpf_2[0]","peak_detector[0]","hhneuron[0]","ramp_fe[0]",'sigma_delta_fe[0]',"cap_sense[0]","h_rect[0]","switch_cap[0]",'nmirror[0]',"vco[0]"]:
					#pdb.set_trace()
					swc_name1 = j
				elif swc_name0 in["dendiff[0]"]:
					swc_name1 = j+'['+sb.name.split('[')[1]
					swc_name = j+'['+sb.name.split('[')[1]
					if swc_name1 == 'dendiff_vmem[0]':
					    den_size=1
					    swc_name2=swc_name1
					else:
					    den_size=5
					if swc_name1 in ['dendiff_synapse[0]','dendiff_axial[0]','dendiff_leak[0]','dendiff_vmem[0]']:
					    targets=list(ex_fg[s].split("=")[1].split(","))
					for h in range(0,den_size):
					    if swc_name1 == 'dendiff_synapse[0]':
						swc_name2='dendiff_synapse'+'['+str(h)+']'
					    elif swc_name1 == 'dendiff_axial[0]':
						swc_name2='dendiff_axial'+'['+str(h)+']'
					    elif swc_name1 == 'dendiff_leak[0]':
						swc_name2='dendiff_leak'+'['+str(h)+']'
					    #pdb.set_trace()
					    
					    swc2 = self.stats.dev_fgs[swc_name2]
					    swcx = self.array_stats.getTileOffset(swc2, self.grid_loc)
					    swcx.append(targets[h])
					    swcx.append(1)
					    self.swcs.append(swcx)
					    if verbose: print '%s %s -> (%g %g) -> (%g %g)'%(swc_name0, swc_name2, swc2[0], swc2[1], swcx[0], swcx[1])
					continue
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
					#if n==0:
					#	swcx.append(ex_fg[s].split('=')[1])
					#else:
					#	print "yo1"#swcx.append(0)
					if n==0 and swc_name1 not in ['sftreg_fg[0]', 'DAC_sftreg_fg[0]','sftreg2_fg[0]','nfet_i2v_fg[0]','pfet_i2v_fg[0]','i2v_pfet_gatefgota_fg[0]','mismatch_meas_fg[0]','mmap_ls_fg[0]','mmap_ls_in_r0_vdd[0]','mmap_ls_in_r0[0]','mmap_ls_in_r1_vdd[0]','mmap_ls_in_r1[0]','mmap_ls_in_r2_vdd[0]','mmap_ls_in_r2[0]','mmap_ls_in_r3_vdd[0]','mmap_ls_in_r3[0]','mmap_ls_in_r4_vdd[0]','mmap_ls_in_r4[0]','mmap_ls_in_r5_vdd[0]','mmap_ls_in_r5[0]','mmap_ls_in_r6_vdd[0]','mmap_ls_in_r6[0]','mmap_ls_in_r7_vdd[0]','mmap_ls_in_r7[0]','mmap_ls_in_r8_vdd[0]','mmap_ls_in_r8[0]','mmap_ls_in_r9_vdd[0]','mmap_ls_in_r9[0]','mmap_ls_in_r10_vdd[0]','mmap_ls_in_r10[0]','mmap_ls_in_r11_vdd[0]','mmap_ls_in_r11[0]','mmap_ls_in_r12_vdd[0]','mmap_ls_in_r12[0]','mmap_ls_in_r13_vdd[0]','mmap_ls_in_r13[0]','mmap_ls_in_r14_vdd[0]','mmap_ls_in_r14[0]','mmap_ls_in_r15_vdd[0]','mmap_ls_in_r15[0]','mmap_ls_in_r16_vdd[0]','mmap_ls_in_r16[0]','mmap_ls_in_r17_vdd[0]','mmap_ls_in_r17[0]','mmap_ls_in_r18_vdd[0]','mmap_ls_in_r18[0]','mmap_ls_in_r19_vdd[0]','mmap_ls_in_r19[0]','mmap_ls_in_r20_vdd[0]','mmap_ls_in_r20[0]','mmap_ls_in_r21_vdd[0]','mmap_ls_in_r21[0]','mmap_ls_in_r22_vdd[0]','mmap_ls_in_r22[0]','mmap_ls_in_r23_vdd[0]','mmap_ls_in_r23[0]','mmap_ls_in_r24_vdd[0]','mmap_ls_in_r24[0]','mmap_ls_in_r25_vdd[0]','mmap_ls_in_r25[0]','mmap_ls_in_r26_vdd[0]','mmap_ls_in_r26[0]','mmap_ls_in_r27_vdd[0]','mmap_ls_in_r27[0]','mmap_ls_in_r28_vdd[0]','mmap_ls_in_r28[0]','mmap_ls_in_r29_vdd[0]','mmap_ls_in_r29[0]','mmap_ls_in_vdd1_vdd[0]','mmap_ls_in_vdd1[0]','mmap_ls_in_vdd2_vdd[0]','mmap_ls_in_vdd2[0]','mmap_ls_in_vdd3_vdd[0]','mmap_ls_in_vdd3[0]','mmap_ls_in_in12_1_vdd[0]','mmap_ls_in_in12_1[0]','mmap_ls_in_in12_2_vdd[0]','mmap_ls_in_in12_2[0]','mmap_ls_in_in12_3_vdd[0]','mmap_ls_in_in12_3[0]','th_logic_fg[0]']: 
						swcx.append(ex_fg[s].split('=')[1])
                                        if ex_fg[s].split('=')[0] in ['ota_p_bias ','ota_n_bias ']:
						#pdb.set_trace() 
						swcx.append(3)
					elif swc_name1 in ['c4_ota_p_bias[0]','c4_ota_n_bias[0]','c4_ota_p_bias[1]','c4_ota_n_bias[1]','Nagating_ota_p_bias[0]','Nagating_ota_n_bias[0]','peak_ota_n_bias[0]','peak_ota_p_bias[0]','sd_ota_p_bias[0]','sd_ota_n_bias[0]','sd_ota_p_bias[1]','sd_ota_n_bias[1]']:
						swcx.append(3)
					elif swc_name1 in ['hh_ota_p_bias[0]','hh_ota_n_bias[0]','hh_ota_p_bias[1]','hh_ota_n_bias[1]','i2v_pfet_gatefgota_fgotapbias[0]','i2v_pfet_gatefgota_fgotanbias[0]','mismatch_meas_pfetg_fgotapbias[0]','mismatch_meas_pfetg_fgotanbias[0]','mismatch_meas_out_fgotapbias[0]','mismatch_meas_out_fgotanbias[0]']:
						swcx.append(3)
					elif swc_name1 in ['hh_nabias','hh_kbias','hh_vinbias','hh_voutbias']:
						swcx.append(2)	
					elif swc_name1 in ['c4_ota_bias[0]','c4_ota_bias[1]','Nagating_ota_bias[0]','Nagating_ota_bias[1]','peak_ota_bias[0]','h_rect_bias[0]','speech_peakotabias[0]','speech_peakotabias[1]','sd_ota_bias[0]','sd_ota_bias[1]','sd_ota_bias[2]','sd_ota_bias[3]','cap_sense_ota[0]','cap_sense_ota[1]','integrator_ota0[0]','integrator_ota1[0]','integrator_nmirror_ota0[0]','integrator_nmirror_ota1[0]','hh_neuron_b_bias_1[0]','hh_neuron_b_bias_4[0]','switch_cap_bias[0]','nfet_i2v_otabias[0]','pfet_i2v_otabias[0]','i2v_pfet_gatefgota_ota0bias[0]','i2v_pfet_gatefgota_fgotabias[0]','mismatch_meas_pfetg_fgotabias[0]','mismatch_meas_out_fgotabias[0]']:
						swcx.append(2)	
					elif swc_name1 in ['hh_leak','Nagating_fbpfetbias','vd_target[0]','vd_target[1]','INF_bias[0]','speech_pfetbias[0]','ramp_pfetinput[0]','ramp_pfetinput[1]','speech_pfetbias[1]','cap_sense_pfet[0]','hh_fbpfetbias','integrator_nmirror_ota2[0]','nmirror_bias[0]','cs_bias[0]','mismatch_meas_cal_bias[0]']:
						swcx.append(1)
                                        elif sb.name.split('[')[0] in ['ota','ota_buf','fgota','ladder_blk','h_rect','INFneuron','lpf','ramp_fe','sigma_delta_fe','lpf_2'] and swc_name1[0:6]!="c4_cap" and  swc_name1[0:5]!="c4_fg" and n==0 and swc_name1 not in ['INF_fg[0]','lpf_fg[0]','peak_detector[0]'] and swc_name1[0:7] not in ['lpf_cap','ramp_fe','sigma_d','ota_sma'] :
						#pdb.set_trace()
						swcx.append(2)
					elif swc_name1 in ['mmap_ls_in_r0[0]','mmap_ls_in_r1[0]','mmap_ls_in_r2[0]','mmap_ls_in_r3[0]','mmap_ls_in_r4[0]','mmap_ls_in_r5[0]','mmap_ls_in_r6[0]','mmap_ls_in_r7[0]','mmap_ls_in_r8[0]','mmap_ls_in_r9[0]','mmap_ls_in_r10[0]','mmap_ls_in_r11[0]','mmap_ls_in_r12[0]','mmap_ls_in_r13[0]','mmap_ls_in_r14[0]','mmap_ls_in_r15[0]','mmap_ls_in_r16[0]','mmap_ls_in_r17[0]','mmap_ls_in_r18[0]','mmap_ls_in_r19[0]','mmap_ls_in_r20[0]','mmap_ls_in_r21[0]','mmap_ls_in_r22[0]','mmap_ls_in_r23[0]','mmap_ls_in_r24[0]','mmap_ls_in_r25[0]','mmap_ls_in_r26[0]','mmap_ls_in_r27[0]','mmap_ls_in_r28[0]','mmap_ls_in_r29[0]','mmap_ls_in_vdd1[0]','mmap_ls_in_vdd2[0]','mmap_ls_in_vdd3[0]','mmap_ls_in_in12_1[0]','mmap_ls_in_in12_2[0]','mmap_ls_in_in12_3[0]']:
						swcx.append(ex_fg[s].split('=')[1])
                                                swcx.append(11)
					else:
						print "yo"#swcx.append(0)
				        self.swcs.append(swcx)
					#if swc_name1[0:6]=="c4_cap": pdb.set_trace()
					if isinstance(swc2[0],int): break

class cab2(complexBlock):
    def __init__(self, name):
        
        self.name = name
        self.type = 'CAB2'
        self.stats = cab2Stats()     
        self.array_stats = arrayStats()
        self.subblocks = []
        
        #CAB ports
        self.inputs = ['open']*self.stats.num_inputs
        self.outputs = ['open']*self.stats.num_outputs

        #CAB Devices
        dev_types = self.stats.dev_types
        dev_pins = self.stats.dev_pins    
        self.addSubs(dev_types, dev_pins)
   
    def genLI(self, *var):
        self.swcs = []
        #cab = rasp3array().array['cab']
        verbose = 1
	#print "#######################"
        if len(var) == 1: verbose = 1
        #pdb.set_trace()
        #inputs to local interconnect--
        #   inputs to CAB + outputs from DEVs
	#print self.inputs
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
        x = 2
        for i in range(len(self.li_in)):
            if verbose: print '%s'%str(i).ljust(2),
        if verbose: 
		print "Hallelujah!"
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
                    if self.li_out[i] == self.li_in[j]:
                        if verbose: print str('X').ljust(x),
                        self.li[i][j] = 1
			#pdb.set_trace()
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
        verbose = 0
        for i in range(len(self.subblocks)):
            sb = self.getSub(i)
	    
	    #print sb
            if sb.outputs != 'open':
                swc_name0 = sb.name
                #pdb.set_trace()
                if sb.ex_fgs:
		    ex_fg=sb.ex_fgs.split("&")
		    for s in range(len(ex_fg)):
			print "ok here too22"
			for j in ex_fg[s].split()[::2]:	
			    #pdb.set_trace()
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
				    if n==0: ##double check
					    swcx.append(ex_fg[s].split('=')[1])
				    else:
					    swcx.append(0)
				    if sb.name.split('[')[0] == 'meas_volt_mite' and n==0:
					    swcx.append(4)
				    if sb.name.split('[')[0] == 'mite' and n==0:
					    swcx.append(4)
				    elif sb.name.split('[')[0] == 'mult' and n==0:
					    swcx.append(1)
				    elif sb.name.split('[')[0] == 'ota2_bias' and n==0:
					    swcx.append(2)					    
					    #pdb.set_trace()
				    else:
					    swcx.append(0)
				    self.swcs.append(swcx)
				    if isinstance(swc2[0],int):
					    n=2
			#pdb.set_trace()   
    

                        
class ioblock(complexBlock):
    def __init__(self, name):
        self.name = name
        self.type = 'ioblock'
#        self.inputs = ['open','open','open','open','open','open']
#        self.outputs = ['open','open','open','open','open','open']
#        self.portorder = [0,3,6,9,12,15,1,4,7,10,13,16]
        self.inputs = ['open']*12
        self.outputs= ['open']*6
        self.portorder = [0,3,6,9,12,15,1,2,4,5,7,8,10,11,13,14,16,17] ## $$
        self.num=[]
        self.swcs = []

        self.stats = iosdStats()    #$$ 
        self.array_stats = arrayStats()
       
        self.subblocks = []
        for i in range(6):
            self.addSub(pblock('empty', 'ioslice'))
            
            
    def genLI(self):
	#global groutes
	port_dig = ['I3','I7','I11','I15','O3','O7'] #$$
        port_ana = ['I8','I9','I13','I14','I15','O4']
	port_east = ['I4','I5','I6','I7','O2','O3']
        verbose = 1
#        for i in range(len(self.portorder)):
#            print self.getPort(i),
#        print
#        for i in range(len(self.portorder)):
#            print self.stats.pin_order[i],
#        print
        
        for i in range(len(self.subblocks)):
            csub = self.getSub(i)
	    #print("uuuuuu*********************")
	    #pdb.set_trace()
            if csub.outputs != 'open':
		if(csub.grid_loc[0] in [1,4,5,8,9,12,13]):
			self.stats=iosdStats()	
	                swc_name0 = port_dig[csub.number]
	                swc_name1 = csub.type
		elif(csub.grid_loc[0] == 15):
			self.stats=ioeStats()
			swc_name0 = port_east[csub.number]
	                swc_name1 = csub.type
 		else:
			self.stats=iosaStats()		
			swc_name0 = port_ana[csub.number]
	                swc_name1 = csub.type
			swc_name1 = swc_name1.strip() # strips leading and ending spaces
               
		#pdb.set_trace()
		if (swc_name1 == 'int[0]' or swc_name1 == '') :
			pdb.set_trace()
                if (swc_name1[1:-3] != 'int'and csub.name != 'gnd' and csub.name != 'vcc' and csub.name != 'out:gnd') :    #we'll pick these up in the devFG generation          
		   
                    #swc_port1 = self.getPort(swc_net1)  #$$
                    #swc_name1 = self.stats.pin_order[swc_port1]
			#pdb.set_trace()
			print csub
                    	swc_name1=swc_name1[1:]
                	swc0 = self.stats.li[swc_name0] #get input name
                  	swc1 = self.stats.li[swc_name1] #get input type
                        swc = [swc0[0]+swc1[0],swc0[1]+swc1[1]]

		    	swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
                	if verbose: print '%s %s -> (%g %g) -> (%g %g)'%(swc_name0, swc_name1, swc[0], swc[1], swcx[0], swcx[1])
                	self.swcs.append(swcx)
		#pdb.set_trace()

        
    ###gendevFgs --IO BLOCK $$
    def genDevFgs(self):
        #swcs, swcsx = [], []
        print "I/O Blocks dev FGs"
        for i in range(len(self.subblocks)):
            csub = self.getSub(i)
	    #print csub.type
	    #pdb.set_trace()
            if csub.outputs != 'open' and csub.type[1:-3] in ['int','tgate','ana_buff_out','ana_buff_in','dig_buff_out','dig_buff_in'] : #?? dunno why was a condition
		if(csub.grid_loc[0] in [1,4,5,8,9,12,13]):
			self.stats=iosdStats()
		elif(csub.grid_loc[0] in [15]): # IO_E case
			self.stats=ioeStats()
		else:
			self.stats=iosaStats()	
	    	#pdb.set_trace()
                dev_type = csub.type[1:]
                nswcs = self.stats.dev_fgs[dev_type]
		for i in range(len(nswcs)):
			swc = [nswcs[i][0],nswcs[i][1]]
                	#swcs.extend(nswcs)
                	#pdb.set_trace()
                	print '!!!!!!!!!!!!!!%s --> '%(dev_type),
                	swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
		        print 'DEV FGs  -> (%g %g) -> (%g %g)'%(swc[0], swc[1], swcx[0], swcx[1])
			if csub.type[1:-3] in ['ana_buff_out','ana_buff_in'] and i==1:
				swcx.append('0.000002')
				swcx.append(2)
                	self.swcs.append(swcx)
	#pdb.set_trace()
		
        
    
def mainTest():
    print 'rasp30 mainTest()'
    
    cab0 = cab('o1')
    cab0.inputs[0:5] = ['i3','i4','i0','i2','i1']
    cab0.outputs[0:2] = ['n3','n4']
    cab0.getSub('ota[1]').inputs = ['i3', 'i2']    
    cab0.getSub('ota[1]').outputs = 'n3'
    cab0.getSub(3).inputs = ['i0', 'n3']
    cab0.getSub(3).outputs = 'n4'
    cab0.printSubs()
    cab0.dispLI()
    
    clb0 = clb('o2')
    
    arr0 = array()
    arr0.addSub(clb0, [1, 1])
    arr0.addSub(cab0, [2, 1])
    print arr0
    
    xx = rasp30()

    pdb.set_trace()            
    
if __name__ == "__main__":
    mainTest()
