From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: _OSI boot hang
Date: Wed, 17 Mar 2004 14:36:23 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040317143519.N3595@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB748@PDSMSX403.ccr.corp.intel.com>
  <20040311200031.J67848@root.org>  <1079073556.3868.37.camel@dhcppc4>
 <1079166150.2168.94.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079166150.2168.94.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 13 Mar 2004, Len Brown wrote:
> _OSI is in the ACPI patch on kernel.org and bkbits right now.
>
> However, I find that on my Toshiba Satellite Pro, it causes boot to hang
> at Executing all Device _STA and_INI methods.
>
> >From ACPICA, it comes this way:
> drivers/acpi/utilities/utglobal.c
> const char
> *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS] = {
>                        "Linux",
>                        "Windows 2000",
>                        "Windows 2001",
>                        "Windows 2001.1"};

That's not the right string for Win2k.  It's:
  "Microsoft Windows NT"

Since this is the most popular string, not emulating it is probably
causing some people problems.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
