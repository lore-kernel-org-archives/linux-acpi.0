From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: ACPI Battery Problems
Date: Fri, 04 Jul 2003 17:10:28 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <03f101c34268$501e4960$3746028e@bio.dfo.ca>
References: <20030704195241.GC7074@roadrunner.ichilton.net>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "Ian Chilton" <mailinglist-j6IF9zbmE2e9FHfhHBbuYA@public.gmane.org>
>
> I have a new Dell Inspiron 5100 notebook and I am using 2.4.21 with the
> ACPI patch from http://acpi.sourceforge.net.
>
> I can't get it to show the battery status - all I get is this:
>
> [root@delta:~]# acpi -V
>      Thermal 1: ok, 40.0 degrees C
>   AC Adapter 1: off-line
...
> ACPI: AC Adapter [ACAD] (off-line)
>     ACPI-0352: *** Error: Looking up [Z000] in namespace, AE_NOT_FOUND
>     ACPI-1121: *** Error: Method execution failed
> [\_SB_.PCI0.LPC0.BAT1._BIF] (Node c1594a80), AE_NOT_FOUND
>
> Any ideas?

yeah, your DSDT is just as broken as every other Dell DSDT I've heard of.  I
never have managed to properly fix mine (Inspiron 2500).  And as long as your
battery method is broken it's always going to shut down precipitously when the
battery runs out...



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
