From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] Re: [2.5.50, ACPI] link error
Date: Mon, 9 Dec 2002 11:12:43 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Ducrot Bruno [mailto:poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 

> > I think that s4bios is nice to have. Its similar to S3 and easier to
> > set up than swsusp... It would be nice to have it.
> 
> for me:
> pros:
> -----
> 1- it is really really more easier to implement than S4;
> 2- we can even have it with 2.4 kernels (it seems that it work without
> the need of freezing processes, but I suspect that this statement
> is 'wrong' by nature).
> 
> cons:
> -----
> 1- it is much slower (especially at save time) than your swsusp;
> 2- end users must setup their systems (need to create a 
> suspend partition,
> or to keep a vfat partition as the really first one (/dev/hda1));
> 3- we use a bios function.  Actually, everything can happen...
> 
> That why I prefer swsusp at this time, or any other 
> implementation of S4 (I
> think about an implementation of S4 via LKCD).

I concur with your pros and cons. This makes me think that if S4BIOS support
ever gets added, it should get added to 2.4 only.

Regards -- Andy
