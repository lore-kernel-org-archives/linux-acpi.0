From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Thinkpad R32 2.5.65-acpi
Date: Mon, 24 Mar 2003 10:37:24 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A21E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org [mailto:bperkins@netspace.org] 
> evregion-0341: *** Error: Handler for [SystemMemory] 
> 		   returned AE_BAD_PARAMETER

I think these are coming from drivers/acpi/osl.c. Can you stick some
printks in there to confirm this? I'm guessing it's either map_memory or
get_physical_address. (don't forget the { } if adding a second line to a
conditional :)

> I tried to enable ACPI debugging selectively so I might trace what was
> going on, but I got pretty confused and gave up.

include/acpi/acoutput.h. Looks for ACPI_DEBUG_DEFAULT (at the bottom)
and add "| ACPI_LV_VERBOSITY1", 2, or 3 depending on how much flood you
want. Recompile.

If it still overflows your dmesg buffer you can either enlarge the dmesg
buffer, or use a serial console to capture the output.

HTH -- Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
