From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Sat, 10 Apr 2004 14:36:01 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081596961.23299.24.camel@t40>
References: <1081373781.23176.30.camel@t40>
	 <1081376023.2748.15.camel@patsy.fc.hp.com>
	 <20040408172548.GH18329@parcelfarce.linux.theplanet.co.uk>
	 <1081445594.2747.8.camel@patsy.fc.hp.com>  <1081536489.23178.113.camel@t40>
	 <1081537087.2694.8.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081537087.2694.8.camel-Wmjt7DDUnIVxnVILBQAtiA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

I found this in scan.c:
/*
 * If the device is present, enabled, and functioning then
 * parse its scope (depth-first).  Note that we need to
 * represent absent devices to facilitate PnP notifications
 * -- but only the subtree head (not all of its children,
 * which will be enumerated when the parent is inserted).
 *
 * TBD: Need notifications and other detection mechanisms
 *      in place before we can fully implement this.
 */

This can be the reason I don't see the subdevices in DOCK but only the
DOCK, when the dock is not active. So till someone does the TBD, this is
the normal behaviour, ie subdevices don't show up unless the parent is
active at scan time.

What do you think ?



On Fri, 2004-04-09 at 21:58, Alex Williamson wrote:
> On Fri, 2004-04-09 at 12:48, Paul Ionescu wrote:
> > Hi Alex,
> > 
> > Do you have any ideea why I don't have IDE1, CBS2 and CBS3 in the tree
> > even if they are present in the DSDT ?
> > They appear only when I boot in the dock.
> 
>    No, I don't.  You can try adding chunks of code like this in the scan
> file:
> 
> {
>         char pathname[ACPI_PATHNAME_MAX] = {0};
>         struct acpi_buffer buffer = {0, NULL};
>         buffer.length = sizeof(pathname);
>         buffer.pointer = pathname;
>         acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
>         printk("%s() - [%s]\n", __FUNCTION__, pathname);
> }
> 
> *Fix the handle pointer to be appropriate, everything else should be
> self contained
> 
> I'd start with adding it inside the while loop at the top of 
> drivers/acpi/scan.c:acpi_bus_scan().  It's possible it's in the DSDT,
> but not activated for some reason.  I'll be interested to hear why it's
> not showing up.  Thanks,
> 
> 	Alex



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
