From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: stack overflow
Date: 10 Mar 2004 13:44:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078944286.2557.55.camel@dhcppc4>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA4@ausx2kmpc106.aus.amer.dell.com>
	 <1078893223.2346.585.camel@dhcppc4>  <20040310133208.GC12272@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040310133208.GC12272-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Stuart_Hayes-DYMqY+WieiM@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-03-10 at 08:32, Andi Kleen wrote:

> If you have some recursion either fix it or at least add an error
> out when the stack gets too low. We can add an "stack_left" function
> exported by the architecture.

I think we'll want to put some fun-time sanity checks for illegal
recursion into the interpreter.  That should be less invasive than doing
the full blown stack check -- which can be enabled as a separate DEBUG
test when needed.

> > Sorting the list of stack frame sizes below shows
> > acpi_evaluate_integer() is the winner with 320 bytes on the stack.  Note
> > that this isn't from passing structures, but from allocating local
> > structures.  On i386 acpi_parse_object is 124 bytes, on x86_64 it will
> > be bigger...
> 
> I would suggest to fix anything > 100 bytes at least 
> (and double check anything that could be expanded on 64bit) 

Agreed, Bob and I will fix the big stack users.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
