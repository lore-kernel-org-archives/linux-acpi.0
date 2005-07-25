From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: More experiences with 2.6.13-rc3 with ec_polling patch
Date: Mon, 25 Jul 2005 10:40:44 +0200
Message-ID: <20050725084044.GA22944@tangens.sinus.cz>
References: <20050723133726.GA2079@miro.sinus.cz> <20050724142432.GC1778@elf.ucw.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050724142432.GC1778-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hi!
> 
> > 5) After resume from S4:
> > 
> > irq 10: nobody cared (try booting with the "irqpoll" option)
> >  [<c01412aa>] __report_bad_irq+0x2a/0xa0
> >  [<c0140a50>] handle_IRQ_event+0x30/0x70
> >  [<c01413c0>] note_interrupt+0x80/0xf0
> >  [<c0140bc4>] __do_IRQ+0x134/0x140
> >  [<c0105f73>] do_IRQ+0x23/0x40
> >  [<c0103f16>] common_interrupt+0x1a/0x20
> >  [<c0124773>] __do_softirq+0x43/0xb0
> >  [<c012480d>] do_softirq+0x2d/0x30
> >  [<c01248e7>] irq_exit+0x37/0x40
> >  [<c0105f78>] do_IRQ+0x28/0x40
> >  [<c0103f16>] common_interrupt+0x1a/0x20
> >  [<c039f360>] schedule+0x0/0x650
> >  [<c039fa63>] preempt_schedule_irq+0x43/0x80
> >  [<c010349e>] need_resched+0x1f/0x21
> >  [<c013ee20>] swsusp_suspend+0x50/0xc0
> >  [<c013faac>] pm_suspend_disk+0x3c/0x90
> >  [<c013d86c>] enter_state+0x6c/0x70
> >  [<c013d87f>] software_suspend+0xf/0x20
> >  [<c0247322>] acpi_system_write_sleep+0x6a/0x84
> >  [<c0162716>] vfs_write+0xb6/0x180
> >  [<c01628b1>] sys_write+0x51/0x80
> >  [<c0103559>] syscall_call+0x7/0xb
> > handlers:
> > [<dc86e850>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
> > Disabling IRQ #10
> > 
> > ...and then
> > 
> > ohci_hcd 0000:00:02.3: Unlink after no-IRQ?  Controller is probably
> > using the wrong IRQ.
> 
> Okay, can you enable debugging in .../usb/core/hcd-pci.c and see what
> happens? It seems to call request_irq in resume routine, add printk to
> verify that it really does call it.
> 
Hi Pavel,
  I'm afraid that You're not getting the exact point:
  1) Before S4 is called (4 written to /proc/acpi/sleep), ohci_hcd module is
fully unloaded.
  2) The problem with "nobody cared" is detected during the wake up phase,
even before the suspend/resume script wakes up and tries to reinsert the
module. You can see that just the sound card handler is hooked to the irq.
  3) After a relatively long time (during which the resume script is awaken
and starts to insert various modules (mouse, modem, irda, bluetooth... which
were unloaded during suspend to prevent problems), this ohci_hcd tries to
be inserted, finds the non-functional interrupt and makes problems. Maybe
there is a bug in it, but it is triggered by another problem with that irq,
happening just in -rc3.
  Sorry that my initial explanation wasn't clear enough.
                                      Regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
