From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: xHCI Express Card failure -- ACPI related?
Date: Tue, 22 Feb 2011 16:55:13 -0800
Message-ID: <20110223005513.GA2503@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I'm having an issue with an xHCI (USB 3.0 host controller) Express Card.
This card works fine on 2.6.37, but on 2.6.38-rc5, when I plug in the
card, I get this output in dmesg:

Feb 22 16:32:28 xanatos kernel: [  119.345996] irq 23: nobody cared (try booting with the "irqpoll" option)
Feb 22 16:32:28 xanatos kernel: [  119.346002] Pid: 0, comm: kworker/0:0 Not tainted 2.6.38-rc5+ #745
Feb 22 16:32:28 xanatos kernel: [  119.346005] Call Trace:
Feb 22 16:32:28 xanatos kernel: [  119.346007]  <IRQ>  [<ffffffff8109a1f6>] ? __report_bad_irq+0x26/0xa0
Feb 22 16:32:28 xanatos kernel: [  119.346019]  [<ffffffff8109a3fc>] ? note_interrupt+0x18c/0x1d0
Feb 22 16:32:28 xanatos kernel: [  119.346024]  [<ffffffff8109ad7d>] ? handle_fasteoi_irq+0xcd/0x100
Feb 22 16:32:28 xanatos kernel: [  119.346029]  [<ffffffff8100543d>] ? handle_irq+0x1d/0x30
Feb 22 16:32:28 xanatos kernel: [  119.346032]  [<ffffffff81004bb8>] ? do_IRQ+0x58/0xd0
Feb 22 16:32:28 xanatos kernel: [  119.346037]  [<ffffffff8149f5d3>] ? ret_from_intr+0x0/0xe
Feb 22 16:32:28 xanatos kernel: [  119.346040]  <EOI>  [<ffffffff8126f2d0>] ? acpi_idle_enter_c1+0x7e/0x99
Feb 22 16:32:28 xanatos kernel: [  119.346048]  [<ffffffff8126f2b2>] ? acpi_idle_enter_c1+0x60/0x99
Feb 22 16:32:28 xanatos kernel: [  119.346054]  [<ffffffff8138ac92>] ? cpuidle_idle_call+0x82/0xf0
Feb 22 16:32:28 xanatos kernel: [  119.346059]  [<ffffffff81001906>] ? cpu_idle+0x56/0xb0
Feb 22 16:32:28 xanatos kernel: [  119.346064]  [<ffffffff8149861b>] ? start_secondary+0x1c1/0x1c8
Feb 22 16:32:28 xanatos kernel: [  119.346068]  [<ffffffff81263386>] ? acpi_ns_parse_table+0x2e/0x34
Feb 22 16:32:28 xanatos kernel: [  119.346073]  [<ffffffff81267a8c>] ? acpi_load_tables+0x9c/0x15d
Feb 22 16:32:28 xanatos kernel: [  119.346076] handlers:
Feb 22 16:32:28 xanatos kernel: [  119.346078] [<ffffffffa0123500>] (usb_hcd_irq+0x0/0x70 [usbcore])
Feb 22 16:32:28 xanatos kernel: [  119.346100] Disabling IRQ #23

I haven't had a chance to bisect yet.

Given that there wasn't any big new features added to the xHCI driver in
2.6.38, I don't think my code is the culprit here.  Could it be a USB
core or ACPI issue?

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
