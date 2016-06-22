import pdb, copy

def recStrExpand0(x):
    """takes a string like: x[0:1].y[0:1] and returns a list: 
    ['x[0].y[0]', 'x[0].y[1]', 'x[1].y[0]', 'x[1].y[1]']    
    """

    results = []
    if x.find(':') == -1:
        return [x]
    else:
        ind = x.find(':')
        r0 = int(x[:ind].split('[')[-1])
        r1 = int(x[ind+1:].split(']')[0])
        
        for i in range(r0,r1+1):
            xn =  '['.join(x[:ind].split('[')[:-1]) + '[%g]'%i + ']'.join(x[ind+1:].split(']')[1:])
            results.extend(recStrExpand(xn))
            
        return results
        
def recStrExpand(*var):
    x = var[0]
    
    res = []
    if isinstance(x, str):
         res = recStrExpand0(x)
    else:
        for i in x:
            res.extend(recStrExpand0(i))
   
    
    if len(var) > 1 and var[1] == 'remBrak':
        for i in range(len(res)):
            res[i] = res[i].replace('[','').replace(']','')
    
    return res


def smDictFromList(*var):
    """used to build a SM address double-look-up-table (i think i made that up)
   where net names are keys into the dict that return partial addresses
   adding two partial addresses from two indexes into the dict returns
   the fg address that connects those two nets.  these two nets must
   be bipartite in the SM connection graph

   anyway, this function builds this dictionary more conveniently
   x = ['nfet[0:1].out[0]'   ,[0, range(23, 25)],
   'ota[0:3].in[0:1]'   ,[range( 0,  8), 0]]
   as input will return
   {'ota[0].in[1]': [1, 0], 'nfet[1].out[0]': [0, 24], 'ota[2].in[1]': [5, 0], 'ota[1].in[1]': [3, 0], 'ota[1].in[0]': [2, 0], 'ota[3].in[1]': [7, 0], 'ota[3].in[0]': [6, 0], 'nfet[0].out[0]': [0, 23], 'ota[0].in[0]': [0, 0], 'ota[2].in[0]': [4, 0]}     
    """
    x = var[0]
    smdict = dict()
    for i in range(len(x))[::2]:
        if len(var) > 1 and var[1] == 'remBrak':
            names = recStrExpand(x[i], 'remBrak')
        else:
            names = recStrExpand(x[i])
            
        sma = x[i+1]
        
        smal = []        
        if len(names) == 1:
            smal = [sma]
        else:
            if isinstance(sma[0], int):
		#print sma
		#pdb.set_trace()
                for j in sma[1]:
                    smal.append([sma[0], j])
            else:
                for j in sma[0]:
                    smal.append([j, sma[1]])
        idict = dict(zip(names, smal))
        smdict.update(idict)
    return smdict
    
def lutExpand(ki, p0i, p1):
    """
     ki= ['10--', '11-1', '0000']    #cover
    p0i= ['i0','i1','i2','i3']      #original pin order
    p1 = ['i2','i3','i1','i0']      #new pin order
    
    also expands out cover size to k-input lut
    
    ki = ['01', '10']
    p0i= ['n1', 'i2']
    p1 = ['i2', 'open', 'open', 'n1']
    
    """
    lut_size = 4
    k = [x.rjust(lut_size, '-') for x in ki]
    p0 = ['open']*(lut_size-len(p0i))+p0i
    
    order = [p0.index(x) for x in p1]
    cc = []
    for a0 in k: 
        a = [a0[x] for x in order]
        
        N = a.count('-')
        c = [list(a) for x in range(2**N)]
        if len(c) > 1:
            for i in range(len(c)):
                b = bin(i)[2:].zfill(N)
                for j in b:
                    ind = c[i].index('-')
                    c[i][ind] = j
                c[i] = ''.join(c[i]) # list convert to str
        else:
            c[0] = ''.join(c[0])
        cc.extend(c)
        
    #for i in cc: print i
    return cc

class pbarray(object):
    name = []
    type = []
    
    array = [] #array[x][y] indexed
    
    def __init__(self, xsize, ysize):
        #self.array = [[tile('%g_%g'%(x,y),'empty') for y in range(ysize)] for x in range(xsize)]
        self.array = [[tile('--',[]) for y in range(ysize)] for x in range(xsize)]
        
    def getSub(self, *var): 
	#pdb.set_trace()             
        if isinstance(var[0], str):                         #getSub('o1')
            for x in range(len(self.array)):
                for y in range(len(self.array[0])):
                    cur_tile = self.array[x][y]
                    if cur_tile.name == var[0]:
                        return cur_tile
        elif len(var) == 1:                               #getSub([0,1])
            return self.array[var[0][0]][var[0][1]]
        else:
            return self.array[var[0]][var[1]]               #getSub(0,1)
            
    def addSub(self, new_sub, grid_loc):
        new_sub.grid_loc = grid_loc
        self.array[grid_loc[0]][grid_loc[1]] = new_sub
        
    #def addPin(self,grid_loc,pin_loc)
#	self.array[]
    def __repr__(self):
        repr_str = ''
        for i in range(len(self.array[0]))[::-1]:
            for j in range(len(self.array)):
                repr_str = repr_str + ' %s'%self.array[j][i].name.ljust(8)
            repr_str = repr_str + '\n'
        return repr_str

class stats(object):
    def get(self,var):
        if hasattr(self, var):
            return getattr(self, var)
        elif hasattr(self, var.upper()):        #try uppercase
            return getattr(self, var.upper())
        elif hasattr(self, var.lower()):        #try lowercase
            return getattr(self, var.lower())
        else:
            pdb.set_trace()
            raise Exception("'var' or 'VAR' not an attribute of thingy")
            
class tile:
    name = []
    type = []
    
    chanx = []
    chany = []
    sblock = []
    
    cb = []
    
    def __init__(self, name, type):
        self.name = name
        self.type = type
        self.cb = complexBlock(name, type)      
        
    def __repr__(self):
        return '%s %s \n'%(self.name, self.type)
            
        
class pblock:
    name = []
    type = []
    number = []
    
    inputs = []
    outputs = []
    
    portorder = [] # portorder[:] <-> inputs[:] + ouputs[:]
    
    subblocks = []
    pin_num= [] #pin locations
    ex_fgs = []
    
    def __init__(self, name, type):
        self.name = name
        self.type = type
        
        self.subblocks = []
        self.inputs = []
        self.outputs = 'open'
        self.number = 0
    
        
    def addSub(self, *var):
        newsub = copy.deepcopy(var[0])
	#pdb.set_trace()
        if len(var) == 1:
            newsub.number = len(self.subblocks)
            self.subblocks.append(newsub)   
        else:
            if isinstance(var[1], str):
                for i in range(len(self.subblocks)):
                    if self.subblocks[i].name == var[1]:
                        subind = i
            else:
                subind = var[1]
	    try:
		del self.subblocks[subind]
	    except:
		pdb.set_trace()
            self.subblocks.insert(subind, newsub)
            self.subblocks[subind].number = subind
            
    def addSubs(self, dev_types, dev_pins):
        dev_name = 'temp[0]'
        dev_num = 0
        for i in range(len(dev_types)):
            if dev_types[i] != dev_name.split('[')[0]:
                dev_num = 0
            dev_type = dev_types[i]
            dev_name = '%s[%g]'%(dev_type,dev_num)  #ota[0]e
	    #pdb.set_trace()
            nsb = pblock(dev_name, dev_type)    #ota[0], ota
	    if self.type in ['CLB']:## if you change this change i/p type in genli() for clb in rasp30.py
            	nsb.inputs = ['open']*(dev_pins[dev_type]-1)
           	nsb.outputs = 'open'
	    else: ## CAB2 variation
		nsb.inputs = ['open']*(dev_pins[dev_type+'_in'])
		nsb.outputs =['open']*(dev_pins[dev_type+'_out'])
            self.addSub(nsb)
            dev_num = dev_num+1
            #print self 
	    #pdb.set_trace()
	    #print nsb.outputs
    def getSub(self, x):
        if self.subblocks:    
            for i in range(len(self.subblocks)):
                if self.subblocks[i].number == x or\
                    self.subblocks[i].name == x or\
                    self.subblocks[i].outputs == x:
                    return self.subblocks[i]
                    
    def getPort(self, x):
        if isinstance(x, str):
            if x in self.inputs:
                return self.portorder[self.inputs.index(x)]
            else:
                return self.portorder[self.outputs.index(x)+len(self.inputs)]
        else:
            ind = self.portorder.index(x)        
            if ind >= len(self.inputs):
                return self.outputs[ind-len(self.inputs)]
            else:
                return self.inputs[ind]
    
    def setPort(self, x, val):
        ind = self.portorder.index(x)
        if ind >= len(self.inputs):
            self.outputs[ind-len(self.inputs)] = val
        else:
            self.inputs[ind] = val
            
    def movePort(self, val, x):
        #remove pin from old port location if it existed
        if val in self.inputs: self.inputs[self.inputs.index(val)] = 'open'
        if val in self.outputs: self.outputs[self.outputs.index(val)] = 'open'
        
        #add pin new port location            
        self.setPort(x, val)
        #add pin new port location            
        
    def printSubs(self, *var):
        if var: 
            printall = 1
        else:
            printall = 1
        if self.subblocks:
            for i in range(len(self.subblocks)):                
                cur_sub = self.getSub(i)
                if cur_sub.outputs != 'open' or printall:
                    print '%g %s %s | '%(i, cur_sub.name, cur_sub.type),
                    for j in range(len(cur_sub.inputs)):
                        print '%s '%(cur_sub.inputs[j]),
                    print '-> %s'%(cur_sub.outputs)
                    
    def printAllSubs(self):
        self.printSubs('printall')
                
    def __repr__(self):
        return 'class: %s - name: %s - type: %s - num: %s '%(self.__class__.__name__, self.name, self.type, str(self.number))
                   
class complexBlock(pblock):     
    """
    after each block deals w/ making its own custom local interconnect matrix
    we look up the switch address for each on switch
    """
    def swcsFromLi(self):
        verbose = 1
	print "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	#pdb.set_trace()
        for x in range(len(self.li)):
            for y in range(len(self.li[0])):
		 #pdb.set_trace()
		 if self.li[x][y] == 1:
		     
                     try:
			 #pdb.set_trace()
			 swc_name0 = self.stats.li0[y]
			 swc_name1 = self.stats.li1[x]
			 if swc_name1 in ['cab_vmm.O[5]','cab_vmm.O[6]','cab_vmm.O[7]','vmm12x1[0].in[0]','vmm12x1_wowta[0].in[0]','vmm12x1_wowta[0].in[1]','vmm12x1_wowta[0].in[2]','vmm12x1_wowta[0].in[3]','vmm12x1_wowta[0].in[4]','vmm12x1_wowta[0].in[5]','vmm12x1_wowta[0].in[6]','vmm12x1_wowta[0].in[7]','vmm12x1_wowta[0].in[8]','vmm12x1_wowta[0].in[9]','vmm12x1_wowta[0].in[10]','vmm12x1_wowta[0].in[11]','vmm12x1[0].in[1]','vmm12x1[0].in[2]','vmm12x1[0].in[3]','vmm12x1[0].in[4]','vmm12x1[0].in[5]','vmm12x1[0].in[6]','vmm12x1[0].in[7]','vmm12x1[0].in[8]','vmm12x1[0].in[9]','vmm12x1[0].in[10]','vmm12x1[0].in[11]','vmm8x4_in[0].in[0]','vmm8x4_in[0].in[1]','vmm8x4_in[0].in[2]','vmm8x4_in[0].in[3]','vmm8x4_in[0].in[4]','vmm8x4_in[0].in[5]','vmm8x4_in[0].in[6]','vmm8x4_in[0].in[7]','DAC_sftreg[0].in[0]','DAC_sftreg[0].in[1]','DAC_sftreg[0].in[2]','nmirror[0].in[0]','nmirror_vmm[0].in[0]','th_logic[0].in[0]','th_logic[0].in[1]','th_logic[0].in[2]','th_logic[0].in[3]','th_logic[0].in[4]','th_logic[0].in[5]','th_logic[0].in[6]','th_logic[0].in[7]','dendrite_4x4[0].in[0]','dendrite_4x4[0].in[1]','dendrite_4x4[0].in[2]','dendrite_4x4[0].in[3]']:
				 #pdb.set_trace()
				 print "no LI needed dont worry!"
				 continue
			 if swc_name1 in ['cab_vmm.O[0]','cab_vmm.O[1]','cab_vmm.O[2]', 'cab_vmm.O[3]' ] and swc_name0 =='sftreg2[0].out[0]':
			     continue
			     print "NO LI needed"
			 if swc_name1 in ['cab_vmm.O[0]','cab_vmm.O[1]','cab_vmm.O[2]', 'cab_vmm.O[3]' ] and swc_name0 =='mmap_local_swc[0].out[0]':
			     continue
			     print "NO LI needed"
			 if swc_name1 in ['cab.O[0]','cab.O[1]','cab.O[2]', 'cab.O[3]' ] and swc_name0 =='mmap_local_swc[0].out[0]':
			     continue
			     print "NO LI needed"
			 if swc_name1 in ['vmm4x4_SR[0].in[0]','vmm8x4_SR[0].in[0]']:
				 swc_name0='cab_vmm.I[6]'
			 elif swc_name1 in ['vmm4x4_SR[0].in[1]','vmm8x4_SR[0].in[1]']:
				 swc_name0='cab_vmm.I[10]'
			 elif swc_name1 in ['vmm4x4_SR[0].in[2]','vmm8x4_SR[0].in[2]']:
				 swc_name0='cab_vmm.I[0]'
			 elif swc_name1 in ['vmm4x4_SR[0].in[3]','vmm8x4_SR[0].in[3]']:
				 swc_name0='cab_vmm.I[4]'
			 elif swc_name1.split("4x4[")[0] in ['vmm']:
				 swc_name0='vmm4x4_dummy['+swc_name1[13]+']'
				 #pdb.set_trace()
		         #elif swc_name0 in ['cab_vmm.I[13]','cab_vmm.I[14]','cab_vmm.I[15]','cab2.I[13]','cab2.I[14]','cab2.I[15]']:
		         elif swc_name0 in ['cab_vmm.I[13]','cab_vmm.I[14]','cab_vmm.I[15]','cab.I[13]','cab.I[14]','cab.I[15]','cab2.I[13]','cab2.I[14]','cab2.I[15]']:
			         print "no LI need for I[13:15] so dont worry!"
				 continue
			 elif swc_name1 in ['volt_div[0].in[1]','volt_div[1].in[1]','in2in_x1[0].out[0]','in2in_x1[0].in[0]','vmm8x4_in[0].in[12]']:
				print "no LI Needed"
				continue
			 elif swc_name1[:12] in ['sftreg[0].in']:
				continue
			 elif swc_name1 == 'dendiff[0].in[0]':
				 #pdb.set_trace()
				 continue
			 print swc_name0
			 print swc_name1
			 #pdb.set_trace()
			 swc0 = self.stats.li[swc_name0]
                         swc1 = self.stats.li[swc_name1]
			 if swc_name0== 'meas_volt_mite[0].out':
				swc1=[11,0]
			 elif swc_name0== 'meas_volt_mite[1].out':
				swc1=[15,0]

			 #pdb.set_trace()
			 if  all(isinstance(x,int) for x in swc0)==False:
				for i in range(len(swc0[1])):
					swc = [swc0[0]+swc1[0], swc0[1][i]+swc1[1]]
					swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
					self.swcs.append(swcx)
			 		if verbose :
					 	print 'local interconnect %g %s -> %g %s (%g %g) -> (%g %g)'%(y, swc_name0, x, swc_name1, swc[0], swc[1], swcx[0], swcx[1])
			 elif all(isinstance(x,int) for x in swc1)==False :
				for i in range(len(swc1[0])):
					swc = [swc0[0]+swc1[0][i], swc0[1]+swc1[1]]
                         		swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
					self.swcs.append(swcx)
			 		if verbose :
					 	print 'local interconnect %g %s -> %g %s (%g %g) -> (%g %g)'%(y, swc_name0, x, swc_name1, swc[0], swc[1], swcx[0], swcx[1])
					 			 	
			 else:
                         	swc = [swc0[0]+swc1[0], swc0[1]+swc1[1]]
                         	swcx = self.array_stats.getTileOffset(swc, self.grid_loc)
			 	self.swcs.append(swcx)
			 
				if verbose :
					 print 'local interconnect %g %s -> %g %s (%g %g) -> (%g %g)'%(y, swc_name0, x, swc_name1, swc[0], swc[1], swcx[0], swcx[1])
					 #print  self.array_stats.getTileOffset(swc, self.grid_loc)
					 #print self.grid_loc
		     except:
                         print 'failed in swcsFromLI()'
                         pdb.set_trace()

#class ioblock(complexBlock):
#    def __init__(self, name):
#        self.name = name
#        self.type = 'ioblock'
##        self.inputs = ['open','open','open','open','open','open']
##        self.outputs = ['open','open','open','open','open','open']
##        self.portorder = [0,3,6,9,12,15,1,4,7,10,13,16]
#        self.inputs = ['open']*6
#        self.outputs= ['open']*12
#        self.portorder = [0,3,6,9,12,15,1,2,4,5,7,8,10,11,13,14,16,17]
#        
#        self.subblocks = []
#        for i in range(6):
#            self.addSub(pblock('empty', 'ioslice'))
#            
#            
#    def genLI(self):
#        for i in range(len(self.portorder)):
#            print self.getPort(i),
#        print
#        for i in range(len(self.portorder)):
#            print iosdStats().pinorder[i]
            
            
def mainTest():
    print 'genu mainTest()'
    
    a = 'x[0:1].y[0:2].z[0]'
    ax = recStrExpand(a)
    print a
    for i in ax: print i
    print
    
    a = ['x[0:1].y[0:2].z[0]', 'z[0:3]']
    ax = recStrExpand(a)
    print a
    for i in ax: print i
    print
    
    ax = recStrExpand(a, 'bacon')
    print a
    for i in ax: print i
    print
    
    ax = recStrExpand(a, 'remBrak')
    print a
    for i in ax: print i
    print
    
    fg =  ['volswc[0:1].out[0]' ,[0, range(33, 35)],
           'ota[0:3].in[0:1]'   ,[range( 0,  8), 0]]
    fgd = smDictFromList(fg)
    #fgd = smDictFromList(fg, 'remBrak')    
    for i in fgd.keys():
        print '%s (%s %s)'%(i, fgd[i][0], fgd[i][1])
            
    #print recStrExpand.__doc__
    #print smDictFromList.__doc__
    
    k = ['10--', '11-1', '0000']    #cover
    p0 = ['i0','i1','i2','i3']      #original pin order
    p1 = ['i2','i3','i1','i0']      #new pin order
    kk = lutExpand(k, p0, p1)
#    for i in kk: print i
    
    k = ['01', '10']
    p0 = ['n1', 'i2']
    p1 = ['i2', 'open', 'open', 'n1']
    kk = lutExpand(k, p0, p1)
    for i in kk: print i
    

    #pdb.set_trace()            
    
if __name__ == "__main__":
    mainTest()
     
