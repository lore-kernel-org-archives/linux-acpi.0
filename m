From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: Re: fix ACPI poweroff in 2.4.25-rc2
Date: Sat, 6 Mar 2004 09:52:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040306085222.GA6996@alpha.home.local>
References: <200403031117.25937.bjorn.helgaas@hp.com> <20040303194656.GV25779@parcelfarce.linux.theplanet.co.uk> <20040303202027.GA30084@alpha.home.local> <1078554086.12991.3191.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1078554086.12991.3191.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 06, 2004 at 01:21:26AM -0500, Len Brown wrote:
> Willy,
> Zwane was right, set_cpus_allowed() fixes the SMP poweroff problem.  The
> patch is here:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1141

Great ! I didn't know that set_cpus_allowed() was so easy to use !
Unfortunately I cannot test it anymore on the P4 HT because it's been
racked at a colo. But I'll try this right here on my dual athlon at least
to confirm that it still works.

BTW, I've seen in the machine_restart() code that there were some cases
were the authors prefered to use boot_cpu instead of CPU 0, perhaps because
of particular machines which boot on another CPU. Wouldn't it be better to
use boot_cpu here, since we know for sure that it can access ACPI without
problem ?

Another thing : if we do a AltGr-SysRq-O, is 'current' valid, and can we
schedule ? or are we just in an interrupt handler ? I'll try this right
here anyway.

Thanks for the good news,
Willy



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
