From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: stack overflow
Date: 09 Mar 2004 02:17:30 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078816650.2342.547.camel@dhcppc4>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA4@ausx2kmpc106.aus.amer.dell.com>
	 <20040308182630.GB9490@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040308182630.GB9490-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Stuart_Hayes-DYMqY+WieiM@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stuart,
Does CONFIG_ACPI_DEBUG change the results of your measurements?

Is it possible to run an i386 kernel on the same system to see if we've
got an x86_64-specific issue?

There is some run-time stack tracing code in ACPI (see
acpi_gbl_lowest_stack_pointer) but it hasn't been used in a while.

thanks,
-Len

On Mon, 2004-03-08 at 13:26, Andi Kleen wrote:
> > Here are some of the reasons I believe the stack is overflowing:
> > 
> > I've added some "printk"s to the kernel, and I've found that the stack pointer 
> > goes down by ~6K between namespace/nseval.c:acpi_ns_evaluate_relative() and 
> > executer/exstore.c:acpi_ex_store().
> 
> The usual way to start is do 
> 
> 	objdump -S <acpi object modules> | grep sub.*rsp
> 
> then sort by the biggest stack pigs and fix them one by one (e.g.
> by kmallocing local data instead of allocating it on the stack)
> When afterwards the problem still occurs it is most likely recursion or 
> to deep nesting.  I have an old 2.4 patch that can catch these, but it 
> would need porting to 2.6.
> 
> -Andi
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
