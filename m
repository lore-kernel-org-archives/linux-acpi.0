From: john stultz <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 16:46:54 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079484413.5408.56.camel@cog.beaverton.ibm.com>
References: <20040316182257.GA2734@dreamland.darkstar.lan>
	 <20040316194805.GC20014@picchio.gall.it>
	 <20040316214239.GA28289@hell.org.pl>
	 <1079479694.5408.47.camel@cog.beaverton.ibm.com>
	 <20040316233334.GA9001@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040316233334.GA9001-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-03-16 at 15:33, Dominik Brodowski wrote:
> On Tue, Mar 16, 2004 at 03:28:15PM -0800, john stultz wrote:
> > On Tue, 2004-03-16 at 13:42, Karol Kozimor wrote:
> > > Thus wrote Daniele Venzano:
> > > > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > > > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > > > > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > > > > issue seems cosmetic only, CPU frequency changes (watching
> > > > > temperature/battery life).
> > > > I can confirm, I'm seeing the same behavior. Please note that the
> > > > bogomips count gets updated, it's only the frequency that doesn't
> > > > change.
> > > 
> > > Same here with a P4-M, follow-up to John and Dmitry.
> > 
> > Hmm. This is untested, but I think this should do the trick.
> > 
> > Dominik: Is there any reason I'm not seeing why cpu_khz should only be
> > updated when using the TSC?
> 
> Is cpu_khz always correct (or, at least, nonzero) when we're reaching this 
> code path?

Using the PIT time source, cpu_khz is zero, so maybe it should be
conditional on if(cpu_khz)?

thanks
-john



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
