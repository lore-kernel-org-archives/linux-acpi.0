From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH 6/7] ACPI: Page based coalescing of I/O remappings
 optimization
Date: Fri, 22 Oct 2010 10:27:06 -0600
Message-ID: <1287764826.2469.132.camel@zim>
References: <20101021201916.9220.5711.stgit@bob.kio>
	 <20101021202414.9220.71053.stgit@bob.kio>
	 <1287709434.2862.25.camel@yhuang-dev>  <1287717834.2564.81.camel@zim>
	 <1287724625.2862.78.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:19692 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab0JVQ1I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2010 12:27:08 -0400
In-Reply-To: <1287724625.2862.78.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>

On Fri, 2010-10-22 at 13:17 +0800, Huang Ying wrote:
> On Fri, 2010-10-22 at 11:23 +0800, Myron Stowe wrote:
> > On Fri, 2010-10-22 at 09:03 +0800, Huang Ying wrote:
> > > Hi, Myron,
> > > 
<snip>
> > > 
> > > Why not check the existing map (that is, acpi_map_lookup()) before the
> > > ioremap()? In APEI tables, several GAS may be in same page, so we need
> > > ioremap() for the first page only.
> > 
> > Yes, even in other instances, several registers (GAS) may reside within
> > the same page(s) of a previously, still active, ioremapping and thus
> > only one ioremapping needs to be in place (with the subsequent
> > mapping(s) that fall within the same page(s) of the existing, active,
> > remapping then only needing to increment its reference).
> > 
> > 
> > In the existing implementation - atomicio.c:acpi_pre_map() - there is a
> > check at the beginning of the routine to see if a new mapping fits
> > within the page(s) of a previous entry's page(s) that is still active:
> > __acpi_try_ioremap().  Then later in the same routine, the same
> > __acpi_try_ioremap() check has to be made again due to a potential mp
> > race between the initial check and the insertion of a potentially new
> > entry onto the list.
> > 
> > Since the second check *must* take place,
> 
> No. If the first check succeeds, the second check is not necessary, it
> is sufficient just to increase the reference count and return the mapped
> virtual address. The first check will eliminate
> kmalloc/ioremap/iounmap/kfree for physical address has been mapped by
> previous calling.

Hay Haung:

Let's take two scenarios and see if I can express myself better why I
believe that the second check must take place.  Let's also stick with
the existing atomicio.c:acpi_pre_map() implementation for now just to
keep things simpler.


Scenario 1:  Assume that an MMIO remapping is already in place - mapping
A.  At some later point in time another call is made to map in some
other MMIO area and this mapping - mapping B - resides within the same
page(s) of mapping A which is still active, and thus, still on the list.

In this scenario, the first __acpi_try_ioremap() check will detect that
mapping B resides within mapping A, increment the reference of mapping
A, and then acpi_pre_map() short circuits out.  Things are handled
correctly and the first check nicely short circuits out so the second
check was never even reached.

Now let's take another scenario, Scenario 2: Assume that an MMIO
remapping is occurring on some processor of a MP system to put mapping A
into place (so the the processor is processing code somewhere between
"pg_off = ..." and "kref_init()").  While the processor is in the
process of putting mapping A into place it becomes blocked for any of a
number of reasons.  Another processor now runs and puts a mapping into
place - mapping C - that is equal to or greater in size than mapping A
which also encompasses the same page(s) of mapping A.  So now, at this
point in time, mapping C is on the list but mapping A is not.

At some later point in time the processor running mapping A will
continue.  It acquires the spin_lock immediately following the
"kref_init()" and must now check again to see if some other processor
put a similar mapping into place.  In this scenario, exactly such has
happened - which is why I think you put this check in place to begin
with.  The MP race is properly detected by the second
__acpi_try_ioremap() check which increments the reference of mapping C
and mapping A is backed out (iounmap/kfree).

So with the existing atomicio.c:acpi_pre_map() implementation there are
two __acpi_try_ioremap() checks.  The first check handles situations
like Scenario 1 and the second check handles situations like Scenario 2.

It was situations like Scenario 2 that I was thinking of in my initial
response when I said that the second check *must* take place.  I agree,
as indicated above, in situations like Scenario 1 the second check is
never even reached.

Hopefully I have now expressed better why I believe the second check
*must* take place?


Now back to your original question - why did I not include the first
check in the re-factoring?

My thinking was along the lines of: "Yes, the first check is nice in
that it short circuits additional remappings that match existing
mappings.  Thinking further, consider that since the second check must
still occur due to situations like Scenario 2, and, since the second
check would not only catch situations like Scenario 2 but also
additionally catches any additional remappings matching existing ones in
place like Scenario 1 - why not just keep the code simpler/smaller and
not include the first check?"

I agree that such a tack does have trade offs.  I chose to keep the code
simpler/smaller at the expense of giving up the "short circuit" benefits
that the first check provides in situations like Scenario 1.  The code,
without the first check still handles situations like Scenario 1 - just
not as efficiently (i.e. it incurs the expense of
"kmalloc/ioremap/iounmap/kfree for physical address has been mapped by
previous calling" as you properly pointed out.

With this explanation of my actions do you see any issues with such an
approach? 


Thanks for questioning as it always tends to lead towards a better
solution in the end.

Take care,

Myron
> 
> >  due to the possible race, I
> > decided to skip the initial check in the re-factored implementation
> > knowing that such a situation would ultimately still be caught by it
> > (the second check) and handled correctly: a subsequent, overlapping,
> > mapping is caught by the "tmp_map = acpi_map_lookup()" below, the
> > reference to the initial, active, remapping incremented, and the
> > overlapping mapping is "backed out".
> > 
> > Do you see any issues with such an approach?
> 
> Best Regards,
> Huang Ying
> 
> 


-- 
Myron Stowe                             HP Open Source Linux Lab (OSLL)

