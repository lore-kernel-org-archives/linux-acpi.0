From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sun, 4 Apr 2004 01:06:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404040106.15621.dtor_core@ameritech.net>
References: <1081044549.2179.281.camel@localhost.localdomain> <200404040029.12359.dtor_core@ameritech.net> <1081058079.2239.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081058079.2239.15.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 04 April 2004 12:54 am, Karl Hegbloom wrote:
> On Sat, 2004-04-03 at 21:29, Dmitry Torokhov wrote:
> > On Sunday 04 April 2004 12:16 am, Karl Hegbloom wrote: 
> > > Is there any reason why the ACPI code cannot cache that info, rather
> > > than looking it up each time the /proc file is accessed?  (which is what
> > > I think it does now... am I right?)
> >
> > It sort of does.. that's why there /proc/acpi/battery/BATX/info (slow access,
> > mostly static data) and /proc/acpi/battery/BATX/state. Now if only
> > applications weren't reading both of them all the time...
> 
> But the thing is that the kernel can know when a battery gets jacked in,
> removed, or swapped for a fresh one, but a user space application
> cannot.

It can, the kernel signals when a battery is inserted or removed through
/proc/acpi/event (normally acpid listens on it). The only change that may be
needed is to allow multiple applications read /proc/acpi/event simultaneously,
right now it only allows exclusive access.

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
