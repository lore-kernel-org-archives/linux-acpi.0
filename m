From: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Linux 2.4.23-pre8
Date: Fri, 24 Oct 2003 10:43:48 -0200 (BRST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310241019050.1354-100000@logos.cnet>
References: <1066934045.3864.2.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1066934045.3864.2.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, David van Hoose <david.vanhoose-Wuw85uim5zDR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On 23 Oct 2003, Len Brown wrote:

> David,
> best if you can file a bug and attach the info there --
> i sifted through my e-mail but i'm not sure which
> one this e-mail refers to.
> 
> thanks,
> -Len
> 
> Please file a bug at http://bugzilla.kernel.org/
> Category: Power Management
> Component: ACPI
> 
> Please attach the output from dmidecode, available in /usr/sbin/, or
> here:
> http://www.nongnu.org/dmidecode/
> 
> Please attach the output from acpidmp, available in /usr/sbin/, or in
> here
> http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
> 
> Please attach /proc/interrupts and the dmesg output showing the failure,
> if possible.

David already did it... its bug number 1283.

It seems the problem is caused by sharing USB interrupt with ACPI 
interrupt.

However, it seems the correct thing to use is IRQ20 for the USB
controller, not IRQ9, yes? 

David, what /proc/interrupts looks like in 2.6?




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
