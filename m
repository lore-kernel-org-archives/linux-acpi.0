From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BK PATCH] acpismp=force fix
Date: Thu, 26 Jun 2003 14:37:11 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I think there should be a boot-option to use ACPI for boot-time
configuration tables, but to not load the driver for run-time event
handling.  This is useful for enabling HT on systems with broken ACPI
run-time BIOS.

UnitedLinux uses "acpi=oldboot" for this.  While 'old' will become ambiguous
when today's "new" becomes tomorrow's "old";-), I do like "acpi={something}"
rather than complicating matters with non "acpi=" syntax.

Re: "acpismp=force"
I wouldn't miss it.  Sounds unanimous.

Re: "noht"
To disable HT on a uni-processor, wouldn't it be preferable to simply run
the UP kernel rather than the SMP kernel with HT disabled?  That leaves SMP
systems, where either the BIOS could disable it (it is a BIOS bug if it
can't), or as a last resort CONFIG_X86_HT (2.5) could be config'd out of the
kernel.  I guess I've talked myself into not missing "noht" also.

Cheers,
-Len

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org] 
> Sent: Monday, June 23, 2003 7:54 AM
> To: Hugh Dickins
> Cc: Grover, Andrew; Arjan van de Ven; Andrew Morton; 
> torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org; acpi-devel@lists.sourceforge.net; 
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [BK PATCH] acpismp=force fix
> 
> 
> On Mon, Jun 23, 2003 at 12:46:38PM +0100, Hugh Dickins wrote:
> > Certainly reliance on "acpismp=force" should be removed if 
> it's crept
> > back in.  But what should we do about "noht"?  Wave a fond goodbye,
> > and remove it's associated code and Documentation from 2.4 and 2.5
> > trees, rely on changing the BIOS setting instead?  Or bring it back
> > into action?
> 
> for 2.4 it's no problem to honor it really code wise; and it's
> useful for machines where you can't disable HT in the bios but where
> your particular workload doesn't positively benefit from HT.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
