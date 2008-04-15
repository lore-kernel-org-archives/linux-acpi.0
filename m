From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 10455] New: Kernel lockup when iwl3945 modules is loaded after a few hours
Date: Tue, 15 Apr 2008 09:15:55 -0600
Message-ID: <200804150915.56235.bjorn.helgaas@hp.com>
References: <bug-10455-10286@http.bugzilla.kernel.org/> <e2e108260804150139kf816be5m91e6206853a0d755@mail.gmail.com> <20080415020103.cd8e17f4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080415020103.cd8e17f4.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Bart Van Assche <bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > >  > Apr 14 21:06:00 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19 (level, low) -> IRQ 19
> > >  > Apr 14 21:06:00 localhost kernel: ACPI: PCI interrupt for device 0000:05:00.0 disabled
> > >
> > >  Yes, that does look like an ACPI problem.  But one would expect it to kill
> > >  the interface immediately, not several hours later.

I can't tell whether this is an ACPI problem.  These messages are from
pci_enable_device() and pci_disable_device().  So it looks like you're
seeing an enable/disable pair every 124 seconds.

This could be a problem somewhere in iwl3945_mac_start() that causes us
to turn around and disable the device immediately.  Most of the problems
there have IWL_ERROR() messages associated with them, and you apparently
aren't seeing those.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
