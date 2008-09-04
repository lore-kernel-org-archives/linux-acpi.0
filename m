From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI (atlas_btns) locks my box for minutes
Date: Thu, 04 Sep 2008 17:36:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
References: <200809041300.20141.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:34981 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbYIDVgo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 17:36:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K6O000NKXCF55R1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 04 Sep 2008 16:36:16 -0500 (CDT)
In-reply-to: <200809041300.20141.hs4233@mail.mn-solutions.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: linux-acpi@vger.kernel.org, Jaya Kumar <jayakumar.acpi@gmail.com>, Dmitry Torokhov <dtor@mail.ru>



On Thu, 4 Sep 2008, Holger Schurig wrote:

> Hi people !
> 
> On 2.6.26.3 I'm using ACPI and the Atlas driver
> (drivers/input/misc/atlas_btns.c), which uses the ASIM0000 acpi
> device.
> 
> Most of the time this works great. That is, I can press 20
> or 50 times the button and it always works, I always get a
> scan-code report via the input subsystem.
> 
> However, occossianelly my box hangs. It's a hard lock, e.g.
> the blinking cursor in X won't work, the keyboard won't work. The
> box is just completely locked up for a period of time. Eventually
> it recovers. When I now look at "dmesg", I see this:

Does the hang and interrupt storm only happen
upon pressing the button?
(ie. it does not happen if you do not press the button,
 and it does not happen if atlas_btns is not loaded)

thanks,
-Len

> ##HS acpi_atlas_button_handler()
> ##HS acpi_atlas_button_handler()
> ##HS acpi_atlas_button_handler()
> ##HS acpi_atlas_button_handler()
> irq 9: nobody cared (try booting with the "irqpoll" option)
> Pid: 0, comm: swapper Tainted: P          2.6.26.3 #12
>  [<c012f063>] __report_bad_irq+0x24/0x69
>  [<c012f06a>] __report_bad_irq+0x2b/0x69
>  [<c012f257>] note_interrupt+0x1af/0x1e4
>  [<c01cbc97>] acpi_irq+0xb/0x1c
>  [<c012e983>] handle_IRQ_event+0x1a/0x3f
>  [<c012f917>] handle_level_irq+0x63/0x84
>  [<c01046d0>] do_IRQ+0x4b/0x60
>  [<c010320f>] common_interrupt+0x23/0x28
>  [<c01d007b>] acpi_ds_init_aml_walk+0xb2/0xfe
>  [<c0118f03>] __do_softirq+0x2c/0x75
>  [<c0118f6e>] do_softirq+0x22/0x26
>  [<c01191ea>] irq_exit+0x25/0x53
>  [<c01046d5>] do_IRQ+0x50/0x60
>  [<c010320f>] common_interrupt+0x23/0x28
>  [<c01e90a7>] acpi_idle_enter_simple+0x16d/0x1da
>  [<c02553f6>] cpuidle_idle_call+0x49/0x77
>  [<c02553ad>] cpuidle_idle_call+0x0/0x77
>  [<c010176c>] cpu_idle+0x48/0x61
>  =======================
> handlers:
> [<c01cbc8c>] (acpi_irq+0x0/0x1c)
> Disabling IRQ #9
> BUG: soft lockup - CPU#0 stuck for 136s! [events/0:5]
> Modules linked in: wlan_wep wlan_scan_sta ath_rate_sample ath_pci wlan ath_hal(P)
> 
> 
> IRQ 9 is, of course, the ACPI interrupt. This is the state after
> the lock-up-and-recoverage:
> 
> # cat /proc/interrupts
>            CPU0
>   0:      51339    XT-PIC-XT        timer
>   2:          0    XT-PIC-XT        cascade
>   4:        606    XT-PIC-XT        serial
>   5:       2012    XT-PIC-XT        serial
>   7:          3    XT-PIC-XT
>   9:     200000    XT-PIC-XT        acpi
>  10:          0    XT-PIC-XT        yenta, yenta
>  11:       6252    XT-PIC-XT        ehci_hcd:usb1, ohci_hcd:usb2, CS5535 Audio, wifi0
>  14:      88924    XT-PIC-XT        ide0
>  15:          0    XT-PIC-XT        ide1
> NMI:          0   Non-maskable interrupts
> LOC:          0   Local timer interrupts
> TRM:          0   Thermal event interrupts
> SPU:          0   Spurious interrupts
> ERR:          1
> MIS:          0
> 
> Note the extraordinary high interrupt number of IRQ 9 !  This
> does not happen before this error triggers:
> 
> # grep 9: /proc/interrupts
>   9:          2    XT-PIC-XT        acpi
> ---> now I press one ACPI button <---
> # grep 9: /proc/interrupts
>   9:          4    XT-PIC-XT        acpi
> 
> 
> Any hint about resolving this issue?
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
