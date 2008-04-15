From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 10455] New: Kernel lockup when iwl3945 modules
 is loaded after a few hours
Date: Tue, 15 Apr 2008 02:01:03 -0700
Message-ID: <20080415020103.cd8e17f4.akpm@linux-foundation.org>
References: <bug-10455-10286@http.bugzilla.kernel.org/>
	<20080415013251.e90e5abd.akpm@linux-foundation.org>
	<e2e108260804150139kf816be5m91e6206853a0d755@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e2e108260804150139kf816be5m91e6206853a0d755-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bart Van Assche <bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Apr 2008 10:39:17 +0200 "Bart Van Assche" <bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, Apr 15, 2008 at 10:32 AM, Andrew Morton
> <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
> >
> >  > Latest working kernel version: (not known)
> >  > Earliest failing kernel version: 2.6.25-rc9
> >
> >  hm, why?  Has this machine never run earlier kernels?
> 
> 2.6.22-14 works fine on the same hardware. This is the kernel provided
> by Ubuntu.

OK, thanks, so it's a regression but we don't know if it's a post-2.6.25
regression.

> >  > Apr 14 21:06:00 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> >  > (level, low) -> IRQ 19
> >  > Apr 14 21:06:00 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> >  > disabled
> >
> >  Yes, that does look like an ACPI problem.  But one would expect it to kill
> >  the interface immediately, not several hours later.
> >
> >  Can you send the /proc/interrupts contents?
> 
> Here it is:
> 
>            CPU0       CPU1
>   0:     996478          0   IO-APIC-edge      timer
>   1:         30          0   IO-APIC-edge      i8042
>   8:          7          0   IO-APIC-edge      rtc
>   9:      57710          0   IO-APIC-fasteoi   acpi
>  12:        132          0   IO-APIC-edge      i8042
>  14:      31294      11519   IO-APIC-edge      ata_piix
>  15:      69158          0   IO-APIC-edge      ata_piix
>  16:      85016          0   IO-APIC-fasteoi   uhci_hcd:usb4,
> i915@pci:0000:00:02.0
>  18:      15921          0   IO-APIC-fasteoi   uhci_hcd:usb3
>  19:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
>  21:      79770      60509   IO-APIC-fasteoi   eth0
>  22:       5811          0   IO-APIC-fasteoi   HDA Intel
>  23:          3          0   IO-APIC-fasteoi   uhci_hcd:usb1, ehci_hcd:usb5
> NMI:          0          0   Non-maskable interrupts
> LOC:        509     996926   Local timer interrupts
> RES:      29774      84400   Rescheduling interrupts
> CAL:         62      28154   function call interrupts
> TLB:        868       1262   TLB shootdowns
> TRM:          0          0   Thermal event interrupts
> SPU:          0          0   Spurious interrupts
> ERR:          0
> MIS:          0

hm, OK.

I'd suggest that you raise a separate report against
acpi_config-interrupts-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org for this one - it does appear
to be unrelated, I think.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
