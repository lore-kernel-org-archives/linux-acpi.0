From: john stultz <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Thu, 18 Mar 2004 13:05:30 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079643929.5408.71.camel@cog.beaverton.ibm.com>
References: <16471.43776.178128.198317@wombat.chubb.wattle.id.au>
	 <200403162340.57546.dtor_core@ameritech.net>
	 <20040317095314.GB14983@dominikbrodowski.de>
	 <20040317145312.X3595@root.org>
	 <20040318085133.GA15526@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040318085133.GA15526-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, Peter Chubb <peter-LkDQP0DxSMGxwJ88Py/mJxCuuivNXqWP@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-03-18 at 00:51, Dominik Brodowski wrote:
> On Wed, Mar 17, 2004 at 02:56:27PM -0800, Nate Lawson wrote:
> > Instead of all this gymnastics, how about:
> 
> It's not so much gymnastics -- implementing different handling for cpufreq
> drivers which do not affect the TSC is easy. It's just difficult to get to
> know what drivers/CPUs are affected... and the test run you did yesterday
> helped in evaluating this. Thanks for doing so.
>  
> > 1. If using Px states, state is unknown until first "set" event.
> 
> Normally, when using cpufreq drivers the original state is known -- only the
> ACPI spec has this severe flaw, but there are tries for a workaround [patch
> is submitted]
> 
> > 2. Implement priorities for time source selection and a generic timer API.
> > This gets around the need to get the clock rate correct to have system
> > timers work.  On FreeBSD, this is /sys/kern/kern_tc.c
> 
> IIRC, John Stultz intends to do a major upgrade of the timing code in 2.7.

Well, we already have time source selection in 2.6 for i386. Most other
arches have a single stable time source, so its not as critical for
them. As for 2.7, a couple of holes have been poked in my initial
design, so any major rewrite is somewhat on hold. Moving more arches to
the more generic time_interpolator interface that ia64 uses may be the
best solution, although its not as clean as I'd really like.

thanks
-john




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
