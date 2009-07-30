From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 10:33:13 +0800
Message-ID: <20090730023313.GA27493@sli10-desk.sh.intel.com>
References: <20090730020623.GB26389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090730020623.GB26389-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 30, 2009 at 10:06:23AM +0800, Matthew Garrett wrote:
> I've been playing with putting host controllers into D3 when the root
> hub is suspended, with a certain amount of success. My current
> implementation simply calls the suspend and resume functions in the HCD
> device's pm struct on bus_suspend and bus_resume. It's also necessary to
> flag the ACPI GPEs for the HCDs as runtime and enabled in order to get
> wakeup events. This is good enough for already plugged devices to work,
> and running lsusb powers up any idle ports and notices that devices have
> been plugged in. I also get an event when devices are unplugged.
> 
> This is obviously not entirely ideal, for a couple of reasons.
> 
> The first is that UHCI works perfectly providing I provide a remote
> wakeup. An SCI is fired via ACPI, a notification is sent to the
> appropriate device and we resume it quite happily. Unplugs also trigger
> the ACPI event. However, plugging in doesn't generate any kind of wakeup
> event, even though port0en and port1n are set in USB_RES. Is there any
> way to get UHCI to do this? I'm guessing that the power is being cut to
> the port when it suspends with no device connected.
> 
> The second is that EHCI generates a PME# notification on device plugin.
> This triggers an SCI and the PME# notification shows up as a GPE event.
> This causes the kernel to evaluate _L0D. On this Dell, that looks
> something like this:
> 
> _L0D {
>         SMI(foo, Local0)
>         if (Local0 & 0x1)
>                 Notify(some hardware)
>         if (Local0 & 0x2)
>                 Notify(EHCI)
>         if (Local0 & 0x4)
>                 Notify(EHCI 2)
> }
There are patches to support both ACPI based wakeup event and PCIe native
wakeup event in below bugzilla, but it never gets into upstream. One problem
is how to check which device under a bridge generates a wakeup event, because
pci devices can share a wakeup event.
There are discussion in pm list about the patches too, please search.

http://bugzilla.kernel.org/show_bug.cgi?id=6892

Thanks,
Shaohua
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
