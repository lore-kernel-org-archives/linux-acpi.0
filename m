From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Stall semantics
Date: Wed, 1 Oct 2003 18:16:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001171657.GW24824@parcelfarce.linux.theplanet.co.uk>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DAF@orsmsx405.jf.intel.com> <20031001093943.J85056@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031001093943.J85056-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 01, 2003 at 09:59:49AM -0700, Nate Lawson wrote:
> Let me quote that line again:
> > Because of this, delays longer than 100 microseconds must use Sleep
> > instead of Stall.
> 
> The current code is incorrect.  It uses Stall (i.e. a delay loop) for
> waits of up to 1000 us, not 100 us like the standard.  My patch makes the
> code match the standard.
> 
> Your point is whether Sleep should automatically be called by OSPM when
> the AML specifies a Stall of more than a certain amount (let's stick to
> 100 us for this example).  I believe OSPM can and should automatically
> call Sleep when the time requested exceeds the maximum for Stall.  Look at
> that line again.  The key word is "use".  If OSPM automatically translates
> the call, delays longer than 100 us will indeed _use_ Sleep instead of
> Stall.  This gives correct, standard behavior even when the AML didn't
> originally match the standard.

Hang on though.  We've got two contradictory requirements from the
combination of the AML and the Specification.  You've chosen one
requirement over the other without discussion.  I think an equally valid
interpretation is "This code must not relinquish the CPU", in which case,
it would conform to the specification to Stall for only 100us and then
return to the AML.

Fundamentally, we're outside the specification and into nasal demon
territory.  We can do whatever we like.  The question is: what to do that
will break the least number of machines.  Sleeping unexpectedly can easily
break code -- this is why you can't schedule while holding a spinlock,
for example.  Of course, Stalling for too long is also a bad idea.

I think the current ACPI behaviour is probably adequate -- accommodate
incopetent BIOS writers up to a point, then sleep, and damn them anyway.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
