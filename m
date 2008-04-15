From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 10455] New: Kernel lockup when iwl3945 modules
 is loaded after a few hours
Date: Tue, 15 Apr 2008 01:32:51 -0700
Message-ID: <20080415013251.e90e5abd.akpm@linux-foundation.org>
References: <bug-10455-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bug-10455-10286-V0hAGp6uBxO456/isadD/XN4h3HLQggn@public.gmane.org/>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 15 Apr 2008 01:16:39 -0700 (PDT) bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10455
> 
>            Summary: Kernel lockup when iwl3945 modules is loaded after a few
>                     hours
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.25-rc9
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: network-wireless
>         AssignedTo: drivers_network-wireless-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
>         ReportedBy: bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> 
> 
> Latest working kernel version: (not known)
> Earliest failing kernel version: 2.6.25-rc9

hm, why?  Has this machine never run earlier kernels?

> Distribution: Ubuntu Linux 7.10
> Hardware Environment: Acer Aspire laptop model 5633WLMi
> Software Environment: Ubuntu Linux 7.10, 32 bit mode.
> Problem Description: When the iwl3945 module is loaded, the kernel locks up
> after a few hours. This problem does not occur when the iwl3945 module is not
> loaded.
> 
> Steps to reproduce: Boot the system.
> 
> The following kernel messages look suspicious:
> 
> Apr 14 20:16:24 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:16:24 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:18:28 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:18:28 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:20:32 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:20:32 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:22:36 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:22:36 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:24:40 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:24:40 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:26:44 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:26:44 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:28:48 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:28:48 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:30:52 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:30:52 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:32:56 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:32:56 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:35:00 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:35:00 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:37:04 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:37:04 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:39:08 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:39:08 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:41:12 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:41:12 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:43:16 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:43:16 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:45:20 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:45:20 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:47:24 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:47:24 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:49:28 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:49:28 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:51:32 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:51:32 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:53:36 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:53:36 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:55:40 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:55:40 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:57:44 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:57:44 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 20:59:48 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 20:59:48 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 21:01:52 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 21:01:52 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 21:03:56 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 21:03:56 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled
> Apr 14 21:06:00 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Apr 14 21:06:00 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0
> disabled

Yes, that does look like an ACPI problem.  But one would expect it to kill
the interface immediately, not several hours later.

Can you send the /proc/interrupts contents?

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
