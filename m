From: Yazar <yazar256-Qt13gs6zZMY@public.gmane.org>
Subject: ACPI and CardBus
Date: Sat, 10 Jan 2004 01:16:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FFF444B.4060305@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello,

Here is my problem :
- with acpi enabled, the system hangs after loading the module 
yenta_socket (my keyboard is locked)
- when acpi is disabled, linux boot normaly (but I think it freeze 
approximately 5-10 min later...)
- when pcmcia is disabled, it functions perfectly with (or without) acpi.

I use linux 2.6.1 (from kernel.org).  I have patched the DSDT table, but 
it changes nothing for this problem (but it resolves an other problem ;-) ).
It was the same thing with the 2.4.xx kernels...

--------------------

lspci -v returns that (for cardbus) :

00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2750
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at e3fff000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

---------------

When I boot with pcmcia, yenta appears in irq 10
cat /proc/interrupts :

           CPU0
  0:    1201548          XT-PIC  timer
  1:       2591          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 10:      57977          XT-PIC  uhci_hcd, uhci_hcd, eth0
 11:      71814          XT-PIC  ehci_hcd, uhci_hcd, VIA8233, nvidia
 12:         41          XT-PIC  i8042
 14:       7637          XT-PIC  ide0
 15:         26          XT-PIC  ide1
NMI:          0
ERR:          0

------------------------

What can y do ??
Thank you.


PS : sorry for my english.....






-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
