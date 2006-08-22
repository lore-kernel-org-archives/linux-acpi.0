From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Freeing ACPI tables after parsing
Date: Tue, 22 Aug 2006 13:28:58 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4CE6F9E@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53617 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932106AbWHVU3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2006 16:29:08 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org, Natalie.Protasevich@unisys.com

> Actually FACS table has a global_lock in it (which the BIOS writes
too),
> so it is not movable,
> and as all tables are laid contiguously in physical memory, moving
some
> and
> leaving FACS is not an option.

This is a very good point. The Global_Lock field of the FACS is not a
pointer to the global lock, it is the actual memory location of the
lock. Therefore, the FACS can only be mapped, it cannot be copied.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
> Sent: Tuesday, August 22, 2006 3:01 AM
> To: Len Brown
> Cc: Andi Kleen; linux-acpi@vger.kernel.org;
Natalie.Protasevich@unisys.com
> Subject: Re: Freeing ACPI tables after parsing
> 
> Len Brown wrote:
> > On Monday 21 August 2006 18:06, Andi Kleen wrote:
> >
> >>> Why does the kexec kernel care what physical memory it is loaded
into,
> >> At least the one in SLES10 was linked to a fixed address
(64MB@64MB)
> >> In the future it will be relocatable, but still there will be
defaults
> >> passed in advance.
> >>
> >> Unisys ended up fixing it with a new BIOS, but I can well see this
> >> happening again.
> >
> > Okay, good to know this is not urgent.  I think we should proceed
with
> our
> > 1-copy-of-the-tables change, and we can independently change it
later to
> > copy them and reclaim the original space if that turns out to work.
> >
> >>> and how can it be guaranteed that address is not reserved by the
> platform firmware?
> >> I don't think there is a fool proof method right now, just
heuristics
> >> However freeing ACPI would avoid some of the potential problems.
> >>
> >>>> Also on other systems the ACPI tables are not
> >>>> exactly at the end but in the middle of the memory map and for
some
> applications
> >>>> it might be better to have a lot of physical continuous memory.
> >>>>
> >>>> So are there any plans to free the BIOS supplied ACPI tables
after
> parsing
> >>>> or is there some obstacle to that that I'm missing?
> >>> As Alexey wrote, he and Bob have already deleted the kernel's new
copy
> >>> of the tables in favor of using them 'in place'.
> >>>
> >>> I guess I'm not clear on the requirement here.
> >>> If we were to alter that plan to make a kernel copy -- and release
the
> original BIOS memory --
> >>> assuming it is marked such that we can release it -- how do we
know
> that
> >>> we are not dropping the new copy someplace that kexec doesn't want
it?
> >> There are other allocations anyways and the allocators tend to
cluster,
> so one would
> >> assume it ends up being ok. If there are conflicts they can be
handled
> in
> >> one single place in Linux. But Linux can't affect the BIOS' choice
of
> table
> >> placement.
> >>
> >> Also I suspect the kernel can store it more efficiently in memory.
When
> the tables
> >> are reserved in memory they will be always rounded up/down to page
> boundaries,
> >> while a kernel allocation can fit it better. At least for some of
them
> (like fadt)
> >> the kernel seems to use globals already too, so the original
mapping
> wouldn't be
> >> needed.
> >
> > This  trade-off may not be risk-free.
> > I expect that if Windows tests that the BIOS marks the region
properly
> > and frees it, then Linux will be able to also.  Otherwise Linux will
> fight
> > a BIOS battle it can't win w/o Windows acting as a BIOS validation
test
> for us.
> 
> Actually FACS table has a global_lock in it (which the BIOS writes
too),
> so it is not movable,
> and as all tables are laid contiguously in physical memory, moving
some
> and
> leaving FACS is not an option.
> 
> Regards,
> 	Alex.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
