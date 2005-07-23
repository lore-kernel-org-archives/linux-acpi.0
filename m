From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: More experiences with 2.6.13-rc3 with ec_polling patch
Date: Sat, 23 Jul 2005 15:37:27 +0200
Message-ID: <20050723133726.GA2079@miro.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi!
  I've applied the ec-polling patch and tried 2.6.13-rc3 (with ec_polling
option) again. However, there were more problems with it, so I'm again on -rc2.
I just remember that it's a CLEVO D610SU Notebook (P4/2G4/512M RAM).
The main symptoms were as follows:

0) Battery status and thermal zone are working OK. Fine.

1) When trying S3 by closing the lid, I found that my script doesn't work
because it cannot find /proc/acpi/button/lid/LID/state, where it reads the
switch status (it's a safety measure, because my lid switch sometimes generates
spurious events, probably it's very sensitive and reacts to machine vibrations,
so the script verifies here that the lid is really closed).
I didn't find any replacement of this file in /proc/acpi/hotkey. How the status
can be obtained now ?
  So I activated S3 sleep manually.

2) During S3, S4 sleeping process a new message, not present in -rc2, appeared:

acpi_bus-0212 [535] acpi_bus_set_power    : Device is not power manageable
I don't know whether it is important or not.

And now, the more serious problems:

3) After resume from S3, pwr/lid switches didn't work (didn't generate events).

4) I called S4 sleep script manually. After the obvious procedure, the machine
   turned itself off. However, after pressing the power switch it started, 
   showed the BIOS screen and then crashed (even LILO screen didn't appear).
   I had to cycle the power again and it started OK then.

5) After resume from S4:

irq 10: nobody cared (try booting with the "irqpoll" option)
 [<c01412aa>] __report_bad_irq+0x2a/0xa0
 [<c0140a50>] handle_IRQ_event+0x30/0x70
 [<c01413c0>] note_interrupt+0x80/0xf0
 [<c0140bc4>] __do_IRQ+0x134/0x140
 [<c0105f73>] do_IRQ+0x23/0x40
 [<c0103f16>] common_interrupt+0x1a/0x20
 [<c0124773>] __do_softirq+0x43/0xb0
 [<c012480d>] do_softirq+0x2d/0x30
 [<c01248e7>] irq_exit+0x37/0x40
 [<c0105f78>] do_IRQ+0x28/0x40
 [<c0103f16>] common_interrupt+0x1a/0x20
 [<c039f360>] schedule+0x0/0x650
 [<c039fa63>] preempt_schedule_irq+0x43/0x80
 [<c010349e>] need_resched+0x1f/0x21
 [<c013ee20>] swsusp_suspend+0x50/0xc0
 [<c013faac>] pm_suspend_disk+0x3c/0x90
 [<c013d86c>] enter_state+0x6c/0x70
 [<c013d87f>] software_suspend+0xf/0x20
 [<c0247322>] acpi_system_write_sleep+0x6a/0x84
 [<c0162716>] vfs_write+0xb6/0x180
 [<c01628b1>] sys_write+0x51/0x80
 [<c0103559>] syscall_call+0x7/0xb
handlers:
[<dc86e850>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
Disabling IRQ #10

...and then

ohci_hcd 0000:00:02.3: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.

... and modprobe hci_usb didn't return.
/proc/interrupts shows

 10:     200000          XT-PIC  SiS SI7012, ohci_hcd:usb2

IRQ 10 is shared for sound card and USB. Neither of them worked after wake-up.

Neither of the problems reported is present in -rc2.
                                       With regards,
				              Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
