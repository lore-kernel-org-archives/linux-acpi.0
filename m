From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: stack overflow
Date: Wed, 10 Mar 2004 14:32:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040310133208.GC12272@wotan.suse.de>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA4@ausx2kmpc106.aus.amer.dell.com> <1078893223.2346.585.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1078893223.2346.585.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stuart_Hayes-DYMqY+WieiM@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 09, 2004 at 11:33:43PM -0500, Brown, Len wrote:
> On Mon, 2004-03-08 at 11:43, Stuart_Hayes-DYMqY+WieiM@public.gmane.org wrote:
> 
> > If I disable local interrupts while the ACPI stuff is being initialized, it 
> > seems to make it through without failing.
> 
> hmmm, i wonder if the failure happens when ACPI is interrupted, or if
> there is an issue with some ACPI code running in an interrupt?

x86-64 has separate interrupt stacks, interrupts shouldn't be a problem.

> More interesting, perhaps, would be adding debugging code to
> "gracefully" check for this failure.  There must be such DEBUG code
> already built into the kernel someplace.

I have a patch for x86-64 (for 2.4, but could be ported). But it's 
quite a slow down because it instruments every function.

If you have some recursion either fix it or at least add an error
out when the stack gets too low. We can add an "stack_left" function
exported by the architecture.

> 
> Sorting the list of stack frame sizes below shows
> acpi_evaluate_integer() is the winner with 320 bytes on the stack.  Note
> that this isn't from passing structures, but from allocating local
> structures.  On i386 acpi_parse_object is 124 bytes, on x86_64 it will
> be bigger...

I would suggest to fix anything > 100 bytes at least 
(and double check anything that could be expanded on 64bit) 

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
