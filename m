From: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Subject: Re: Crash with fs corruption on 2.4.23-rc1 + CONFIG_ACPI_PROCESSOR
Date: Sat, 15 Nov 2003 13:54:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031115125406.GA1074@hottah.alcove-fr>
References: <20031113161857.GM26911@roosevelt.alcove-fr> <20031114124713.GK32464@poupinou.org> <20031114152403.GK29316@roosevelt.alcove-fr> <20031115065020.GO32464@poupinou.org>
Reply-To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031115065020.GO32464-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 15, 2003 at 07:50:20AM +0100, Ducrot Bruno wrote:

> Thanks anyway.  Can you tell if processor C3 is enabled with a 2.6 kernel?


>From the 2.6 boot logs:
	crusoe kernel: ACPI: Processor [CPU0] (supports C1 C2 C3)


But look at the other /proc/acpi/processor/ information below.

> Also, I would like to receive the lspci -xxx -s0:0.0 for the northbridge,
> and the same for all the function of the PIIX4 southbridge.
> 
> Even if you may think that it is irrelevant, I would like to receive
> the output of speedstep-detect from
> ftp://ftp.poupinou.org/cpufreq/speedstep-detect.tar.gz
> 
> because it dump the pm io registers of the PIIX4, regardless of the processor..

All those attached below.
> 
> I think the trouble come from C3, just need to check some values.  If you
> can, it may be usefull that you disable C3, with something like that:
> 
> +		acpi_fadt.plvl3_lat = 1234;

Will try it ASAP.

Thanks,

Stelian.

# uname -a
Linux crusoe.dsnet 2.6.0-test9 #1 Thu Nov 13 16:12:37 CET 2003 i686 i686 i386 GNU/Linux
# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
performance management:  no
limit interface:         no
# cat /proc/acpi/processor/CPU0/limit
<not supported>
# cat /proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000170]
   *C2:                  promotion[C3] demotion[C1] latency[003] usage[00160406]
    C3:                  promotion[--] demotion[C2] latency[032] usage[00000000]
# cat /proc/acpi/processor/CPU0/throttling
<not supported>
# lspci
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02)
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
00:0b.0 Multimedia controller: Kawasaki Steel Corporation KL5A72002 Motion JPEG (rev 01)
00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
00:0d.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M (rev 64)

# lspci -xxx -s0:0.0
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge
00: 79 12 95 03 06 00 00 22 00 00 00 06 00 00 80 00
10: 00 00 00 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 12 95 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 0f 00 0f 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 5f 11 11 01 30 00 11
60: 10 ff ff ff 23 33 00 00 00 00 00 00 00 00 00 00
70: 00 00 0a 3f 86 80 07 21 22 00 58 00 00 00 00 00
80: 31 11 03 11 31 11 04 22 00 00 00 00 00 00 00 00
90: 22 00 32 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 06 00 00 00 00 00 00 01 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 04 80 00 3c 00 30 02 00
e0: 14 80 00 00 00 00 01 00 15 80 00 00 00 00 01 00
f0: 04 80 00 3c 00 24 02 00 00 00 00 00 58 02 33 09

# lspci -xxx -s0:7.0
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 f3 04
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 09 09 09 09 92 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 04 01 51 71 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 25 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

# lspci -xxx -s0:7.0.1
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 a3 00 80 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

# lspci -xxx -s0:7.2
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 1f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

# lspci -xxx -s0:7.3
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00: 86 80 13 71 03 00 80 02 03 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 80 00 00 0f ff bf ff 22 24 00 00 00 00 00 00
50: 00 00 18 00 ff 3f 00 00 37 80 00 02 00 00 00 00
60: 80 00 c0 00 c0 10 c4 00 40 80 13 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 98 03 01 00 98 03 01 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

# ./speedstep-detect
dmi_scan: return:
DMI 2.3 present.
29 structures occupying 936 bytes.
DMI table at 0x000DC010.
BIOS Vendor: Phoenix Technologies LTD
BIOS Version: WXP02P1
BIOS Release: 09/26/01
System Vendor: Sony Corporation    
Product Name: PCG-C1VE(FR)        
Version: 01                  
Board Vendor: Sony Corporation    
Board Name: PCG-C1VE(FR)        
Board Version: 01                  
Trying Intel's int15 GSIC:
BIOS DO NOT support GSIC call.  Dumping registers anyway:
eax = 0x00008680
ebx = 0x00000000
ecx = 0x00000000
edx = 0x47534943
Note also that some BIOS do not support the initial GSIC call, but the newer
speeedstep-smi driver may work.
For this, you need to pass some arguments to the speedstep-smi driver:
	smi_cmd=0x?? smi_port=0x?? smi_sig=1

Unfortunately, you have to know what exactly are smi_cmd and smi_port, and this
is system dependant.  Please look at http://??? for more information.

probing chipsets: Found PIIX4
  pmbase at 0x8000
Dumping PM IO register for this southbridge:
PMCNTRL (0x8004): 0x1401
(0x8006):         0x0000
GPEN (0x800e):    0x0f00
PCNTRL (0x8010):  0x00001202
(0x8016):         0x0000
DEVSTS (0x801c):  0x00000000
GLBLEN (0x8020):  0x0001
(0x8022):         0x00000000
GLBCTL (0x8028):  0x0301ff05
DEVCTL (0x802c):  0x01000000
GPIs: (0x8030):   0x3e827b
(0x8033):         0x00
GPOs: (0x8034):   0x00e069bf
(0x8038):         0x7b 0x82 0x3e 0x00 0xbf 0x69 0xe0 0x00 


You need to boot on AC and battery and see if GPOs change.
Then, see if one bit change in between, you have then to note the number
of this bit.  This will be the gpo_hilo= number kernel option for
enabling the speedstep-piix4 module under Linux.
                                      ..28..24..20..16..12...8...4...0
        GPOs: (0x8034):   0x00e069bf  00000000111000000110100110111111
-- 
Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Alcove - http://www.alcove.com


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
