From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: "noht" (RE: ACPI patches updated (20030714))
Date: Fri, 18 Jul 2003 06:04:17 +0100 (BST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0307180551060.1319-100000@localhost.localdomain>
References: <A5974D8E5F98D511BB910002A50A66470B981269@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981269-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'ACPI-Devel mailing list' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Marcelo Tosatti' <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 17 Jul 2003, Brown, Len wrote:
> "noht" turns out to be tricky for ACPI in practice.

Thanks a lot for looking into it, Len.
Nice to know I wasn't being too silly when I said it's beyond me now.

> ACPI really shouldn't tinker with or skip LAPIC enumeration.  It can't rely
> on the table LAPIC ids to get packge numbers, and it can't rely on the BIOS
> to have MPS implemented to enumerate physical processors.
> 
> The only reliable way to get the logical/physical mapping is the way
> init_intel() does it today -- run CPUID locally on that logical processor
> after it is up and running.
> 
> So if the kernel is to disable HT, the proper way would be to initialize all
> the logical processors, have them identify themselves, and then optionally
> take themselves off-line.  A possiblity for 2.6.

Yes, a possibility.  But I doubt it'll be worth bothering.

> BIOS SETUP remains the preferred way to disable HT.  If the hardware is
> implemented such that duplicated resources could be combined when HT is
> disabled, only the BIOS would be able to do that -- so single threaded
> performance with Linux implemented 'noht' might lag performance with BIOS
> implemented 'noht'...
> 
> Given that 'noht' is workaround for a missing BIOS switch, I'm not confident
> it is a win to burden the Linux kernel with it.

I imagine we could still retain it when going the acpitable.c route;
but I'd prefer to be consistent across the ways, and just remove all
traces of "noht" now (a boot option to mask off the "ht" flag from
cpuinfo, its current role, is definitely not worth retaining).

Hugh
