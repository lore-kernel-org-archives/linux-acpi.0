From: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Subject: Samsung P35
Date: Fri, 12 Nov 2004 11:20:48 +0100
Message-ID: <41948E80.5030207@helios.de>
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

Hi there,

hopefully this is the right list to discuss my problem.

since two weeks I am owner of a Samsung P35 XVM 1600. I succeeded to 
install debian sarge with kernel 2.6.8 only by providing nolacpi as 
kernel parameter. I thought this would switch off acpi but I got several 
ACPI messages on boot time like:

---snip---
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6620
ACPI: RSDT (v001 PTLTD  CooperSp 0x06040000  LTP 0x00000000) @ 0x1ff76959
ACPI: FADT (v001 INTEL  ODEM     0x06040000 PTL  0x00000050) @ 0x1ff7bed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: SSDT (v001  INTEL  EISTRef 0x00000001 INTL 0x02002015) @ 0x1ff76989
ACPI: DSDT (v001 INTEL  ODEM     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
...
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Power Resource [CFN1] (off)
---snip---

and so on. Everything looks quite well. So what does this parameter 
nolapic?

My problem:
Suspend does not work. Neither Fn + Sleep Key nor echo mem|disk > 
/sys/.../state

mem does something - display is switching to text mode but returns 
immediately.

As I read about problem with suspend-to-* on P30, I thought its a good 
idea to edit the dsdt to correct a call for suspend.

So in a second step I built my own kernel (kernel-source-2.6.8 from 
debian distrib) with initrd patch to load my own dsdt. I dumped the dsdt 
corrected all warnings an errors and cat it to the end of my initrd.

Here is the result:
---snip---
or: Method execution failed [\_SB_.PCI0.LPCB.PS2M._STA] (Node dff273e0), 
AE_AML_REGION_LIMIT
     ACPI-0154: *** Error: Method execution failed 
[\_SB_.PCI0.LPCB.PS2M._STA] (Node dff273e0), AE_AML_REGION_LIMIT
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.IDEC.SECD.S_D0._STA] (Node dff27a40), AE_AML_NO_RETURN_VALUE
     ACPI-0154: *** Error: Method execution failed 
[\_SB_.PCI0.IDEC.SECD.S_D0._STA] (Node dff27a40), AE_AML_NO_RETURN_VALUE
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.IDEC.SECD.S_D1._STA] (Node dff279a0), AE_AML_NO_RETURN_VALUE
     ACPI-0154: *** Error: Method execution failed 
[\_SB_.PCI0.IDEC.SECD.S_D1._STA] (Node dff279a0), AE_AML_NO_RETURN_VALUE
...
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 5 (level, low) -> IRQ 5
...
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
...
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 5 (level, low) -> IRQ 5
...
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
...
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: ipw2200_boot.fw load failed
ipw2200: Unable to load firmware: 0xFFFFFFFE
ipw2200: failed to register network device
ipw2200: probe of 0000:02:02.0 failed with error -5
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [AC0] (on-line)
     ACPI-1133: *** Error: Method execution failed [\_PR_.CPU0._PPC] 
(Node c1705d00), AE_AML_REGION_LIMIT
ACPI: Processor [CPU0] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (off)
     ACPI-1133: *** Error: Method execution failed [\_TZ_.THRM._TMP] 
(Node dff24480), AE_AML_REGION_LIMIT
...
     ACPI-1133: *** Error: Method execution failed [\_SB_.SWSM] (Node 
c17055e0), AE_AML_REGION_LIMIT
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.LPCB.EC0_._Q69] (Node dff26c00), AE_AML_REGION_LIMIT
     ACPI-1133: *** Error: Method execution failed [\_SB_.SWSM] (Node 
c17055e0), AE_AML_REGION_LIMIT
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.LPCB.EC0_._Q69] (Node dff26c00), AE_AML_REGION_LIMIT
     ACPI-1133: *** Error: Method execution failed [\_SB_.SWSM] (Node 
c17055e0), AE_AML_REGION_LIMIT
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.LPCB.EC0_._Q69] (Node dff26c00), AE_AML_REGION_LIMIT
---snip---

the last few messages occur when I try to change display brightness. The 
fan isn't working any more - this is maybe because the kernel isn't able 
to access the corresponding acpi funcion any more.

I wasn't able to get the beginning of the dmesg buffer because it was 
alredy rolled out.

Can anyone help me interpret this? What the hell went wron? The built in 
dsdt is damaged but it succeeds to handle a lot of acpi events. My own 
one compiled without any warning or error seems to be badly damaged, 
nearly each call fails on several errors.

I now got a vanilla kernel 2.6.9 and start compiling but there went 
something wrong with DRM so this is still in progress (btw. I could not 
find any cramfs patch for 2.6.9 any more, is this path obsolete for 2.6? 
and even more, debian is using a bunch of patches, which of them are 
really necessary, any idea?)

Where do I need to start at?

Thanks for any hints,
Oliver


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
