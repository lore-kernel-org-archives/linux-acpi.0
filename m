From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
Date: Sun, 15 Jan 2006 22:22:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601152212340.1929-100000@netrider.rowland.org>
References: <43CAD1BB.60301@reub.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43CAD1BB.60301-MwA23MxOyI4@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Reuben Farrelly <reuben-lkml-MwA23MxOyI4@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 16 Jan 2006, Reuben Farrelly wrote:

> On 13/01/2006 4:53 a.m., Alan Stern wrote:
> > On Thu, 12 Jan 2006, Reuben Farrelly wrote:
> > 
> >>>> Initializing USB Mass Storage driver...
> >>>> irq 193: nobody cared (try booting with the "irqpoll" option)
> > 
> >>>> handlers:
> >>>> [<c027017e>] (usb_hcd_irq+0x0/0x56)
> >>>> Disabling IRQ #193
> >>> USB lost its interrupt.  Could be USB, more likely ACPI.
> >> I've seen this one happen nearly every boot since then including bootups that 
> >> are otherwise OK (no oopses), so it's probably worth more looking into rather 
> >> than being written off as a 'once off':
> >>
> >> uhci_hcd 0000:00:1d.3: Unlink after no-IRQ?  Controller is probably using the 
> >> wrong IRQ.

Note the PCI ID is 1d.3 and the IRQ is 193.

> Hi Alan,
> 
> If it's any use, here's some simply and easy-to-get information which may even 
> be what you are looking for:
> 
> [root@tornado dovecot]# uname -a
> Linux tornado.reub.net 2.6.15-mm1 #1 SMP Sun Jan 8 03:42:25 NZDT 2006 i686 i686 
> i386 GNU/Linux
> [root@tornado ~]# cat /proc/interrupts
>             CPU0       CPU1
>    0:   21638510          0    IO-APIC-edge  timer
>    4:        356          0    IO-APIC-edge  serial
>    8:          1          0    IO-APIC-edge  rtc
>    9:          0          0   IO-APIC-level  acpi
>   14:          1          0    IO-APIC-edge  ide0
>   50:          3          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
> 169:        120          0   IO-APIC-level  uhci_hcd:usb5
> 177:    2837992          0   IO-APIC-level  sky2
> 185:      61450          0   IO-APIC-level  uhci_hcd:usb4, serial
> 193:    4722447          0   IO-APIC-level  libata, uhci_hcd:usb3

Note that in the earlier kernel, IRQ 193 is assigned to usb3.  That's the 
second UHCI controller, since usb1 is EHCI.

> [root@tornado ~]# lspci

> 00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #1 (rev 03)
> 00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #2 (rev 03)
> 00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #3 (rev 03)
> 00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #4 (rev 03)
> 00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB2 EHCI Controller (rev 03)

Note that 1d.3 is the fourth UHCI controller; the second is 1d.1.

> I guess this looks like it was assigned the same IRQ ?

I don't think so.  To be certain you'd have to check the boot-up log and
verify that 1d.1 is usb3 and 1d.3 is usb5.

>From the information presented here, it looks like -mm1 correctly routes
the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
-mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
it an ACPI problem.

Alan Stern

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
