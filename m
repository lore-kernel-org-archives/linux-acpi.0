From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Changing IRQ`s at DSDT
Date: Tue, 30 Sep 2003 12:15:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309301215.13202.adq_dvb@lidskialf.net>
References: <3F780D1A.20908@paceblade.com> <200309291937.53825.adq_dvb@lidskialf.net> <3F793B88.60104@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F793B88.60104-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> hmm .. this patch doenst change too much ... .it only let run that code
> in the else {} ?? right ?

yeah

> i used it but didnt found any difference ... all the IRQ`s which are
> active stay active and i cannot change them
> with my DSDT ...
>
> is there a way to not mark them as active and then be able to change
> them like i want ???

Hmm, which bit of the DSDT are you changing them in? The _PRT? Try checking 
out the _CRS method as well.. sometimes it is hardcoded to always return the 
same value.

_CRS is also how you mark an IRQ as active... if it returns nonzero, the code 
assumes the BIOS allocated it (and that patch makes it not mess with it).




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
