From: Heiko =?ISO-8859-1?Q?Ettelbr=FCck?= <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Using an external DSDT file with 2.4.19?
Date: 05 Sep 2002 20:07:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031249249.1377.13.camel@speedy-gonzales>
References: <1031247708.3011.50.camel@jtsdell>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1031247708.3011.50.camel-gH4hS+xkl8U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: John M Trostel <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi John,

please have a look at
http://developer.intel.com/technology/iapc/acpi/bios_override.htm

It's part of Intel's ACPI how-to and describes how to extract the dsdt
from the bios, edit it and finally get the acpi code in your kernel to
use the edited dsdt instead of the one in the bios.

Hope this helps!
Heiko

Am Don, 2002-09-05 um 19.41 schrieb John M Trostel:
> I am now trying to use an external DSDT file (file.hex) to override what
> was written in the BIOS.  Unfortunately, I can't quite figure out how to
> get this file read rather than BIOS.  I see :
> 
>  http://www.cpqlinux.com/acpi-howto.html
> 
> but don't see how this will apply against the current 2.4.19 stuff.
> 
> -- 
> John M. Trostel
> Senior Software Engineer
> Quantum Corp.
> john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
