From: Ville =?ISO-8859-1?Q?P=E4tsi?= <drc-dZkOyQknF4g@public.gmane.org>
Subject: S3 resume video fail and other oddities with Acer Travelmate 230
Date: Sat, 04 Oct 2003 09:31:28 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065249088.3777.5.camel@corsair>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have an Acer Travelmate 230. This is with the Linux
2.6.0-test6-mm2-kernel,
which incorporates the 20030918 ACPI patch.


This happens when I issue "echo 3 > /proc/acpi/sleep":

Oct  4 01:22:43 corsair kernel: Stopping tasks:
=============================|
Oct  4 01:22:43 corsair kernel: hdc: start_power_step(step: 0)
Oct  4 01:22:43 corsair kernel: hdc: completing PM request, suspend
Oct  4 01:22:43 corsair kernel: hda: start_power_step(step: 0)
Oct  4 01:22:43 corsair kernel: hda: start_power_step(step: 1)
Oct  4 01:22:43 corsair kernel: hda: complete_power_step(step: 1, stat:
50,
err: 0)
Oct  4 01:22:43 corsair kernel: hda: completing PM request, suspend
Oct  4 01:22:43 corsair kernel: bad: scheduling while atomic!
Oct  4 01:22:43 corsair kernel: Call Trace:
Oct  4 01:22:43 corsair kernel:  [<c011d79d>] schedule+0x5ba/0x5bf
Oct  4 01:22:43 corsair kernel:  [<c02d9a89>] pci_read+0x3d/0x41
Oct  4 01:22:43 corsair kernel:  [<c01298c0>] schedule_timeout+0x63/0xb7
Oct  4 01:22:43 corsair kernel:  [<c0129854>] process_timeout+0x0/0x9
Oct  4 01:22:43 corsair kernel:  [<c01e7433>]
pci_set_power_state+0xeb/0x18f
Oct  4 01:22:43 corsair kernel:  [<d00a3224>] rtl8139_suspend+0x7e/0xb8
[8139too]
Oct  4 01:22:43 corsair kernel:  [<c01e981d>]
pci_device_suspend+0x2c/0x2e
Oct  4 01:22:43 corsair kernel:  [<c0236e84>] suspend_device+0xfc/0x103
Oct  4 01:22:43 corsair kernel:  [<c0236efa>] device_suspend+0x6f/0x91
Oct  4 01:22:43 corsair kernel:  [<c0138b0d>] suspend_prepare+0x63/0x8d
Oct  4 01:22:43 corsair kernel:  [<c0138c05>] enter_state+0x49/0x9c
Oct  4 01:22:43 corsair kernel:  [<c0202c26>] acpi_suspend+0x49/0x4f
Oct  4 01:22:43 corsair kernel:  [<c0202d8c>]
acpi_system_write_sleep+0xb7/0xdd
Oct  4 01:22:43 corsair kernel:  [<c0156ad3>] vfs_write+0xbc/0x127
Oct  4 01:22:43 corsair kernel:  [<c0156be3>] sys_write+0x42/0x63
Oct  4 01:22:43 corsair kernel:  [<c033fad2>]
sysenter_past_esp+0x43/0x65
Oct  4 01:22:43 corsair kernel:  
Oct  4 01:22:43 corsair kernel: zapping low mappings.
Oct  4 01:22:43 corsair kernel: eth0: link down
Oct  4 01:22:43 corsair kernel: hda: Wakeup request inited, waiting for
!BSY...
Oct  4 01:22:43 corsair kernel: eth0: link up, 10Mbps, half-duplex, lpa
0x0000
Oct  4 01:22:43 corsair kernel: hda: start_power_step(step: 1000)
Oct  4 01:22:43 corsair kernel: blk: queue cf5e3200, I/O limit 4095Mb
(mask
0xffffffff)
Oct  4 01:22:43 corsair kernel: hda: completing PM request, resume
Oct  4 01:22:43 corsair kernel: hdc: Wakeup request inited, waiting for
!BSY...
Oct  4 01:22:43 corsair kernel: hdc: start_power_step(step: 1000)
Oct  4 01:22:43 corsair kernel: hdc: completing PM request, resume
Oct  4 01:22:43 corsair kernel: Restarting tasks... done

The system does go to sleep, but video doesn't resume. If I set
acpi_sleep=s3_bios the lcd backlight comes back to life, but the
graphics
itself don't. I also get the same when X is running, but sleep is run
from a
virtual console. But then network doesn't work after resume.


This is while I was in X (4.3.0, i845g-graphics):

Oct  4 01:52:20 corsair kernel: Debug: sleeping function called from
invalid
context at include/asm/uaccess.h:512
Oct  4 01:52:20 corsair kernel: in_atomic():0, irqs_disabled():1
Oct  4 01:52:20 corsair kernel: Call Trace:
Oct  4 01:52:20 corsair kernel:  [<c011ed15>] __might_sleep+0x9c/0xb7
Oct  4 01:52:20 corsair kernel:  [<c010d60c>] save_v86_state+0x6c/0x1f5
Oct  4 01:52:20 corsair kernel:  [<c010ccaf>] do_IRQ+0x10c/0x13f
Oct  4 01:52:20 corsair kernel:  [<c033fb7a>]
work_notifysig_v86+0x6/0x14
Oct  4 01:52:20 corsair kernel:  [<c033fb27>] syscall_call+0x7/0xb

The system apparently hangs. The display goes to sleep, I resume, but
display
doesn't return, and the machine doesn't respond to network.


Boot ACPI info:

 BIOS-e820: 000000000f760000 - 000000000f76e000 (ACPI data)
 BIOS-e820: 000000000f76e000 - 000000000f780000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                     ) @
0x000f5c60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x0f7698d1
ACPI: FADT (v001 INTEL  NBGV     0x06040000 PTL  0x00000003) @
0x0f76df14
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @
0x0f76df88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
0x0f76dfd8
ACPI: DSDT (v001   WIST  PELICAN 0x06040000 MSFT 0x0100000d) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
ACPI: Subsystem revision 20030918
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *11)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (40 C)
ACPI: (supports S0 S3 S4 S5)





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
