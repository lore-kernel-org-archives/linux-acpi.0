From: Daniele Venzano <webvenza-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: Re: [ACPI] Invalid PBLK length for athlon XP-M on Asus laptop
Date: Sat, 23 Aug 2003 22:02:20 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030823200220.GA914@renditai.milesteg.arr>
References: <20030823125812.GC913@renditai.milesteg.arr> <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030823173423.GQ18834-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 23, 2003 at 06:34:23PM +0100, Matthew Wilcox wrote:
> > [.....]
> > ACPI: Fan [FAN0] (on)
> > acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]
> 
> This is a bug in your ACPI bios, you need a vendor update.  We tried
> fixing this but it broke a number of laptops, so we had to revert it.

I already have the latest bios according to Asus site. 
I sent a complain to Asus support, we'll see...

Those fixes can still be found somewhere ? I'd like to play with them.

> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > acpi_processor_perf-0104 [28] acpi_processor_get_per: Unsupported address space [127] (control_register)
> > cpufreq: No CPUs supporting ACPI performance management found.
> 
> That means that you need a non-acpi driver for perf throttling.  Did you
> try enabling some of the other cpufreq drivers?

I tried with the P-state driver compiled in with the Athlon driver, or
only with the Athlon driver without P-state. The result is the same,
when I try to set a governor through sysfs the system freezes and a
hard reset is required.
However without P-state driver the above message disappers.

So I'm getting neither scaling or throttling... it's not much a surprise
that the battery was discharging at that rate...

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/
