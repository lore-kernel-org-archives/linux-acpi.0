From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Interrupt routing problem
Date: Sun, 04 Jan 2004 17:43:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073234635.985.6.camel@localhost>
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
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!
I think my current ACPI enabled 2.4.23 kernel is doing something IMHO
not so clever concerning interrupt routing:

           CPU0       
  0:      57158          XT-PIC  timer
  1:       2339          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       2707          XT-PIC  usb-uhci, Ricoh Co Ltd RL5c476 II
  7:          3          XT-PIC  parport0
  8:     194573          XT-PIC  rtc
  9:      12214          XT-PIC  acpi, ohci1394, usb-uhci, eth0, Texas
Instruments PCI1410 PC card Cardbus Controller, orinoco_cs
 11:      61791          XT-PIC  Ricoh Co Ltd RL5c476 II (#2), Intel
ICH3
 12:        134          XT-PIC  PS/2 Mouse
 14:      38295          XT-PIC  ide0
 15:       6607          XT-PIC  ide1

As you can see most devices are routed through IRQ9. I even think that
this is not only ugly but even causes problems. For example I see
strange phenomenons concerning USB with this setup, i.e. devices
suddenly getting disconnected and reconnected again, HUBs beeing
disabled altogether, ports being disabled and so on; and yes, using uhci
instead of usb-uhci does not help any.

So my question is if I can "help" my kernel somehow to distribute the
IRQs in a more clever way.
I can remember that there were some kernel commandline options about
ACPI and PCI interrupt routing (like pci=noacpi or acpi=nopci). Are
those still valid? Would they help?

Oh, BTW, setup summary
	Linux kernel 2.4.23 + swsusp
running on
	Asus notebook L3800C, latest BIOS V1.21

Thanks in advance!
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
