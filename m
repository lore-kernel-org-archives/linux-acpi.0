From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Thu, 08 Apr 2004 10:41:47 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081442506.2747.5.camel@patsy.fc.hp.com>
References: <1081373781.23176.30.camel@t40>
	 <1081376023.2748.15.camel@patsy.fc.hp.com>  <1081439217.23176.70.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081439217.23176.70.camel-LjAuIDrFwz0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-04-08 at 09:46, Paul Ionescu wrote:
> Hi Alex,
> 
> I think I found a little bug:
> 
> cat _SB/PCI0/LCP/UART/_EJD
> gives me: _SB.PCI0.PCI1.DOC
> and it should give _SB.PCI0.PCI1.DOCK (I searched in the DSDT)
> 
> So I think that _EJD function is eating the last byte.

   Yep, I wasn't accounting for the '\0' snprintf wants to put at the
end.  If you make drivers/acpi/scan.c:parse_string() look like this it
should work:

static ssize_t
parse_string(char *buf, u32 length, char *pointer, unsigned int flags) {
	length += 2;
	return snprintf(buf, length, "%s\n", pointer);
}

I could probably just use an sprintf, but I was being paranoid that
firmware might not terminate the string.  I'll fix it in the next
version.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
