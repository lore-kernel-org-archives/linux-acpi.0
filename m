From: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Subject: Re: acpi on new gateway laptops
Date: Mon, 8 Dec 2003 17:19:15 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0312081716110.5824-100000@data.upl.cs.wisc.edu>
References: <20031117104936.N60907@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031117104936.N60907-Y6VGUYTwhu0@public.gmane.org>
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



On Mon, 17 Nov 2003, Nate Lawson wrote:
> Get the data from the DSDT.  Dump it with acpidmp, search for PNP0C09,
> then write down the resources.  Mine is below:
>
>                 Device (EC)
>                 {
>                     Name (_HID, EisaId ("PNP0C09"))
>                     Name (_UID, 0x00)
>                     Name (_GPE, 0x1C)
>                     ...
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
>                         IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
>                     })
>                 }


As mentioned before, I'm trying to get the embedded controller working on
a Gateway 400VTX. I've dumped the DSDT but see no "Device (EC)" section,
nor does "PNP0C09"  appear in the DSDT. Does this mean this laptop has no
embedded controller?

-casey




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
