From: Damien Elmes <damien-voeRRA98qc6eZLLa646FqQ@public.gmane.org>
Subject: Cardbus + ACPI weirdness on a Compaq laptop
Date: Wed, 21 Apr 2004 13:10:57 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <864qrem0mm.fsf@mobile.repose.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Howdy folks,

I recently bought a cardbus-based wireless network card. I had a
pcmcia wireless card previously which worked fine.

When I first plugged the card in I noticed that the system slowed
down to a snails pace. The 'events' kernel process was using all of
the CPU and choking other processes from running.

After some fiddling I traced it down to ACPI support. When ACPI is
off, the events are never generated, and so the system runs as normal.

What's also strange is that when you enable the network interface (in
other words, bring it from a powered-on state to a network-associated
state), the CPU consumption of 'events' drops from about 99% to 70% -
so the utilisation of the card is reducing the number of events that
are being generated.

The actual events seem strange (to me at least, an ACPI newbie) - I
imagine "PWRB" is the power button and "PCIB" is the PCI bus? Both
events are generated about 350 times a second:

22:12:53 Execute Method: [\_GPE._L0B] (Node c12c5208)
22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d4528
22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PCIB] node c12d4528
22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d8528
22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PWRB] node c12d8528
22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PCIB]
22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PWRB]
22:12:53 Execute Method: [\_GPE._L0B] (Node c12c5208)
22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d4528
22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PCIB] node c12d4528
22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d8528
22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PWRB] node c12d8528
22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PCIB]
22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PWRB]

I had a quick hack at the code in an effort to fix the problem. I
thought that maybe if I ignored the spurious GPE message in
evgpe.c:acpi_ev_gpe_detect(), avoiding further processing would
reduce the CPU load. Unfortunately that doesn't seem to have an
effect on the problem.

I discovered that if I return INTERRUPT_NOT_HANDLED from that
function, the kernel complains about it and disables the ACPI
interrupt. This effectively solves my problem since I only use ACPI
for battery status, and don't need the ACPI interrupt to check the
power button, etc. However, it's a pretty ugly "solution" and I'm not
sure if that prevents the "fan" module (which I also run) from
working properly.

There doesn't appear to be an IRQ conflict:

irq 9: nobody cared!
Call Trace:
 [<c010933a>] __report_bad_irq+0x2a/0x90
 [<c0109430>] note_interrupt+0x70/0xb0
 [<c0109710>] do_IRQ+0x120/0x130
 [<c01079c8>] common_interrupt+0x18/0x20
 [<c011de0e>] do_softirq+0x3e/0xa0
 [<c01096eb>] do_IRQ+0xfb/0x130
 [<c01079c8>] common_interrupt+0x18/0x20
 [<d099223a>] acpi_processor_idle+0xd1/0x1c2 [processor]
 [<c0104d44>] cpu_idle+0x34/0x40
 [<c0346794>] start_kernel+0x164/0x190
 [<c03464d0>] unknown_bootoption+0x0/0x120

mobile[0]% cat /proc/interrupts 
           CPU0       
  0:    3195626          XT-PIC  timer
  1:      20498          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  Intel 82801CA-ICH3
  8:          4          XT-PIC  rtc
  9:     200000          XT-PIC  acpi
 10:          4          XT-PIC  uhci_hcd, yenta, eth1
 11:          0          XT-PIC  uhci_hcd
 12:      18366          XT-PIC  i8042
 14:       6150          XT-PIC  ide0
 15:         22          XT-PIC  ide1
NMI:          0 
LOC:    3194242 
ERR:          6
MIS:          0

Does anyone have any thoughts? Is there extra debug information I can
provide to make it easier to guess the problem? I've tried this card
on Windows, and it seems to run okay.

The card is a Corega CG-WL54GT.

Cheers,

Damien

(please copy me in on replies - I'm not on the list)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
