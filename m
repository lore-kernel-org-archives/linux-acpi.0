From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: Waking up from S1 or S3 fails ... ide problems?
Date: Mon, 30 Jun 2003 11:59:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306301159.27819.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hi!

Again, my Compaq Armada M700 ... with 2.5.73 kernel.

Computer enetrs the sleep state(s) ok (no visible errors), but id doesn't 
wakeup (batery led blinks several times - and powers off)!

After commenting out the "acpi_hw_disable_non_wakeup_gpes" and  
"acpi_hw_enable_non_wakeup_gpes", laptop sucessufuly wakes up, BUT after few 
seconds everything blocks. 
NOTE: i saw somewhere here that somebody already compalined about that - it 
seems that only EVENT trigered methods (GPE) get "wakeup" flags, all others 
just get disabled ... but some bioses ignore this and keep working ... or?!?

Keyboard is not responding. This is "bare" kernel, so there is only what needs 
to be to boot it (no network, usb, sound etc.).

Serial port seems to be working a little longer, but becomes unusable because 
ide hangs.

Can this be dsdt bug? XP is working ok ...

Any help would be appreciated .... :-)


Here is whats happening:

sh-2.05b# echo 1 > /proc/acpi/sleep
Stopping tasks: init entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=kseriod entered refrigerator
=exiting...exiting...kjournald entered refrigerator
=init entered refrigerator
=|
Suspending devices
Suspending devices
hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
Suspending devices
Execute Method: [\_PTS] (Node c12cf6a8)
[ACPI Debug] String: _PTS:  Enter
[ACPI Debug] Integer: 0000000000000001
[ACPI Debug] String: Going into Suspend to RAM State
[ACPI Debug] String: _PTS:  Exit
 hwsleep-0259 [17] acpi_enter_sleep_state: Entering sleep state [S1]

[here computer power is in sleep state ... waking up whith sleep or power 
button]

Back to C!
Execute Method: [\_WAK] (Node c12cf5e8)
[ACPI Debug] String: _WAK:  Enter
[ACPI Debug] Integer: 0000000000000001
[ACPI Debug] String: _WAK:  Exit
Devices Resumed
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue c03e69dc, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
hdb: completing PM request, resume
Devices Resumed
Restarting tasks... done
pdflush left refrigerator
init left refrigerator
pdflush left refrigerator
kswapd0 left refrigerator
kseriod left refrigerator
kjournald left refrigerator
init left refrigerator
sh-2.05b# 
sh-2.05b# 
sh-2.05b# cat /proc/interrupts 
           CPU0       
  0:     119479          XT-PIC  timer
  1:         12          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:        701          XT-PIC  serial
  8:          1          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 12:         61          XT-PIC  i8042
 14:        943          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
sh-2.05b# cat /proc/interrupts 
           CPU0       
  0:     120458          XT-PIC  timer
  1:         12          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:        733          XT-PIC  serial
  8:          1          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 12:         61          XT-PIC  i8042
 14:        943          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
sh-2.05b# cat /proc/interrupts 

hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff
hda: dma_timer_expiry: dma status == 0xff

[... to eternity and beyond ...]

Hrvoje

p.s. http://free-zg.htnet.hr/HrvojeHabjanic/acpi/Compaq_Armada_M700



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
