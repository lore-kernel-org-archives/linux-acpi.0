From: Franklin Marmon <marmon-GymH4r+vMzPQT0dZR+AlfA@public.gmane.org>
Subject: ACPI PCI-IRQ Problem
Date: Wed, 28 Apr 2004 08:58:43 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1083164323.3003.14.camel@laptop.hydeco.com>
Reply-To: marmon-GymH4r+vMzPQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

I apologize if this is covered in the archive someplace, but I've
searched it for over 3 hours now and still haven't found the answer, so
here goes:

The short and skinny:

System:		linux-2.6.5 (release), no patches.  Phoenix Bios
		AMD-x86-64 processor, running FC-1 (standard, not
		the 64bit version).

Problem:	When I boot without the "pci=noacpi" kernel option my ethernet
card, and sound controller are assigned valid, but incorrect, irqs.  

Question:	Is there a way to tell acpi which irqs belong to which
devices?  

I'm fairly new to kernel level code, so please bare with me if I'm way
off base.  I'm willing to compile a new DSDT into my kernel if need be. 
I'm not entirely sure _how_ to do this, but as I understand it I can
pull the tables off my laptop using a utility available from Phoenix's
website, and from there, with a finger in the right direction, could
probably write a new DSDT to work with my laptop.


Details:

###############################################################################
#
# static elements
 
#
# lspci -v
#
 
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 74)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded
	Ethernet Controller on VT8235
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1800 [size=256]
        Memory at d0002c00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>
 
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: Unknown device 161f:2032
        Flags: medium devsel, IRQ 10
        I/O ports at 1000 [size=256]
        Capabilities: <available only to root>

###############################################################################
#
# normal operation
#   kernel parameters include pci=noacpi
#
 
 
#
# /var/log/messages
#
 
pci=noacpi
  Apr 27 08:03:16 laptop kernel: PCI: Sharing IRQ 9 with 0000:00:12.0
 
 
#
# cat /proc/interupts
#
           CPU0
  0:     102200          XT-PIC  timer
  1:        146          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:       2712          XT-PIC  uhci_hcd, eth0
 10:        178          XT-PIC  acpi, uhci_hcd, VIA8233
 11:          0          XT-PIC  uhci_hcd
 12:        588          XT-PIC  i8042
 14:       8752          XT-PIC  ide0
 15:        964          XT-PIC  ide1
NMI:          0
ERR:          0
 
 
 
###############################################################################
#
# next step, removed pci=noacpi from the kernel parameters
#
 
 
#
# errors which occurred when bringing up my ethernet interface (shown
above)
# when booted without pci=noacpi
#
 
eth0: Setting full-duplex based on MII #1 link partner capability of
45e1.
irq 9: nobody cared!
Call Trace:
 [<c010bb2a>] __report_bad_irq+0x2a/0x90
 [<c010bc1c>] note_interrupt+0x6c/0xb0
 [<c010c1a9>] do_IRQ+0x259/0x340
 [<c010c0de>] do_IRQ+0x18e/0x340
 [<c010a158>] common_interrupt+0x18/0x20
 [<c0210e1a>] acpi_processor_idle+0xd5/0x1c7
 [<c01070bc>] cpu_idle+0x2c/0x40
 [<c03c6701>] start_kernel+0x181/0x1c0
 [<c03c6430>] unknown_bootoption+0x0/0x120
  
handlers:
[<e0aad630>] (usb_hcd_irq+0x0/0x70 [usbcore])
[<e0958780>] (snd_via82xx_interrupt+0x0/0x400 [snd_via82xx])
Disabling IRQ #9
 
#
# lspci -v is identical to the one above
#
 
#
# cat /proc/interupts
#
           CPU0
  0:     323327          XT-PIC  timer
  1:       1223          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:     100000          XT-PIC  uhci_hcd, VIA8233
 10:       1227          XT-PIC  acpi, uhci_hcd
 11:          0          XT-PIC  uhci_hcd, eth0
 12:      25710          XT-PIC  i8042
 14:       7832          XT-PIC  ide0
 15:       5416          XT-PIC  ide1
NMI:          0
ERR:          0
 






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
