From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sat, 03 Apr 2004 21:54:39 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081058079.2239.15.camel@localhost.localdomain>
References: <1081044549.2179.281.camel@localhost.localdomain>
	 <200404032336.39468.dtor_core@ameritech.net>
	 <1081055767.2239.7.camel@localhost.localdomain>
	 <200404040029.12359.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404040029.12359.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-04-03 at 21:29, Dmitry Torokhov wrote:
> On Sunday 04 April 2004 12:16 am, Karl Hegbloom wrote: 
> > Is there any reason why the ACPI code cannot cache that info, rather
> > than looking it up each time the /proc file is accessed?  (which is what
> > I think it does now... am I right?)
>
> It sort of does.. that's why there /proc/acpi/battery/BATX/info (slow access,
> mostly static data) and /proc/acpi/battery/BATX/state. Now if only
> applications weren't reading both of them all the time...

But the thing is that the kernel can know when a battery gets jacked in,
removed, or swapped for a fresh one, but a user space application
cannot.  If the application caches that information, there needs to be a
way for the kernel to notify it of a battery change.  But if the kernel
caches it, reading the battery information only when a new battery is
inserted, then returning that cached information on read of the "info"
file, the application need not concern itself with such things, and the
read can happen quickly.  Obviously the state information must be
updated each time it is requested.

-- 
If you feel like the machines are conspiring against you,
then it's time to perspire against the machines.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
