From: mammique <mammique-nqRm+8PwNSNAfugRpC6u6w@public.gmane.org>
Subject: no fan an fujitsu-siemens amilo L1300 laptop
Date: Thu, 30 Jun 2005 12:39:10 +0200
Message-ID: <da0hm8$23h$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

acpi do not show any fan in /proc/acpi/fan, including with lasted patch 
of acpi against 2.6.11 kernel. What can i do to make it work ? Is it an 
acpi problem or an incompatible DSDT ? There is no DSDT for L1300 on 
acpi database, may i try another fujitsu-siemens DSDT available ?

Regards.

Camille.

PS: some information....






# cat /proc/acpi/info
version:                 20050408







root@TryphonTournesol:~# dmesg | grep -i acpi
  BIOS-e820: 000000001dff0000 - 000000001dffffc0 (ACPI data)
  BIOS-e820: 000000001dffffc0 - 000000001e000000 (ACPI NVS)
ACPI: RSDP (v000 OID_00                                ) @ 0x000e6010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010103) @ 0x1dffce90
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010103) @ 0x1dfffb00
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010103) @ 0x1dfffb90
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010103) @ 0x1dfffbc0
ACPI: DSDT (v001 MTC___ winner__ 0x00001004 INTL 0x02002025) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: setting ELCR to 0200 (from 0ca8)
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 10 11) *7
ACPI: Embedded Controller [EC0] (gpe 28)
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) 
-> IRQ 5
ACPI wakeup devices:
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 3
ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKE] -> GSI 3 (level, low) 
-> IRQ 3
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, 
low) -> IRQ 10
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, 
low) -> IRQ 10







# find /proc/acpi/
/proc/acpi/
/proc/acpi/thermal_zone
/proc/acpi/fan
/proc/acpi/processor
/proc/acpi/processor/CPU0
/proc/acpi/processor/CPU0/power
/proc/acpi/processor/CPU0/limit
/proc/acpi/processor/CPU0/throttling
/proc/acpi/processor/CPU0/info
/proc/acpi/ac_adapter
/proc/acpi/ac_adapter/AC
/proc/acpi/ac_adapter/AC/state
/proc/acpi/battery
/proc/acpi/battery/BAT0
/proc/acpi/battery/BAT0/alarm
/proc/acpi/battery/BAT0/state
/proc/acpi/battery/BAT0/info
/proc/acpi/wakeup
/proc/acpi/alarm
/proc/acpi/sleep
/proc/acpi/event
/proc/acpi/fadt
/proc/acpi/dsdt
/proc/acpi/info
/proc/acpi/power_resource
/proc/acpi/embedded_controller
/proc/acpi/embedded_controller/EC0
/proc/acpi/embedded_controller/EC0/info






# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Celeron(R) M processor         1.40GHz
stepping        : 6
cpu MHz         : 174.619
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe
bogomips        : 2768.89



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
